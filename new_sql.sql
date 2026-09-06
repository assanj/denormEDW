CREATE OR REPLACE FUNCTION actuary.glm_calc_main()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    -- =====================================================
    -- ОБЪЯВЛЕНИЕ ПЕРЕМЕННЫХ (Dim ... As ...)
    -- Соответствие VBA: Dim i As Integer, Dim j As Integer
    -- =====================================================
    v_n1 INTEGER;           -- VBA: N1 As Integer 'количество групп по месяцу действия
    v_n2 INTEGER;           -- VBA: N2 As Integer 'количество групп по месяцу календарному
    v_eps NUMERIC := 0.000001;  -- VBA: eps = 0.000001 'допустимая ошибка
    v_dist NUMERIC := 1;    -- VBA: dist As Double 'величина ошибки при текущей итерации
    v_iter INTEGER := 0;    -- VBA: iterCount As Integer 'счетчик итераций
    v_max_iter INTEGER := 10000; -- VBA: ограничение для While
    v_i INTEGER;            -- VBA: i As Integer
    v_j INTEGER;            -- VBA: j As Integer
    v_action_months INTEGER[];  -- VBA: F1() As String (массив месяцев действия)
    v_calendar_months INTEGER[]; -- VBA: F2() As String (массив календарных месяцев)
    v_action_month INTEGER;
    v_calendar_month INTEGER;
    
    -- =====================================================
    -- МАТРИЦЫ ДАННЫХ (как в VBA)
    -- VBA: Dim Z() As Double, Dim V() As Double, Dim S() As Double
    -- VBA: ReDim Z(N1 - 1, N2 - 1)
    -- =====================================================
    v_v NUMERIC[][];        -- VBA: V(i, j) 'матрица значений экспозиции (объема)
    v_s NUMERIC[][];        -- VBA: S(i, j) 'матрица значений убытка
    v_z NUMERIC[][];        -- VBA: Z(i, j) 'матрица значений нормированного убытка
    
    -- =====================================================
    -- МАССИВЫ ИНДЕКСОВ (как в VBA)
    -- VBA: Dim K1() As Double, Dim tempK1() As Double
    -- VBA: Dim K2() As Double, Dim tempK2() As Double
    -- =====================================================
    v_k1_prev NUMERIC[];    -- VBA: tempK1() 'текущий вектор для проверки сходимости
    v_k1_curr NUMERIC[];    -- VBA: K1() 'вектор значений коэффициентов по месяцу действия
    v_k2_prev NUMERIC[];    -- VBA: tempK2() 'текущий вектор для проверки сходимости
    v_k2_curr NUMERIC[];    -- VBA: K2() 'вектор значений коэффициентов по месяцу календарному
    
    -- =====================================================
    -- ВСПОМОГАТЕЛЬНЫЕ ПЕРЕМЕННЫЕ
    -- VBA: Dim s1, s2 As Double
    -- =====================================================
    v_sum1 NUMERIC;         -- VBA: s1 'сумма S(i,j)/K2(j) или S(i,j)/K1(i)
    v_sum2 NUMERIC;         -- VBA: s2 'сумма V(i,j)
    v_vi NUMERIC;           -- VBA: временная переменная для V(i,j)
    v_si NUMERIC;           -- VBA: временная переменная для S(i,j)
