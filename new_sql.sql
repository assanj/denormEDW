CREATE OR REPLACE FUNCTION actuary.glm_calc_main()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    -- =====================================================
    -- ОБЪЯВЛЕНИЕ ПЕРЕМЕННЫХ (Dim ... As ...)
    -- Соответствие VBA: Dim i As Integer, Dim j As Integer
    -- =====================================================
    i INTEGER;              -- VBA: i As Integer
    j INTEGER;              -- VBA: j As Integer
    num INTEGER;            -- VBA: num As Integer
    g1 INTEGER;             -- VBA: g1 As String (месяц действия из Data)
    g2 INTEGER;             -- VBA: g2 As String (календарный месяц из Data)
    
    N1 INTEGER;             -- VBA: N1 As Integer 'количество групп по месяцу действия
    N2 INTEGER;             -- VBA: N2 As Integer 'количество групп по месяцу календарному
    
    Count INTEGER;          -- VBA: Count As Integer 'количество строк с данными
    foundCount INTEGER;     -- VBA: foundCount As Integer 'счетчик найденных соответствий
    
    eps NUMERIC := 0.000001;  -- VBA: eps = 0.000001 'допустимая ошибка
    dist NUMERIC := 1;      -- VBA: dist As Double 'величина ошибки при текущей итерации
    iterCount INTEGER := 0; -- VBA: iterCount As Integer 'счетчик итераций
    
    s1 NUMERIC;             -- VBA: s1 As Double 'сумма для числителя
    s2 NUMERIC;             -- VBA: s2 As Double 'сумма для знаменателя
    sumV NUMERIC;           -- VBA: sumV As Double 'сумма V для диагностики
    sumS NUMERIC;           -- VBA: sumS As Double 'сумма S для диагностики
    
    -- =====================================================
    -- МАТРИЦЫ ДАННЫХ (как в VBA)
    -- VBA: Dim Z() As Double, Dim V() As Double, Dim S() As Double
    -- VBA: ReDim Z(N1 - 1, N2 - 1)
    -- =====================================================
    Z NUMERIC[][];          -- VBA: Z() As Double 'матрица значений нормированного убытка Z = S/V
    V NUMERIC[][];          -- VBA: V() As Double 'матрица значений экспозиции (объема)
    S NUMERIC[][];          -- VBA: S() As Double 'матрица значений убытка
    
    -- =====================================================
    -- МАССИВЫ ИНДЕКСОВ (как в VBA)
    -- VBA: Dim K1() As Double, Dim tempK1() As Double
    -- VBA: Dim K2() As Double, Dim tempK2() As Double
    -- =====================================================
    tempK1 NUMERIC[];       -- VBA: tempK1() 'текущий вектор для проверки сходимости
    K1 NUMERIC[];           -- VBA: K1() 'вектор значений коэффициентов по месяцу действия
    tempK2 NUMERIC[];       -- VBA: tempK2() 'текущий вектор для проверки сходимости
    K2 NUMERIC[];           -- VBA: K2() 'вектор значений коэффициентов по месяцу календарному
    
    -- =====================================================
    -- МАССИВЫ НАЗВАНИЙ (как в VBA)
    -- VBA: Dim F1() As String, Dim F2() As String
    -- =====================================================
    F1 INTEGER[];           -- VBA: F1() As String 'названия месяцев действия
    F2 INTEGER[];           -- VBA: F2() As String 'названия календарных месяцев
    
