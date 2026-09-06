CREATE OR REPLACE FUNCTION actuary.glm_calc_main()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_n1 INTEGER;
    v_n2 INTEGER;
    v_eps NUMERIC := 0.000001;
    v_dist NUMERIC := 1;
    v_iter INTEGER := 0;
    v_max_iter INTEGER := 10000;
    v_i INTEGER;
    v_j INTEGER;
    v_action_months INTEGER[];
    v_calendar_months INTEGER[];
    v_action_month INTEGER;
    v_calendar_month INTEGER;
    
    -- Массивы для данных
    v_v NUMERIC[][];
    v_s NUMERIC[][];
    v_z NUMERIC[][];
    
    -- Массивы для индексов
    v_k1_prev NUMERIC[];
    v_k1_curr NUMERIC[];
    v_k2_prev NUMERIC[];
    v_k2_curr NUMERIC[];
    
    -- Массивы для F1, F2
    v_f1 INTEGER[];
    v_f2 INTEGER[];
    
    -- Временные переменные
    v_sum1 NUMERIC;
    v_sum2 NUMERIC;
    v_vi NUMERIC;
    v_si NUMERIC;
BEGIN
    -- Получаем уникальные месяцы
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO v_action_months
    FROM actuary.glm_data;
    
    SELECT ARRAY_AGG(DISTINCT "Месяц календарный" ORDER BY "Месяц календарный")
    INTO v_calendar_months
    FROM actuary.glm_data;
    
    v_n1 := COALESCE(array_length(v_action_months, 1), 0);
    v_n2 := COALESCE(array_length(v_calendar_months, 1), 0);
    
    IF v_n1 = 0 OR v_n2 = 0 THEN
        RAISE NOTICE 'Нет данных для расчета';
        RETURN;
    END IF;

    -- Создаем временную матрицу данных
    DROP TABLE IF EXISTS temp_matrix;
    CREATE TEMP TABLE temp_matrix AS
    SELECT 
        "Месяц действия",
        "Месяц календарный",
        "Exp" AS v,
        "MCL" AS s
    FROM actuary.glm_data;

    -- Инициализация матриц
    v_v := array_fill(0, ARRAY[v_n1, v_n2]);
    v_s := array_fill(0, ARRAY[v_n1, v_n2]);
    v_z := array_fill(0, ARRAY[v_n1, v_n2]);
    
    -- Заполняем матрицы из данных
    FOR v_i IN 1..v_n1 LOOP
        v_action_month := v_action_months[v_i];
        FOR v_j IN 1..v_n2 LOOP
            v_calendar_month := v_calendar_months[v_j];
            
            SELECT COALESCE(v, 0), COALESCE(s, 0)
            INTO v_vi, v_si
            FROM temp_matrix
            WHERE "Месяц действия" = v_action_month
              AND "Месяц календарный" = v_calendar_month;
            
            v_v[v_i][v_j] := v_vi;
            v_s[v_i][v_j] := v_si;
            
            -- Вычисляем Z = S / V
            IF v_vi > 0 THEN
                v_z[v_i][v_j] := v_si / v_vi;
            ELSE
                v_z[v_i][v_j] := 0;
            END IF;
        END LOOP;
    END LOOP;
    
    -- Инициализация индексов (как в VBA: tempK1=1, tempK2=1, K2=1)
    v_k1_prev := array_fill(1, ARRAY[v_n1]);
    v_k1_curr := array_fill(1, ARRAY[v_n1]);
    v_k2_prev := array_fill(1, ARRAY[v_n2]);
    v_k2_curr := array_fill(1, ARRAY[v_n2]);
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', v_n1, v_n2;
    
    -- Итеративный процесс (как в VBA)
    WHILE v_dist > v_eps AND v_iter < v_max_iter LOOP
        v_iter := v_iter + 1;
        
        -- Обновляем K1 (по месяцам действия)
        -- Формула: K1(i) = Σ S(i,j)/K2(j) / Σ V(i,j)
        FOR v_i IN 1..v_n1 LOOP
            v_sum1 := 0;
            v_sum2 := 0;
            
            FOR v_j IN 1..v_n2 LOOP
                IF v_k2_curr[v_j] != 0 THEN
                    v_sum1 := v_sum1 + v_s[v_i][v_j] / v_k2_curr[v_j];
                END IF;
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_k1_curr[v_i] := v_sum1 / v_sum2;
            ELSE
                v_k1_curr[v_i] := 1;
            END IF;
        END LOOP;
        
        -- Обновляем K2 (по календарным месяцам)
        -- Формула: K2(j) = Σ S(i,j)/K1(i) / Σ V(i,j)
        FOR v_j IN 1..v_n2 LOOP
            v_sum1 := 0;
            v_sum2 := 0;
            
            FOR v_i IN 1..v_n1 LOOP
                IF v_k1_curr[v_i] != 0 THEN
                    v_sum1 := v_sum1 + v_s[v_i][v_j] / v_k1_curr[v_i];
                END IF;
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_k2_curr[v_j] := v_sum1 / v_sum2;
            ELSE
                v_k2_curr[v_j] := 1;
            END IF;
        END LOOP;
        
        -- Вычисляем ошибку (норма)
        v_dist := actuary.glm_norma(
            v_k1_curr, v_k1_prev,
            v_k2_curr, v_k2_prev,
            v_n1, v_n2
        );
        
        -- Сохраняем текущие значения как предыдущие
        v_k1_prev := v_k1_curr;
        v_k2_prev := v_k2_curr;
        
        IF v_iter % 10 = 0 THEN
            RAISE NOTICE 'Итерация %, ошибка: %', v_iter, v_dist;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Расчет завершен. Итераций: %, ошибка: %', v_iter, v_dist;
    
    -- Сохраняем результаты в таблицу glm_result
    FOR v_i IN 1..v_n1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (v_action_months[v_i], v_k1_curr[v_i]);
    END LOOP;
    
    FOR v_j IN 1..v_n2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (v_calendar_months[v_j], v_k2_curr[v_j]);
    END LOOP;
    
    -- Базовая частота = 1
    UPDATE actuary.glm_result SET "Базовая частота" = 1;
    
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Результаты сохранены.';
END;
$function$;
