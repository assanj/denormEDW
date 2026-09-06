CREATE OR REPLACE FUNCTION actuary.glm_calc_main()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_n1 INTEGER;
    v_n2 INTEGER;
    v_i INTEGER;
    v_j INTEGER;
    v_num INTEGER;
    v_action_months INTEGER[];
    v_calendar_months INTEGER[];
    v_action_month INTEGER;
    v_calendar_month INTEGER;
    
    -- Массивы для данных (как в VBA)
    v_v NUMERIC[][];
    v_s NUMERIC[][];
    v_z NUMERIC[][];
    
    -- Массивы для индексов (как в VBA)
    v_ind1 NUMERIC[];
    v_ind2 NUMERIC[];
    
    -- Массивы для промежуточных расчетов (как в VBA)
    v_v_plus_i NUMERIC[];
    v_v_i_plus NUMERIC[];
    v_z_plus_i NUMERIC[];
    v_z_i_plus NUMERIC[];
    v_z_i NUMERIC[];
    
    -- Вспомогательные переменные (как в VBA)
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

    -- Создаем временную таблицу
    DROP TABLE IF EXISTS temp_matrix;
    CREATE TEMP TABLE temp_matrix AS
    SELECT 
        "Месяц действия",
        "Месяц календарный",
        "Exp" AS v,
        "MCL" AS s
    FROM actuary.glm_data;

    -- Инициализация матриц (как в VBA: ReDim V(N1-1, N2-1))
    v_v := array_fill(0, ARRAY[v_n1, v_n2]);
    v_s := array_fill(0, ARRAY[v_n1, v_n2]);
    v_z := array_fill(0, ARRAY[v_n1, v_n2]);
    
    -- Заполняем матрицы (как в VBA)
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
            
            -- Вычисляем Z (как в VBA: If V(i,j) > 0 Then Z(i,j) = S(i,j) / V(i,j))
            IF v_vi > 0 THEN
                v_z[v_i][v_j] := v_si / v_vi;
            ELSE
                v_z[v_i][v_j] := 0;
            END IF;
        END LOOP;
    END LOOP;
    
    -- =============================================
    -- Расчет Ind1 (как в VBA)
    -- =============================================
    -- ReDim V_plus_i(N2-1), V_i_plus(N1-1), Z_plus_i(N2-1), Z_i_plus(N1-1), Z_i(N1-1)
    v_v_plus_i := array_fill(0, ARRAY[v_n2]);
    v_v_i_plus := array_fill(0, ARRAY[v_n1]);
    v_z_plus_i := array_fill(0, ARRAY[v_n2]);
    v_z_i_plus := array_fill(0, ARRAY[v_n1]);
    v_z_i := array_fill(0, ARRAY[v_n1]);
    v_ind1 := array_fill(0, ARRAY[v_n1]);
    
    -- For num = 0 To N1 - 1
    FOR v_num IN 1..v_n1 LOOP
        -- ' Вычисляем V_plus_i()
        FOR v_j IN 1..v_n2 LOOP
            v_v_plus_i[v_j] := 0;
            FOR v_i IN 1..v_n1 LOOP
                v_v_plus_i[v_j] := v_v_plus_i[v_j] + v_v[v_i][v_j];
            END LOOP;
        END LOOP;
        
        -- ' Вычисляем V_i_plus(num)
        v_v_i_plus[v_num] := 0;
        FOR v_j IN 1..v_n2 LOOP
            v_v_i_plus[v_num] := v_v_i_plus[v_num] + v_v[v_num][v_j];
        END LOOP;
        
        -- ' Вычисляем Z_plus_i()
        FOR v_j IN 1..v_n2 LOOP
            v_z_plus_i[v_j] := 0;
            FOR v_i IN 1..v_n1 LOOP
                v_z_plus_i[v_j] := v_z_plus_i[v_j] + v_v[v_i][v_j] * v_z[v_i][v_j];
            END LOOP;
            IF v_v_plus_i[v_j] > 0 THEN
                v_z_plus_i[v_j] := v_z_plus_i[v_j] / v_v_plus_i[v_j];
            ELSE
                v_z_plus_i[v_j] := 0;
            END IF;
        END LOOP;
        
        -- ' Вычисляем Z_i_plus(num)
        v_z_i_plus[v_num] := 0;
        FOR v_j IN 1..v_n2 LOOP
            v_z_i_plus[v_num] := v_z_i_plus[v_num] + v_v[v_num][v_j] * v_z[v_num][v_j];
        END LOOP;
        IF v_v_i_plus[v_num] > 0 THEN
            v_z_i_plus[v_num] := v_z_i_plus[v_num] / v_v_i_plus[v_num];
        ELSE
            v_z_i_plus[v_num] := 0;
        END IF;
        
        -- ' Вычисляем Z_i(num)
        v_z_i[v_num] := 0;
        FOR v_j IN 1..v_n2 LOOP
            v_z_i[v_num] := v_z_i[v_num] + v_v[v_num][v_j] * v_z_plus_i[v_j];
        END LOOP;
        IF v_v_i_plus[v_num] > 0 THEN
            v_z_i[v_num] := v_z_i[v_num] / v_v_i_plus[v_num];
        ELSE
            v_z_i[v_num] := 0;
        END IF;
        
        -- ' Вычисляем Ind1(num)
        IF v_z_i[v_num] > 0 THEN
            v_ind1[v_num] := v_z_i_plus[v_num] / v_z_i[v_num];
        ELSE
            v_ind1[v_num] := 0;
        END IF;
    END LOOP;
    
    -- =============================================
    -- Расчет Ind2 (как в VBA)
    -- =============================================
    -- ReDim V_plus_i(N1-1), V_i_plus(N2-1), Z_plus_i(N1-1), Z_i_plus(N2-1), Z_i(N2-1)
    v_v_plus_i := array_fill(0, ARRAY[v_n1]);
    v_v_i_plus := array_fill(0, ARRAY[v_n2]);
    v_z_plus_i := array_fill(0, ARRAY[v_n1]);
    v_z_i_plus := array_fill(0, ARRAY[v_n2]);
    v_z_i := array_fill(0, ARRAY[v_n2]);
    v_ind2 := array_fill(0, ARRAY[v_n2]);
    
    -- For num = 0 To N2 - 1
    FOR v_num IN 1..v_n2 LOOP
        -- ' Вычисляем V_plus_i()
        FOR v_i IN 1..v_n1 LOOP
            v_v_plus_i[v_i] := 0;
            FOR v_j IN 1..v_n2 LOOP
                v_v_plus_i[v_i] := v_v_plus_i[v_i] + v_v[v_i][v_j];
            END LOOP;
        END LOOP;
        
        -- ' Вычисляем V_i_plus(num)
        v_v_i_plus[v_num] := 0;
        FOR v_i IN 1..v_n1 LOOP
            v_v_i_plus[v_num] := v_v_i_plus[v_num] + v_v[v_i][v_num];
        END LOOP;
        
        -- ' Вычисляем Z_plus_i()
        FOR v_i IN 1..v_n1 LOOP
            v_z_plus_i[v_i] := 0;
            FOR v_j IN 1..v_n2 LOOP
                v_z_plus_i[v_i] := v_z_plus_i[v_i] + v_v[v_i][v_j] * v_z[v_i][v_j];
            END LOOP;
            IF v_v_plus_i[v_i] > 0 THEN
                v_z_plus_i[v_i] := v_z_plus_i[v_i] / v_v_plus_i[v_i];
            ELSE
                v_z_plus_i[v_i] := 0;
            END IF;
        END LOOP;
        
        -- ' Вычисляем Z_i_plus(num)
        v_z_i_plus[v_num] := 0;
        FOR v_i IN 1..v_n1 LOOP
            v_z_i_plus[v_num] := v_z_i_plus[v_num] + v_v[v_i][v_num] * v_z[v_i][v_num];
        END LOOP;
        IF v_v_i_plus[v_num] > 0 THEN
            v_z_i_plus[v_num] := v_z_i_plus[v_num] / v_v_i_plus[v_num];
        ELSE
            v_z_i_plus[v_num] := 0;
        END IF;
        
        -- ' Вычисляем Z_i(num)
        v_z_i[v_num] := 0;
        FOR v_i IN 1..v_n1 LOOP
            v_z_i[v_num] := v_z_i[v_num] + v_v[v_i][v_num] * v_z_plus_i[v_i];
        END LOOP;
        IF v_v_i_plus[v_num] > 0 THEN
            v_z_i[v_num] := v_z_i[v_num] / v_v_i_plus[v_num];
        ELSE
            v_z_i[v_num] := 0;
        END IF;
        
        -- ' Вычисляем Ind2(num)
        IF v_z_i[v_num] > 0 THEN
            v_ind2[v_num] := v_z_i_plus[v_num] / v_z_i[v_num];
        ELSE
            v_ind2[v_num] := 0;
        END IF;
    END LOOP;
    
    -- Сохраняем результаты
    FOR v_i IN 1..v_n1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (v_action_months[v_i], v_ind1[v_i]);
    END LOOP;
    
    FOR v_j IN 1..v_n2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (v_calendar_months[v_j], v_ind2[v_j]);
    END LOOP;
    
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Расчет завершен.';
END;
$function$;