BEGIN
    -- =====================================================
    -- ШАГ 1: ПОЛУЧАЕМ УНИКАЛЬНЫЕ МЕСЯЦЫ (как в VBA)
    -- VBA: N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
    -- VBA: N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
    -- =====================================================
    
    -- VBA: For i = 0 To N1 - 1: F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO F1
    FROM actuary.glm_data;
    
    -- VBA: For i = 0 To N2 - 1: F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц календарный" ORDER BY "Месяц календарный")
    INTO F2
    FROM actuary.glm_data;
    
    -- VBA: N1 = ... , N2 = ...
    N1 := COALESCE(array_length(F1, 1), 0);
    N2 := COALESCE(array_length(F2, 1), 0);
    
    -- VBA: If N1 = 0 Or N2 = 0 Then Exit Sub
    IF N1 = 0 OR N2 = 0 THEN
        RAISE NOTICE 'Нет данных для расчета';
        RETURN;
    END IF;

    -- =====================================================
    -- ШАГ 2: ПОДГОТОВКА ДАННЫХ (как в VBA)
    -- VBA: ReDim Z(N1 - 1, N2 - 1)
    -- VBA: ReDim V(N1 - 1, N2 - 1)
    -- VBA: ReDim S(N1 - 1, N2 - 1)
    -- 
    -- МАТЕМАТИКА: ПУАССОНОВСКАЯ МОДЕЛЬ
    -- 
    -- ПРЕДПОЛОЖЕНИЕ: S(i,j) ~ Poisson(λ(i,j))
    -- где λ(i,j) = V(i,j) * K1(i) * K2(j)
    -- 
    -- S(i,j) - убытки, распределены по Пуассону
    -- V(i,j) - экспозиция (известна, как смещение - offset)
    -- K1(i) - эффект месяца действия (оценивается)
    -- K2(j) - эффект календарного месяца (оценивается)
    -- 
    -- ФУНКЦИЯ ПРАВДОПОДОБИЯ:
    -- L = ∏(i,j) exp(-λ(i,j)) * λ(i,j)^S(i,j) / S(i,j)!
    -- 
    -- ЛОГАРИФМИЧЕСКАЯ ФУНКЦИЯ ПРАВДОПОДОБИЯ:
    -- l = Σ(i,j) [ -λ(i,j) + S(i,j)*ln(λ(i,j)) - ln(S(i,j)!) ]
    -- 
    -- ПОДСТАНОВКА λ = V * K1 * K2:
    -- l = Σ(i,j) [ -V(i,j)*K1(i)*K2(j) + S(i,j)*ln(V(i,j)) + S(i,j)*ln(K1(i)) + S(i,j)*ln(K2(j)) - ln(S(i,j)!) ]
    -- 
    -- МАКСИМИЗАЦИЯ ПО K1 и K2 дает систему уравнений (см. ШАГ 5)
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

    -- VBA: ReDim V(N1 - 1, N2 - 1) и т.д.
    V := array_fill(0, ARRAY[N1, N2]);
    S := array_fill(0, ARRAY[N1, N2]);
    Z := array_fill(0, ARRAY[N1, N2]);
    
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
    -- Z(i,j) = S(i,j) / V(i,j) - это эмпирическая частота убытков
    -- В пуассоновской модели Z является оценкой λ/V
    -- =====================================================
    FOR i IN 1..N1 LOOP
        FOR j IN 1..N2 LOOP
            
            -- VBA: V(i, j) = Worksheets("Data").Cells(num, 4).Value
            -- VBA: S(i, j) = Worksheets("Data").Cells(num, 3).Value
            SELECT COALESCE(v, 0), COALESCE(s, 0)
            INTO s1, s2
            FROM temp_matrix
            WHERE "Месяц действия" = F1[i]
              AND "Месяц календарный" = F2[j];
            
            V[i][j] := s1;  -- VBA: V(i, j)
            S[i][j] := s2;  -- VBA: S(i, j)
            
            -- VBA: If V(i, j) > 0 Then Z(i, j) = S(i, j) / V(i, j) Else Z(i, j) = 0
            IF s1 > 0 THEN
                Z[i][j] := s2 / s1;  -- VBA: Z(i, j) = S(i, j) / V(i, j)
            ELSE
                Z[i][j] := 0;
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
    -- Начальное приближение: K1 = 1, K2 = 1
    -- Это соответствует модели без эффектов (базовая частота = 1)
    -- =====================================================
    tempK1 := array_fill(1, ARRAY[N1]);  -- VBA: tempK1(i) = 1
    K1 := array_fill(1, ARRAY[N1]);      -- VBA: K1(i) = 1
    tempK2 := array_fill(1, ARRAY[N2]);  -- VBA: tempK2(j) = 1
    K2 := array_fill(1, ARRAY[N2]);      -- VBA: K2(j) = 1
    
    RAISE NOTICE 'Начинаем итеративный расчет (N1=%, N2=%)...', N1, N2;
    
    -- =====================================================
    -- ШАГ 5: ИТЕРАТИВНЫЙ ПРОЦЕСС (как в VBA)
    -- VBA: While dist > eps
    -- 
    -- МАТЕМАТИКА: МЕТОД МАКСИМАЛЬНОГО ПРАВДОПОДОБИЯ ДЛЯ ПУАССОНА
    -- 
    -- Из логарифмической функции правдоподобия:
    -- l = Σ(i,j) [ -V(i,j)*K1(i)*K2(j) + S(i,j)*ln(K1(i)) + S(i,j)*ln(K2(j)) + const ]
    -- 
    -- Берем производные по K1(i) и приравниваем к нулю:
    -- ∂l/∂K1(i) = Σ(j) [ -V(i,j)*K2(j) + S(i,j)/K1(i) ] = 0
    -- 
    -- Отсюда: K1(i) = Σ(j) S(i,j) / Σ(j) V(i,j)*K2(j)
    -- 
    -- Аналогично для K2(j):
    -- K2(j) = Σ(i) S(i,j) / Σ(i) V(i,j)*K1(i)
    -- 
    -- Это система нелинейных уравнений (т.к. K1 и K2 в знаменателе)
    -- Решаем методом простой итерации (последовательных приближений)
    -- =====================================================
    
    -- VBA: While dist > eps
    WHILE dist > eps AND iterCount < 10000 LOOP
        iterCount := iterCount + 1;
        
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
        -- K1(i) = Σ(j) S(i,j) / K2(j) / Σ(j) V(i,j)
        --
        -- Это решение уравнения правдоподобия для K1(i):
        -- Σ(j) [ -V(i,j)*K2(j) + S(i,j)/K1(i) ] = 0
        --
        -- Интерпретация: K1(i) - это средневзвешенное отношение
        -- скорректированных убытков к экспозиции по строке i
        -- =====================================================
        FOR i IN 1..N1 LOOP
            s1 := 0;  -- VBA: s1 = 0 (числитель)
            s2 := 0;  -- VBA: s2 = 0 (знаменатель)
            
            FOR j IN 1..N2 LOOP
                -- VBA: s1 = s1 + S(i, j) / K2(j)
                IF K2[j] != 0 THEN
                    s1 := s1 + S[i][j] / K2[j];
                END IF;
                -- VBA: s2 = s2 + V(i, j)
                s2 := s2 + V[i][j];
            END LOOP;
            
            -- VBA: K1(i) = s1 / s2
            IF s2 > 0 THEN
                K1[i] := s1 / s2;
            ELSE
                K1[i] := 1;
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
        -- K2(j) = Σ(i) S(i,j) / K1(i) / Σ(i) V(i,j)
        --
        -- Это решение уравнения правдоподобия для K2(j):
        -- Σ(i) [ -V(i,j)*K1(i) + S(i,j)/K2(j) ] = 0
        --
        -- Интерпретация: K2(j) - это средневзвешенное отношение
        -- скорректированных убытков к экспозиции по столбцу j
        -- =====================================================
        FOR j IN 1..N2 LOOP
            s1 := 0;  -- VBA: s1 = 0 (числитель)
            s2 := 0;  -- VBA: s2 = 0 (знаменатель)
            
            FOR i IN 1..N1 LOOP
                -- VBA: s1 = s1 + S(i, j) / K1(i)
                IF K1[i] != 0 THEN
                    s1 := s1 + S[i][j] / K1[i];
                END IF;
                -- VBA: s2 = s2 + V(i, j)
                s2 := s2 + V[i][j];
            END LOOP;
            
            -- VBA: K2(j) = s1 / s2
            IF s2 > 0 THEN
                K2[j] := s1 / s2;
            ELSE
                K2[j] := 1;
            END IF;
        END LOOP;
        
        -- =====================================================
        -- ВЫЧИСЛЕНИЕ ОШИБКИ (проверка сходимости)
        -- VBA: dist = norma(K1, tempK1, K2, tempK2, N1, N2)
        --
        -- МАТЕМАТИКА:
        -- dist = √( Σ(i)(K1(i)-tempK1(i))² + Σ(j)(K2(j)-tempK2(j))² )
        --
        -- Евклидова норма разности между текущими и предыдущими
        -- значениями коэффициентов. Критерий остановки итераций.
        -- =====================================================
        dist := actuary.glm_norma(
            K1, tempK1,
            K2, tempK2,
            N1, N2
        );
        
        -- VBA: For i = 0 To N1 - 1: tempK1(i) = K1(i): Next i
        -- VBA: For j = 0 To N2 - 1: tempK2(j) = K2(j): Next j
        tempK1 := K1;  -- VBA: tempK1 = K1
        tempK2 := K2;  -- VBA: tempK2 = K2
        
        IF iterCount % 10 = 0 THEN
            RAISE NOTICE 'Итерация %, ошибка: %', iterCount, dist;
        END IF;
    END LOOP;
    -- VBA: Wend (конец цикла)
    
    -- =====================================================
    -- ФИНАЛЬНЫЙ РЕЗУЛЬТАТ
    -- 
    -- МАТЕМАТИКА: ИНТЕРПРЕТАЦИЯ РЕЗУЛЬТАТОВ
    --
    -- Модель: S(i,j) = V(i,j) * K1(i) * K2(j)
    -- 
    -- K1(i) - фактор месяца действия:
    --   > 1  → убыточность выше средней для месяца действия i
    --   = 1  → убыточность на среднем уровне
    --   < 1  → убыточность ниже средней
    --
    -- K2(j) - фактор календарного месяца:
    --   > 1  → убыточность выше средней для календарного месяца j
    --   = 1  → убыточность на среднем уровне
    --   < 1  → убыточность ниже средней
    --
    -- Прогноз: ожидаемый убыток = V * K1 * K2
    -- =====================================================
    
    RAISE NOTICE 'Расчет завершен. Итераций: %, ошибка: %', iterCount, dist;
    
    -- =====================================================
    -- ШАГ 6: СОХРАНЕНИЕ РЕЗУЛЬТАТОВ (как в VBA)
    -- VBA: For i = 2 To 1 + N1: Worksheets("Result").Cells(i, 2).Value = K1(i - 2): Next i
    -- VBA: For j = 2 To 1 + N2: Worksheets("Result").Cells(j, 4).Value = K2(j - 2): Next j
    -- VBA: Worksheets("Result").Cells(2, 5).Value = 1
    -- =====================================================
    
    -- VBA: Сохраняем K1 в столбец B
    FOR i IN 1..N1 LOOP
        INSERT INTO actuary.glm_result ("Месяц действия", "K1")
        VALUES (F1[i], K1[i]);
    END LOOP;
    
    -- VBA: Сохраняем K2 в столбец D
    FOR j IN 1..N2 LOOP
        INSERT INTO actuary.glm_result ("Месяц календарный", "K2")
        VALUES (F2[j], K2[j]);
    END LOOP;
    
    -- VBA: Worksheets("Result").Cells(2, 5).Value = 1 (Базовая частота)
    UPDATE actuary.glm_result SET "Базовая частота" = 1;
    
    -- Очищаем временную таблицу
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Результаты сохранены.';
END;
$function$;