BEGIN
    -- =====================================================
    -- ШАГ 1: ПОЛУЧАЕМ УНИКАЛЬНЫЕ МЕСЯЦЫ (как в VBA)
    -- VBA: N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
    -- VBA: N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
    -- 
    -- МАТЕМАТИКА:
    -- N1 - количество строк (месяцев действия)
    -- N2 - количество столбцов (календарных месяцев)
    -- Это размерности матрицы S (убытки) и V (экспозиция)
    -- =====================================================
    
    -- VBA: For i = 0 To N1 - 1: F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO v_action_months
    FROM actuary.glm_data;
    
    -- VBA: For i = 0 To N2 - 1: F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц календарный" ORDER BY "Месяц календарный")
    INTO v_calendar_months
    FROM actuary.glm_data;
    
    -- VBA: N1 = ... , N2 = ...
    v_n1 := COALESCE(array_length(v_action_months, 1), 0);
    v_n2 := COALESCE(array_length(v_calendar_months, 1), 0);
    
    -- VBA: If N1 = 0 Or N2 = 0 Then Exit Sub
    IF v_n1 = 0 OR v_n2 = 0 THEN
        RAISE NOTICE 'Нет данных для расчета';
        RETURN;
    END IF;

    -- =====================================================
    -- ШАГ 2: ПОДГОТОВКА ДАННЫХ (как в VBA)
    -- VBA: ReDim Z(N1 - 1, N2 - 1)
    -- VBA: ReDim V(N1 - 1, N2 - 1)
    -- VBA: ReDim S(N1 - 1, N2 - 1)
    -- 
    -- МАТЕМАТИКА:
    -- Матрица S (убытки) - фактический ущерб по каждой комбинации
    -- Матрица V (экспозиция) - количество договоров/рисков
    -- Матрица Z = S/V - частота убытков (интенсивность)
    -- =====================================================
    
    -- Создаем временную таблицу (аналог листа Data в Excel)
    DROP TABLE IF EXISTS temp_matrix;
    CREATE TEMP TABLE temp_matrix AS
    SELECT 
        "Месяц действия",
        "Месяц календарный",
        "Exp" AS v,          -- VBA: V(i, j) = Worksheets("Data").Cells(num, 4).Value
        "MCL" AS s           -- VBA: S(i, j) = Worksheets("Data").Cells(num, 3).Value
    FROM actuary.glm_data;

    -- Инициализация матриц (как VBA: ReDim V(N1 - 1, N2 - 1))
    v_v := array_fill(0, ARRAY[v_n1, v_n2]);
    v_s := array_fill(0, ARRAY[v_n1, v_n2]);
    v_z := array_fill(0, ARRAY[v_n1, v_n2]);
    
    -- =====================================================
    -- ШАГ 3: ЗАПОЛНЕНИЕ МАТРИЦ (как в VBA)
    -- VBA: For num = 2 To Count
    -- VBA:     g1 = Worksheets("Data").Cells(num, 1).Value
    -- VBA:     g2 = Worksheets("Data").Cells(num, 2).Value
    -- VBA:     If g1 = F1(i) And g2 = F2(j) Then
    -- VBA:         V(i, j) = Worksheets("Data").Cells(num, 4).Value
    -- VBA:         S(i, j) = Worksheets("Data").Cells(num, 3).Value
    -- VBA:         If V(i, j) > 0 Then Z(i, j) = S(i, j) / V(i, j)
    -- 
    -- МАТЕМАТИКА:
    -- Для каждой ячейки (i,j) вычисляем:
    -- Z(i,j) = S(i,j) / V(i,j) - это эмпирическая частота убытков
    -- Если V(i,j) = 0, то частота = 0 (нет данных)
    -- =====================================================
    FOR v_i IN 1..v_n1 LOOP
        v_action_month := v_action_months[v_i];
        FOR v_j IN 1..v_n2 LOOP
            v_calendar_month := v_calendar_months[v_j];
            
            -- VBA: V(i, j) = Worksheets("Data").Cells(num, 4).Value
            -- VBA: S(i, j) = Worksheets("Data").Cells(num, 3).Value
            SELECT COALESCE(v, 0), COALESCE(s, 0)
            INTO v_vi, v_si
            FROM temp_matrix
            WHERE "Месяц действия" = v_action_month
              AND "Месяц календарный" = v_calendar_month;
            
            v_v[v_i][v_j] := v_vi;
            v_s[v_i][v_j] := v_si;
            
            -- VBA: If V(i, j) > 0 Then Z(i, j) = S(i, j) / V(i, j) Else Z(i, j) = 0
            IF v_vi > 0 THEN
                v_z[v_i][v_j] := v_si / v_vi;
            ELSE
                v_z[v_i][v_j] := 0;
            END IF;
        END LOOP;
    END LOOP;
    
    -- =====================================================
    -- ШАГ 4: ИНИЦИАЛИЗАЦИЯ ИНДЕКСОВ (как в VBA)
    -- VBA: For i = 0 To N1 - 1: tempK1(i) = 1: Next i
    -- VBA: For j = 0 To N2 - 1: tempK2(j) = 1: Next j
    -- VBA: For j = 0 To N2 - 1: K2(j) = 1: Next j
    -- 
    -- МАТЕМАТИКА:
    -- K1(i) - коэффициент влияния месяца действия (строки)
    -- K2(j) - коэффициент влияния календарного месяца (столбцы)
    -- Начальное приближение: все коэффициенты = 1 (отсутствие эффектов)
    -- =====================================================
    v_k1_prev := array_fill(1, ARRAY[v_n1]);  -- VBA: tempK1(i) = 1
    v_k1_curr := array_fill(1, ARRAY[v_n1]);  -- VBA: K1(i) = 1 (добавлено для правильной инициализации)
    v_k2_prev := array_fill(1, ARRAY[v_n2]);  -- VBA: tempK2(j) = 1
    v_k2_curr := array_fill(1, ARRAY[v_n2]);  -- VBA: K2(j) = 1
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', v_n1, v_n2;
    
    -- =====================================================
    -- ШАГ 5: ИТЕРАТИВНЫЙ ПРОЦЕСС (как в VBA)
    -- VBA: While dist > eps
    -- 
    -- МАТЕМАТИКА:
    -- Это метод максимального правдоподобия (MLE) для оценки
    -- мультипликативной модели GLM с распределением Пуассона:
    --
    -- Ожидаемое значение убытков: E[S(i,j)] = V(i,j) * K1(i) * K2(j)
    --
    -- Где:
    --   V(i,j) - экспозиция (известна)
    --   K1(i) - фактор влияния месяца действия (оценивается)
    --   K2(j) - фактор влияния календарного месяца (оценивается)
    --
    -- Уравнения для оценок:
    -- K1(i) = Σ(j) S(i,j) / K2(j) / Σ(j) V(i,j)
    -- K2(j) = Σ(i) S(i,j) / K1(i) / Σ(i) V(i,j)
    --
    -- Это система нелинейных уравнений, решаемая итерационно
    -- методом простой итерации (последовательных приближений)
    -- =====================================================
    
    -- VBA: While dist > eps
    WHILE v_dist > v_eps AND v_iter < v_max_iter LOOP
        v_iter := v_iter + 1;
        
        -- =====================================================
        -- ОБНОВЛЕНИЕ K1 (по месяцам действия)
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     s1 = 0: s2 = 0
        -- VBA:     For j = 0 To N2 - 1
        -- VBA:         s1 = s1 + S(i, j) / K2(j)
        -- VBA:         s2 = s2 + V(i, j)
        -- VBA:     Next j
        -- VBA:     K1(i) = s1 / s2
        -- VBA: Next i
        --
        -- МАТЕМАТИКА:
        -- Оценка K1(i) - фактора влияния месяца действия:
        --
        -- Числитель: Σ(j) S(i,j) / K2(j) 
        --   Это сумма скорректированных убытков по строке i
        --   Корректировка: делим на текущую оценку K2(j)
        --
        -- Знаменатель: Σ(j) V(i,j)
        --   Это общая экспозиция по строке i
        --
        -- Интерпретация: K1(i) - это отношение
        --   фактических убытков (скорректированных) к ожидаемым
        --   в предположении, что K2(j) = 1
        -- =====================================================
        FOR v_i IN 1..v_n1 LOOP
            v_sum1 := 0;  -- VBA: s1 = 0
            v_sum2 := 0;  -- VBA: s2 = 0
            
            FOR v_j IN 1..v_n2 LOOP
                -- VBA: If K2(j) <> 0 Then (защита от деления на ноль)
                IF v_k2_curr[v_j] != 0 THEN
                    v_sum1 := v_sum1 + v_s[v_i][v_j] / v_k2_curr[v_j];  -- VBA: s1 = s1 + S(i, j) / K2(j)
                END IF;
                v_sum2 := v_sum2 + v_v[v_i][v_j];  -- VBA: s2 = s2 + V(i, j)
            END LOOP;
            
            -- VBA: K1(i) = s1 / s2
            IF v_sum2 > 0 THEN
                v_k1_curr[v_i] := v_sum1 / v_sum2;
            ELSE
                v_k1_curr[v_i] := 1;  -- VBA: защита от деления на ноль
            END IF;
        END LOOP;
        
        -- =====================================================
        -- ОБНОВЛЕНИЕ K2 (по календарным месяцам)
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     s1 = 0: s2 = 0
        -- VBA:     For i = 0 To N1 - 1
        -- VBA:         s1 = s1 + S(i, j) / K1(i)
        -- VBA:         s2 = s2 + V(i, j)
        -- VBA:     Next i
        -- VBA:     K2(j) = s1 / s2
        -- VBA: Next j
        --
        -- МАТЕМАТИКА:
        -- Оценка K2(j) - фактора влияния календарного месяца:
        --
        -- Числитель: Σ(i) S(i,j) / K1(i)
        --   Это сумма скорректированных убытков по столбцу j
        --   Корректировка: делим на текущую оценку K1(i)
        --
        -- Знаменатель: Σ(i) V(i,j)
        --   Это общая экспозиция по столбцу j
        --
        -- Интерпретация: K2(j) - это отношение
        --   фактических убытков (скорректированных) к ожидаемым
        --   в предположении, что K1(i) = 1
        -- =====================================================
        FOR v_j IN 1..v_n2 LOOP
            v_sum1 := 0;  -- VBA: s1 = 0
            v_sum2 := 0;  -- VBA: s2 = 0
            
            FOR v_i IN 1..v_n1 LOOP
                -- VBA: If K1(i) <> 0 Then (защита от деления на ноль)
                IF v_k1_curr[v_i] != 0 THEN
                    v_sum1 := v_sum1 + v_s[v_i][v_j] / v_k1_curr[v_i];  -- VBA: s1 = s1 + S(i, j) / K1(i)
                END IF;
                v_sum2 := v_sum2 + v_v[v_i][v_j];  -- VBA: s2 = s2 + V(i, j)
            END LOOP;
            
            -- VBA: K2(j) = s1 / s2
            IF v_sum2 > 0 THEN
                v_k2_curr[v_j] := v_sum1 / v_sum2;
            ELSE
                v_k2_curr[v_j] := 1;  -- VBA: защита от деления на ноль
            END IF;
        END LOOP;
        
        -- =====================================================
        -- ВЫЧИСЛЕНИЕ ОШИБКИ (проверка сходимости)
        -- VBA: dist = norma(K1, tempK1, K2, tempK2, N1, N2)
        --
        -- МАТЕМАТИКА:
        -- dist = √( Σ(i)(K1(i)-tempK1(i))² + Σ(j)(K2(j)-tempK2(j))² )
        --
        -- Это евклидова норма разности между текущими и предыдущими
        -- значениями коэффициентов. 
        -- Если dist < eps, то решение сошлось (стабилизировалось)
        -- =====================================================
        v_dist := actuary.glm_norma(
            v_k1_curr, v_k1_prev,
            v_k2_curr, v_k2_prev,
            v_n1, v_n2
        );
        
        -- VBA: For i = 0 To N1 - 1: tempK1(i) = K1(i): Next i
        -- VBA: For j = 0 To N2 - 1: tempK2(j) = K2(j): Next j
        v_k1_prev := v_k1_curr;  -- VBA: tempK1 = K1
        v_k2_prev := v_k2_curr;  -- VBA: tempK2 = K2
        
        IF v_iter % 10 = 0 THEN
            RAISE NOTICE 'Итерация %, ошибка: %', v_iter, v_dist;
        END IF;
    END LOOP;
    -- VBA: Wend (конец цикла)
    
    -- =====================================================
    -- ФИНАЛЬНЫЙ РЕЗУЛЬТАТ
    -- 
    -- МАТЕМАТИКА:
    -- После сходимости мы получаем оценки K1 и K2,
    -- которые минимизируют отклонение модели от данных.
    --
    -- Интерпретация коэффициентов:
    -- K1(i) = 1.0 - средний уровень убыточности для месяца действия i
    -- K1(i) > 1.0 - убыточность выше среднего
    -- K1(i) < 1.0 - убыточность ниже среднего
    --
    -- K2(j) = 1.0 - средний уровень убыточности для календарного месяца j
    -- K2(j) > 1.0 - убыточность выше среднего
    -- K2(j) < 1.0 - убыточность ниже среднего
    --
    -- Прогноз: Ожидаемый убыток = V * K1 * K2
    -- =====================================================
    
    RAISE NOTICE 'Расчет завершен. Итераций: %, ошибка: %', v_iter, v_dist;
    
    -- =====================================================
    -- ШАГ 6: СОХРАНЕНИЕ РЕЗУЛЬТАТОВ (как в VBA)
    -- VBA: For i = 2 To 1 + N1: Worksheets("Result").Cells(i, 2).Value = K1(i - 2): Next i
    -- VBA: For j = 2 To 1 + N2: Worksheets("Result").Cells(j, 4).Value = K2(j - 2): Next j
    -- VBA: Worksheets("Result").Cells(2, 5).Value = 1
    -- 
    -- МАТЕМАТИКА:
    -- Базовая частота = 1 означает, что модель использует
    -- мультипликативный вид: S = V * K1 * K2
    -- 
    -- Это означает, что при K1=1 и K2=1, ожидаемый убыток = V
    -- (базовый уровень частоты = 1)
    -- =====================================================
    
    -- VBA: Сохраняем K1 в столбец B
    FOR v_i IN 1..v_n1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (v_action_months[v_i], v_k1_curr[v_i]);
    END LOOP;
    
    -- VBA: Сохраняем K2 в столбец D
    FOR v_j IN 1..v_n2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (v_calendar_months[v_j], v_k2_curr[v_j]);
    END LOOP;
    
    -- VBA: Worksheets("Result").Cells(2, 5).Value = 1 (Базовая частота)
    UPDATE actuary.glm_result SET "Базовая частота" = 1;
    
    -- Очищаем временную таблицу
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Результаты сохранены.';
END;
$function$;
