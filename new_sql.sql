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
    v_s1 NUMERIC;
    v_s2 NUMERIC;
    v_s3 NUMERIC;
    v_vi NUMERIC;
    v_si NUMERIC;
    v_action_months INTEGER[];
    v_calendar_months INTEGER[];
    v_action_month INTEGER;
    v_calendar_month INTEGER;
    v_k1_prev NUMERIC[];
    v_k1_curr NUMERIC[];
    v_k2_prev NUMERIC[];
    v_k2_curr NUMERIC[];
    v_z_plus_i NUMERIC[];  -- Среднее Z по столбцам (календарным месяцам)
    v_z_plus_j NUMERIC[];  -- Среднее Z по строкам (месяцам действия)
    v_z_i_plus NUMERIC;    -- Z_i_plus для текущей строки
    v_z_i NUMERIC;         -- Z_i для текущей строки
    v_z_j_plus NUMERIC;    -- Z_j_plus для текущего столбца
    v_z_j NUMERIC;         -- Z_j для текущего столбца
    v_v_i_plus NUMERIC;    -- V_i_plus для текущей строки
    v_v_j_plus NUMERIC;    -- V_j_plus для текущего столбца
BEGIN
    -- Получаем уникальные месяцы действия
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO v_action_months
    FROM actuary.glm_data;
    
    -- Получаем уникальные календарные месяцы
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
    
    CREATE INDEX idx_tm_action ON temp_matrix ("Месяц действия");
    CREATE INDEX idx_tm_calendar ON temp_matrix ("Месяц календарный");
    
    -- Инициализация массивов
    v_k1_prev := array_fill(1, ARRAY[v_n1]);
    v_k1_curr := array_fill(1, ARRAY[v_n1]);
    v_k2_prev := array_fill(1, ARRAY[v_n2]);
    v_k2_curr := array_fill(1, ARRAY[v_n2]);
    v_z_plus_i := array_fill(0, ARRAY[v_n2]);
    v_z_plus_j := array_fill(0, ARRAY[v_n1]);
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', v_n1, v_n2;
    
    WHILE v_dist > v_eps AND v_iter < v_max_iter LOOP
        v_iter := v_iter + 1;
        
        -- =====================================================
        -- 1. Расчет Z_plus_i (средние по календарным месяцам)
        -- =====================================================
        FOR v_j IN 1..v_n2 LOOP
            v_calendar_month := v_calendar_months[v_j];
            v_s1 := 0;
            v_s2 := 0;
            
            FOR v_i IN 1..v_n1 LOOP
                v_action_month := v_action_months[v_i];
                
                SELECT COALESCE(v, 0), COALESCE(s, 0)
                INTO v_vi, v_si
                FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month;
                
                -- Суммируем V и S для расчета среднего Z
                v_s1 := v_s1 + v_vi;
                v_s2 := v_s2 + v_si;
            END LOOP;
            
            -- Z_plus_i(j) = S / V по столбцу j
            IF v_s1 > 0 THEN
                v_z_plus_i[v_j] := v_s2 / v_s1;
            ELSE
                v_z_plus_i[v_j] := 0;
            END IF;
        END LOOP;
        
        -- =====================================================
        -- 2. Обновляем K1 (по месяцам действия)
        -- =====================================================
        FOR v_i IN 1..v_n1 LOOP
            v_action_month := v_action_months[v_i];
            v_s1 := 0; -- Для числителя Z_i_plus
            v_s2 := 0; -- Для знаменателя V_i_plus
            v_s3 := 0; -- Для числителя Z_i
            
            FOR v_j IN 1..v_n2 LOOP
                v_calendar_month := v_calendar_months[v_j];
                
                SELECT COALESCE(v, 0), COALESCE(s, 0)
                INTO v_vi, v_si
                FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month;
                
                -- Расчет Z_i_plus (числитель для Ind1)
                IF v_vi > 0 THEN
                    v_s1 := v_s1 + v_vi * (v_si / v_vi);  -- Σ(V * Z)
                    v_s2 := v_s2 + v_vi;                   -- Σ(V)
                END IF;
                
                -- Расчет Z_i (знаменатель для Ind1)
                v_s3 := v_s3 + v_vi * v_z_plus_i[v_j];    -- Σ(V * Z_plus_i)
            END LOOP;
            
            -- Вычисляем Ind1 = Z_i_plus / Z_i
            IF v_s2 > 0 AND v_s3 > 0 THEN
                v_z_i_plus := v_s1 / v_s2;
                v_z_i := v_s3 / v_s2;
                v_k1_curr[v_i] := v_z_i_plus / v_z_i;
            ELSE
                v_k1_curr[v_i] := 1;
            END IF;
        END LOOP;
        
        -- =====================================================
        -- 3. Расчет Z_plus_j (средние по месяцам действия)
        -- =====================================================
        FOR v_i IN 1..v_n1 LOOP
            v_action_month := v_action_months[v_i];
            v_s1 := 0;
            v_s2 := 0;
            
            FOR v_j IN 1..v_n2 LOOP
                v_calendar_month := v_calendar_months[v_j];
                
                SELECT COALESCE(v, 0), COALESCE(s, 0)
                INTO v_vi, v_si
                FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month;
                
                -- Суммируем V и S для расчета среднего Z
                v_s1 := v_s1 + v_vi;
                v_s2 := v_s2 + v_si;
            END LOOP;
            
            -- Z_plus_j(i) = S / V по строке i
            IF v_s1 > 0 THEN
                v_z_plus_j[v_i] := v_s2 / v_s1;
            ELSE
                v_z_plus_j[v_i] := 0;
            END IF;
        END LOOP;
        
        -- =====================================================
        -- 4. Обновляем K2 (по календарным месяцам)
        -- =====================================================
        FOR v_j IN 1..v_n2 LOOP
            v_calendar_month := v_calendar_months[v_j];
            v_s1 := 0; -- Для числителя Z_j_plus
            v_s2 := 0; -- Для знаменателя V_j_plus
            v_s3 := 0; -- Для числителя Z_j
            
            FOR v_i IN 1..v_n1 LOOP
                v_action_month := v_action_months[v_i];
                
                SELECT COALESCE(v, 0), COALESCE(s, 0)
                INTO v_vi, v_si
                FROM temp_matrix
                WHERE "Месяц действия" = v_action_month
                  AND "Месяц календарный" = v_calendar_month;
                
                -- Расчет Z_j_plus (числитель для Ind2)
                IF v_vi > 0 THEN
                    v_s1 := v_s1 + v_vi * (v_si / v_vi);  -- Σ(V * Z)
                    v_s2 := v_s2 + v_vi;                   -- Σ(V)
                END IF;
                
                -- Расчет Z_j (знаменатель для Ind2)
                v_s3 := v_s3 + v_vi * v_z_plus_j[v_i];    -- Σ(V * Z_plus_j)
            END LOOP;
            
            -- Вычисляем Ind2 = Z_j_plus / Z_j
            IF v_s2 > 0 AND v_s3 > 0 THEN
                v_z_j_plus := v_s1 / v_s2;
                v_z_j := v_s3 / v_s2;
                v_k2_curr[v_j] := v_z_j_plus / v_z_j;
            ELSE
                v_k2_curr[v_j] := 1;
            END IF;
        END LOOP;
        
        -- =====================================================
        -- 5. Вычисляем норму ошибки
        -- =====================================================
        v_dist := actuary.glm_norma(
            v_k1_curr, v_k1_prev,
            v_k2_curr, v_k2_prev,
            v_n1, v_n2
        );
        
        v_k1_prev := v_k1_curr;
        v_k2_prev := v_k2_curr;
        
        IF v_iter % 100 = 0 THEN
            RAISE NOTICE 'Итерация %, ошибка: %', v_iter, v_dist;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Расчет завершен. Итераций: %, ошибка: %', v_iter, v_dist;
    
    -- Сохраняем K1
    FOR v_i IN 1..v_n1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (v_action_months[v_i], v_k1_curr[v_i]);
    END LOOP;
    
    -- Сохраняем K2
    FOR v_j IN 1..v_n2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (v_calendar_months[v_j], v_k2_curr[v_j]);
    END LOOP;
    
    UPDATE actuary.glm_result SET "Базовая частота" = 1;
    
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Результаты сохранены.';
END;
$function$;
