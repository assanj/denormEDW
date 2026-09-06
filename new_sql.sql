опять резуьттат очень похож, но не точчен.
1.индексы у меня уже расчитаны, и они ТОЧНО СЧИТАЮТСЯ верно зачем ты это зашил  опять в функцию? используй ее.
 2. почему я не вижу функцию нормы, которая тоде у меня уже есть. она правильная?
 -- DROP FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4);

CREATE OR REPLACE FUNCTION actuary.glm_norma(p_k1 numeric[], p_temp_k1 numeric[], p_k2 numeric[], p_temp_k2 numeric[], p_n1 integer, p_n2 integer)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_s1 NUMERIC := 0;  -- Сумма квадратов разностей для K1
    v_s2 NUMERIC := 0;  -- Сумма квадратов разностей для K2
    v_i INTEGER;        -- Счетчик для цикла
BEGIN
    -- Проверка: если какой-либо массив NULL, возвращаем 1 (максимальная ошибка)
    IF p_k1 IS NULL OR p_temp_k1 IS NULL OR p_k2 IS NULL OR p_temp_k2 IS NULL THEN
        RETURN 1;
    END IF;
    
    -- Вычисляем сумму квадратов разностей для K1
    -- Формула: Σ(K1[i] - tempK1[i])²
    FOR v_i IN 1..p_n1 LOOP
        -- Проверяем, что индекс существует в обоих массивах
        IF v_i <= array_length(p_k1, 1) AND v_i <= array_length(p_temp_k1, 1) THEN
            v_s1 := v_s1 + (COALESCE(p_k1[v_i], 0) - COALESCE(p_temp_k1[v_i], 0)) ^ 2;
        END IF;
    END LOOP;
    
    -- Вычисляем сумму квадратов разностей для K2
    -- Формула: Σ(K2[j] - tempK2[j])²
    FOR v_i IN 1..p_n2 LOOP
        -- Проверяем, что индекс существует в обоих массивах
        IF v_i <= array_length(p_k2, 1) AND v_i <= array_length(p_temp_k2, 1) THEN
            v_s2 := v_s2 + (COALESCE(p_k2[v_i], 0) - COALESCE(p_temp_k2[v_i], 0)) ^ 2;
        END IF;
    END LOOP;
    
    -- Возвращаем корень из суммы квадратов (евклидова норма)
    -- Формула: √(s1 + s2)
    RETURN SQRT(v_s1 + v_s2);
END;
$function$
;

-- Permissions

ALTER FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4) OWNER TO mskazakov;
GRANT ALL ON FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4) TO mskazakov;


CREATE OR REPLACE FUNCTION actuary.glm_calc_ind()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_n1 INTEGER;           -- Количество групп по месяцам действия
    v_n2 INTEGER;           -- Количество групп по календарным месяцам
    v_i INTEGER;            -- Счетчик для месяцев действия
    v_j INTEGER;            -- Счетчик для календарных месяцев
    v_sum_v NUMERIC;        -- Сумма экспозиции V
    v_sum_vz NUMERIC;       -- Сумма V * Z (взвешенный убыток)
    v_expected_z NUMERIC;   -- Ожидаемое значение Z
    v_action_month INTEGER; -- Текущий месяц действия
    v_calendar_month INTEGER; -- Текущий календарный месяц
    v_action_months INTEGER[]; -- Массив уникальных месяцев действия
    v_calendar_months INTEGER[]; -- Массив уникальных календарных месяцев
