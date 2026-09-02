-- ========================================
-- ИСПРАВЛЕНИЕ ОШИБКИ: division by zero
-- Исправляем функцию glm_calc_main()
-- ========================================

CREATE OR REPLACE FUNCTION actuary.glm_calc_main()
RETURNS VOID AS $$
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
    v_k1_prev NUMERIC[];
    v_k2_prev NUMERIC[];
    v_k1_curr NUMERIC[];
    v_k2_curr NUMERIC[];
    v_action_months INTEGER[];
    v_calendar_months INTEGER[];
    v_action_month INTEGER;
    v_calendar_month INTEGER;
    v_k1_value NUMERIC; -- Значение K1 для текущего индекса
    v_k2_value NUMERIC; -- Значение K2 для текущего индекса
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
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', v_n1, v_n2;
    
    WHILE v_dist > v_eps AND v_iter < v_max_iter LOOP
        v_iter := v_iter + 1;
        
        -- Обновляем K1 (по месяцам действия)
        FOR v_i IN 1..v_n1 LOOP
            v_action_month := v_action_months[v_i];
            v_s1 := 0;
            v_s2 := 0;
            
            FOR v_j IN 1..v_n2 LOOP
                v_calendar_month := v_calendar_months[v_j];
                
                -- ИСПРАВЛЕНИЕ: проверяем, что знаменатель не равен нулю
                v_k2_value := v_k2_curr[v_j];
                
                -- Если K2 = 0, пропускаем эту комбинацию (деление на ноль)
                IF v_k2_value != 0 THEN
                    SELECT 
                        COALESCE(SUM(s / v_k2_value), 0),
                        COALESCE(SUM(v), 0)
                    INTO v_s1, v_s2
                    FROM temp_matrix
                    WHERE "Месяц действия" = v_action_month
                      AND "Месяц календарный" = v_calendar_month;
                END IF;
            END LOOP;
            
            IF v_s2 > 0 THEN
                v_k1_curr[v_i] := v_s1 / v_s2;
            ELSE
                v_k1_curr[v_i] := 1; -- Если нет данных, оставляем 1
            END IF;
        END LOOP;
        
        -- Обновляем K2 (по календарным месяцам)
        FOR v_j IN 1..v_n2 LOOP
            v_calendar_month := v_calendar_months[v_j];
            v_s1 := 0;
            v_s2 := 0;
            
            FOR v_i IN 1..v_n1 LOOP
                v_action_month := v_action_months[v_i];
                
                -- ИСПРАВЛЕНИЕ: проверяем, что знаменатель не равен нулю
                v_k1_value := v_k1_curr[v_i];
                
                -- Если K1 = 0, пропускаем эту комбинацию (деление на ноль)
                IF v_k1_value != 0 THEN
                    SELECT 
                        COALESCE(SUM(s / v_k1_value), 0),
                        COALESCE(SUM(v), 0)
                    INTO v_s1, v_s2
                    FROM temp_matrix
                    WHERE "Месяц действия" = v_action_month
                      AND "Месяц календарный" = v_calendar_month;
                END IF;
            END LOOP;
            
            IF v_s2 > 0 THEN
                v_k2_curr[v_j] := v_s1 / v_s2;
            ELSE
                v_k2_curr[v_j] := 1; -- Если нет данных, оставляем 1
            END IF;
        END LOOP;
        
        -- Вычисляем норму ошибки
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
$$ LANGUAGE plpgsql;
