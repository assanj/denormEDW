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
    v_max_iter INTEGER := 1000;
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
    
    -- Временные массивы для расчетов
    v_v_i_plus NUMERIC[];
    v_v_j_plus NUMERIC[];
    v_z_i_plus NUMERIC[];
    v_z_j_plus NUMERIC[];
    v_z_i NUMERIC[];
    v_z_j NUMERIC[];
    
    v_sum1 NUMERIC;
    v_sum2 NUMERIC;
    v_sum3 NUMERIC;
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
            
            -- Вычисляем Z как S/V
            IF v_vi > 0 THEN
                v_z[v_i][v_j] := v_si / v_vi;
            ELSE
                v_z[v_i][v_j] := 0;
            END IF;
        END LOOP;
    END LOOP;
    
    -- Инициализация массивов индексов
    v_k1_prev := array_fill(1, ARRAY[v_n1]);
    v_k1_curr := array_fill(1, ARRAY[v_n1]);
    v_k2_prev := array_fill(1, ARRAY[v_n2]);
    v_k2_curr := array_fill(1, ARRAY[v_n2]);
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', v_n1, v_n2;
    
    -- Итеративный процесс
    WHILE v_dist > v_eps AND v_iter < v_max_iter LOOP
        v_iter := v_iter + 1;
        
        -- 1. Обновляем K1 (по месяцам действия)
        FOR v_i IN 1..v_n1 LOOP
            -- Вычисляем V_i_plus - сумма по строке
            v_sum2 := 0;
            FOR v_j IN 1..v_n2 LOOP
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            -- Вычисляем Z_i_plus - взвешенное среднее по строке
            v_sum1 := 0;
            FOR v_j IN 1..v_n2 LOOP
                IF v_v[v_i][v_j] > 0 THEN
                    v_sum1 := v_sum1 + v_v[v_i][v_j] * (v_s[v_i][v_j] / v_v[v_i][v_j]);
                END IF;
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_z_i_plus := v_sum1 / v_sum2;
            ELSE
                v_z_i_plus := 0;
            END IF;
            
            -- Вычисляем Z_plus_i для каждого столбца
            v_z_i := 0;
            FOR v_j IN 1..v_n2 LOOP
                -- Сначала вычисляем Z_plus_i(j) - взвешенное среднее по столбцу j
                v_sum1 := 0;
                v_sum2 := 0;
                FOR v_ii IN 1..v_n1 LOOP
                    IF v_v[v_ii][v_j] > 0 THEN
                        v_sum1 := v_sum1 + v_v[v_ii][v_j] * (v_s[v_ii][v_j] / v_v[v_ii][v_j]);
                        v_sum2 := v_sum2 + v_v[v_ii][v_j];
                    END IF;
                END LOOP;
                
                IF v_sum2 > 0 THEN
                    v_z_plus_i := v_sum1 / v_sum2;
                ELSE
                    v_z_plus_i := 0;
                END IF;
                
                -- Добавляем к Z_i
                v_z_i := v_z_i + v_v[v_i][v_j] * v_z_plus_i;
            END LOOP;
            
            -- Нормализуем Z_i
            v_sum2 := 0;
            FOR v_j IN 1..v_n2 LOOP
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_z_i := v_z_i / v_sum2;
            ELSE
                v_z_i := 1;
            END IF;
            
            -- Обновляем K1
            IF v_z_i > 0 THEN
                v_k1_curr[v_i] := v_z_i_plus / v_z_i;
            ELSE
                v_k1_curr[v_i] := 1;
            END IF;
        END LOOP;
        
        -- 2. Обновляем K2 (по календарным месяцам)
        FOR v_j IN 1..v_n2 LOOP
            -- Вычисляем V_j_plus - сумма по столбцу
            v_sum2 := 0;
            FOR v_i IN 1..v_n1 LOOP
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            -- Вычисляем Z_j_plus - взвешенное среднее по столбцу
            v_sum1 := 0;
            FOR v_i IN 1..v_n1 LOOP
                IF v_v[v_i][v_j] > 0 THEN
                    v_sum1 := v_sum1 + v_v[v_i][v_j] * (v_s[v_i][v_j] / v_v[v_i][v_j]);
                END IF;
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_z_j_plus := v_sum1 / v_sum2;
            ELSE
                v_z_j_plus := 0;
            END IF;
            
            -- Вычисляем Z_plus_j для каждой строки
            v_z_j := 0;
            FOR v_i IN 1..v_n1 LOOP
                -- Сначала вычисляем Z_plus_j(i) - взвешенное среднее по строке i
                v_sum1 := 0;
                v_sum2 := 0;
                FOR v_jj IN 1..v_n2 LOOP
                    IF v_v[v_i][v_jj] > 0 THEN
                        v_sum1 := v_sum1 + v_v[v_i][v_jj] * (v_s[v_i][v_jj] / v_v[v_i][v_jj]);
                        v_sum2 := v_sum2 + v_v[v_i][v_jj];
                    END IF;
                END LOOP;
                
                IF v_sum2 > 0 THEN
                    v_z_plus_j := v_sum1 / v_sum2;
                ELSE
                    v_z_plus_j := 0;
                END IF;
                
                -- Добавляем к Z_j
                v_z_j := v_z_j + v_v[v_i][v_j] * v_z_plus_j;
            END LOOP;
            
            -- Нормализуем Z_j
            v_sum2 := 0;
            FOR v_i IN 1..v_n1 LOOP
                v_sum2 := v_sum2 + v_v[v_i][v_j];
            END LOOP;
            
            IF v_sum2 > 0 THEN
                v_z_j := v_z_j / v_sum2;
            ELSE
                v_z_j := 1;
            END IF;
            
            -- Обновляем K2
            IF v_z_j > 0 THEN
                v_k2_curr[v_j] := v_z_j_plus / v_z_j;
            ELSE
                v_k2_curr[v_j] := 1;
            END IF;
        END LOOP;
        
        -- Вычисляем ошибку
        v_dist := actuary.glm_norma(
            v_k1_curr, v_k1_prev,
            v_k2_curr, v_k2_prev,
            v_n1, v_n2
        );
        
        v_k1_prev := v_k1_curr;
        v_k2_prev := v_k2_curr;
        
        IF v_iter % 10 = 0 THEN
            RAISE NOTICE 'Итерация %, ошибка: %', v_iter, v_dist;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Расчет завершен. Итераций: %, ошибка: %', v_iter, v_dist;
    
    -- Сохраняем результаты
    FOR v_i IN 1..v_n1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (v_action_months[v_i], v_k1_curr[v_i]);
    END LOOP;
    
    FOR v_j IN 1..v_n2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (v_calendar_months[v_j], v_k2_curr[v_j]);
    END LOOP;
    
    RAISE NOTICE 'Результаты сохранены.';
END;
$function$;


SQL Error [42601]: ERROR: "v_z_plus_i" is not a known variable
  Position: 4443
  ERROR: "v_z_plus_i" is not a known variable
  Position: 4443