BEGIN
    -- ========================================
    -- Шаг 1: Получаем размерности и уникальные значения
    -- ========================================
    
    -- Собираем все уникальные месяцы действия в массив
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO v_action_months
    FROM actuary.glm_data;
    
    -- Собираем все уникальные календарные месяцы в массив
    SELECT ARRAY_AGG(DISTINCT "Месяц календарный" ORDER BY "Месяц календарный")
    INTO v_calendar_months
    FROM actuary.glm_data;
    
    -- Определяем количество групп
    v_n1 := COALESCE(array_length(v_action_months, 1), 0);
    v_n2 := COALESCE(array_length(v_calendar_months, 1), 0);
    
    -- Проверка наличия данных
    IF v_n1 = 0 OR v_n2 = 0 THEN
        RAISE NOTICE 'Нет данных для расчета индексов';
        RETURN;
    END IF;
    
    -- Сохраняем N1 и N2 в таблицу Ind (как в Excel)
    INSERT INTO actuary.glm_ind ("N1", "N2") VALUES (v_n1, v_n2);
    
    -- ========================================
    -- Шаг 2: Создаем временную матрицу с нормированным убытком Z = S / V
    -- ========================================
    
    DROP TABLE IF EXISTS temp_matrix;
    CREATE TEMP TABLE temp_matrix AS
    SELECT 
        "Месяц действия",
        "Месяц календарный",
        "Exp" AS v,                    -- Экспозиция (объем)
        "MCL" AS s,                    -- Убыток
        CASE 
            WHEN "Exp" > 0 THEN "MCL" / "Exp"  -- Нормированный убыток
            ELSE 0 
        END AS z
    FROM actuary.glm_data;
    
    -- Создаем индексы для ускорения запросов
    CREATE INDEX idx_tm_action ON temp_matrix ("Месяц действия");
    CREATE INDEX idx_tm_calendar ON temp_matrix ("Месяц календарный");
    
    -- ========================================
    -- Шаг 3: Расчет Ind1 (индексы по месяцам действия)
    -- ========================================
    -- Алгоритм:
    -- 1. V_i_plus = Σ V (сумма V по строке)
    -- 2. Z_i_plus = Σ(V*Z) / ΣV (средневзвешенное Z по строке)
    -- 3. Z_i = Σ(V * Z_plus_i) / ΣV (ожидаемое Z)
    -- 4. Ind1 = Z_i_plus / Z_i
    -- ========================================
    
    DROP TABLE IF EXISTS temp_ind1;
    CREATE TEMP TABLE temp_ind1 (
        "Месяц действия" INTEGER,
        "Ind1" NUMERIC
    );
    
    -- Цикл по каждому месяцу действия
    FOR v_i IN 1..v_n1 LOOP
        v_action_month := v_action_months[v_i];
        
        -- 3.1: Вычисляем V_i_plus = сумма V по строке (для данного месяца действия)
        SELECT COALESCE(SUM(v), 0) INTO v_sum_v
        FROM temp_matrix
        WHERE "Месяц действия" = v_action_month;
        
        -- 3.2: Вычисляем Z_i_plus = (сумма V * Z) / (сумма V) по строке
        -- Это средневзвешенное Z для данного месяца действия
        SELECT 
            CASE 
                WHEN COALESCE(SUM(v), 0) > 0 THEN SUM(v * z) / SUM(v)
                ELSE 0
            END INTO v_sum_vz
        FROM temp_matrix
        WHERE "Месяц действия" = v_action_month;
        
        -- 3.3: Вычисляем Z_i = сумма(V * Z_plus_i) / сумма(V)
        -- где Z_plus_i - средневзвешенное Z по столбцам (календарным месяцам)
        WITH col_avg AS (
            -- Для каждого календарного месяца вычисляем средневзвешенное Z по столбцу
            SELECT 
                "Месяц календарный",
                SUM(v) AS v_sum,
                CASE 
                    WHEN SUM(v) > 0 THEN SUM(v * z) / SUM(v)
                    ELSE 0
                END AS z_plus_i
            FROM temp_matrix
            GROUP BY "Месяц календарный"
        )
        SELECT 
            CASE 
                WHEN v_sum_v > 0 THEN SUM(tm.v * ca.z_plus_i) / v_sum_v
                ELSE 0
            END INTO v_expected_z
        FROM temp_matrix tm
        JOIN col_avg ca ON tm."Месяц календарный" = ca."Месяц календарный"
        WHERE tm."Месяц действия" = v_action_month;
        
        -- 3.4: Вычисляем Ind1 = Z_i_plus / Z_i
        INSERT INTO temp_ind1 ("Месяц действия", "Ind1")
        VALUES (
            v_action_month,
            CASE 
                WHEN v_expected_z > 0 THEN v_sum_vz / v_expected_z
                ELSE 0
            END
        );
    END LOOP;
    
    -- Сохраняем результаты Ind1 в таблицу
    INSERT INTO actuary.glm_ind ("Месяц действия", "Ind 1")
    SELECT "Месяц действия", "Ind1"
    FROM temp_ind1
    ORDER BY "Месяц действия";
    
    -- ========================================
    -- Шаг 4: Расчет Ind2 (индексы по календарным месяцам)
    -- ========================================
    -- Алгоритм аналогичен Ind1, но с перестановкой измерений:
    -- 1. V_i_plus = Σ V (сумма V по столбцу)
    -- 2. Z_i_plus = Σ(V*Z) / ΣV (средневзвешенное Z по столбцу)
    -- 3. Z_i = Σ(V * Z_plus_i) / ΣV (ожидаемое Z)
    -- 4. Ind2 = Z_i_plus / Z_i
    -- ========================================
    
    DROP TABLE IF EXISTS temp_ind2;
    CREATE TEMP TABLE temp_ind2 (
        "Месяц календарный" INTEGER,
        "Ind2" NUMERIC
    );
    
    -- Цикл по каждому календарному месяцу
    FOR v_j IN 1..v_n2 LOOP
        v_calendar_month := v_calendar_months[v_j];
        
        -- 4.1: Вычисляем V_i_plus = сумма V по столбцу (для данного календарного месяца)
        SELECT COALESCE(SUM(v), 0) INTO v_sum_v
        FROM temp_matrix
        WHERE "Месяц календарный" = v_calendar_month;
        
        -- 4.2: Вычисляем Z_i_plus = (сумма V * Z) / (сумма V) по столбцу
        SELECT 
            CASE 
                WHEN COALESCE(SUM(v), 0) > 0 THEN SUM(v * z) / SUM(v)
                ELSE 0
            END INTO v_sum_vz
        FROM temp_matrix
        WHERE "Месяц календарный" = v_calendar_month;
        
        -- 4.3: Вычисляем Z_i = сумма(V * Z_plus_i) / сумма(V)
        -- где Z_plus_i - средневзвешенное Z по строкам (месяцам действия)
        WITH row_avg AS (
            -- Для каждого месяца действия вычисляем средневзвешенное Z по строке
            SELECT 
                "Месяц действия",
                SUM(v) AS v_sum,
                CASE 
                    WHEN SUM(v) > 0 THEN SUM(v * z) / SUM(v)
                    ELSE 0
                END AS z_plus_i
            FROM temp_matrix
            GROUP BY "Месяц действия"
        )
        SELECT 
            CASE 
                WHEN v_sum_v > 0 THEN SUM(tm.v * ra.z_plus_i) / v_sum_v
                ELSE 0
            END INTO v_expected_z
        FROM temp_matrix tm
        JOIN row_avg ra ON tm."Месяц действия" = ra."Месяц действия"
        WHERE tm."Месяц календарный" = v_calendar_month;
        
        -- 4.4: Вычисляем Ind2 = Z_i_plus / Z_i
        INSERT INTO temp_ind2 ("Месяц календарный", "Ind2")
        VALUES (
            v_calendar_month,
            CASE 
                WHEN v_expected_z > 0 THEN v_sum_vz / v_expected_z
                ELSE 0
            END
        );
    END LOOP;
    
    -- Сохраняем результаты Ind2 в таблицу
    INSERT INTO actuary.glm_ind ("Месяц календарный", "Ind 2")
    SELECT "Месяц календарный", "Ind2"
    FROM temp_ind2
    ORDER BY "Месяц календарный";
    
    -- ========================================
    -- Шаг 5: Очистка временных таблиц
    -- ========================================
    
    DROP TABLE IF EXISTS temp_matrix;
    DROP TABLE IF EXISTS temp_ind1;
    DROP TABLE IF EXISTS temp_ind2;
    
    RAISE NOTICE 'Расчет индексов завершен. N1=%, N2=%', v_n1, v_n2;
END;
$function$
;

-- Permissions

ALTER FUNCTION actuary.glm_calc_ind() OWNER TO mskazakov;
GRANT ALL ON FUNCTION actuary.glm_calc_ind() TO mskazakov;
