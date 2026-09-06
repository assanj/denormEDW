-- DROP FUNCTION actuary.glm_calc_ind();

CREATE OR REPLACE FUNCTION actuary.glm_calc_ind()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    -- =====================================================
    -- ОБЪЯВЛЕНИЕ ПЕРЕМЕННЫХ (Dim ... As ...)
    -- Соответствие VBA: Dim N1 As Integer, Dim N2 As Integer
    -- =====================================================
    N1 INTEGER;             -- VBA: N1 As Integer 'количество групп по месяцу действия
    N2 INTEGER;             -- VBA: N2 As Integer 'количество групп по месяцу календарному
    
    i INTEGER;              -- VBA: i As Integer
    j INTEGER;              -- VBA: j As Integer
    num INTEGER;            -- VBA: num As Integer
    
    -- =====================================================
    -- МАТРИЦЫ ДАННЫХ (как в VBA)
    -- VBA: Dim V() As Double, Dim S() As Double, Dim Z() As Double
    -- =====================================================
    V NUMERIC[][];          -- VBA: V() As Double 'матрица значений экспозиции (объема)
    S NUMERIC[][];          -- VBA: S() As Double 'матрица значений убытка
    Z NUMERIC[][];          -- VBA: Z() As Double 'матрица значений нормированного убытка Z = S/V
    
    -- =====================================================
    -- МАССИВЫ ИНДЕКСОВ (как в VBA)
    -- VBA: Dim Ind1() As Double, Dim Ind2() As Double
    -- =====================================================
    Ind1 NUMERIC[];         -- VBA: Ind1() As Double 'индексы по месяцам действия
    Ind2 NUMERIC[];         -- VBA: Ind2() As Double 'индексы по календарным месяцам
    
    -- =====================================================
    -- МАССИВЫ НАЗВАНИЙ (как в VBA)
    -- VBA: Dim F1() As String, Dim F2() As String
    -- =====================================================
    F1 INTEGER[];           -- VBA: F1() As String 'названия месяцев действия
    F2 INTEGER[];           -- VBA: F2() As String 'названия календарных месяцев
    
    -- =====================================================
    -- ВСПОМОГАТЕЛЬНЫЕ МАССИВЫ (как в VBA)
    -- VBA: Dim V_plus_i() As Double, Dim V_i_plus() As Double
    -- VBA: Dim Z_plus_i() As Double, Dim Z_i_plus() As Double
    -- VBA: Dim Z_i() As Double
    -- =====================================================
    V_plus_i NUMERIC[];     -- VBA: V_plus_i() As Double 'сумма V по столбцам (Ind1) или по строкам (Ind2)
    V_i_plus NUMERIC[];     -- VBA: V_i_plus() As Double 'сумма V по строкам (Ind1) или по столбцам (Ind2)
    Z_plus_i NUMERIC[];     -- VBA: Z_plus_i() As Double 'среднее Z по столбцам (Ind1) или по строкам (Ind2)
    Z_i_plus NUMERIC[];     -- VBA: Z_i_plus() As Double 'среднее Z по строкам (Ind1) или по столбцам (Ind2)
    Z_i NUMERIC[];          -- VBA: Z_i() As Double 'ожидаемое Z (знаменатель для индексов)
    
    -- =====================================================
    -- ВСПОМОГАТЕЛЬНЫЕ ПЕРЕМЕННЫЕ (как в VBA)
    -- VBA: Dim s1, s2 As Double, Dim g1, g2 As String
    -- =====================================================
    s1 NUMERIC;             -- VBA: s1 As Double 'вспомогательная переменная для сумм
    s2 NUMERIC;             -- VBA: s2 As Double 'вспомогательная переменная для сумм
    g1 INTEGER;             -- VBA: g1 As String 'текущий месяц действия из Data
    g2 INTEGER;             -- VBA: g2 As String 'текущий календарный месяц из Data
    
    Count INTEGER;          -- VBA: Count As Integer 'количество строк с данными
    foundCount INTEGER;     -- VBA: foundCount As Integer 'счетчик найденных соответствий
    
BEGIN
    -- =====================================================
    -- ШАГ 1: ПОЛУЧАЕМ УНИКАЛЬНЫЕ МЕСЯЦЫ
    -- VBA: Worksheets("Ind").Activate
    -- VBA: N1 = Worksheets(List_Name_1).Cells(1, 8).Value
    -- VBA: N2 = Worksheets(List_Name_1).Cells(2, 8).Value
    -- =====================================================
    
    -- VBA: For i = 0 To N1 - 1: F1(i) = CStr(Worksheets(List_Name_1).Cells(i + 2, 1).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц действия" ORDER BY "Месяц действия")
    INTO F1
    FROM actuary.glm_data;
    
    -- VBA: For i = 0 To N2 - 1: F2(i) = CStr(Worksheets(List_Name_1).Cells(i + 2, 4).Value): Next i
    SELECT ARRAY_AGG(DISTINCT "Месяц календарный" ORDER BY "Месяц календарный")
    INTO F2
    FROM actuary.glm_data;
    
    -- VBA: N1 = ... , N2 = ...
    N1 := COALESCE(array_length(F1, 1), 0);
    N2 := COALESCE(array_length(F2, 1), 0);
    
    -- VBA: If N1 = 0 Or N2 = 0 Then Exit Sub
    IF N1 = 0 OR N2 = 0 THEN
        RAISE NOTICE 'Нет данных для расчета индексов';
        RETURN;
    END IF;
    
    -- VBA: Worksheets("Ind").Cells(1, 8).Value = N1
    -- VBA: Worksheets("Ind").Cells(2, 8).Value = N2
    INSERT INTO actuary.glm_ind ("N1", "N2") VALUES (N1, N2);
    
    -- =====================================================
    -- ШАГ 2: ПОДГОТОВКА ДАННЫХ (как в VBA)
    -- VBA: ReDim V(N1 - 1, N2 - 1)
    -- VBA: ReDim S(N1 - 1, N2 - 1)
    -- VBA: ReDim Z(N1 - 1, N2 - 1)
    -- =====================================================
    
    -- Создаем временную таблицу (аналог листа Data в Excel)
    DROP TABLE IF EXISTS temp_matrix;
    CREATE TEMP TABLE temp_matrix AS
    SELECT 
        "Месяц действия",
        "Месяц календарный",
        "Exp" AS v,          -- VBA: V(i, j) = Worksheets(List_Name_2).Cells(num, 4).Value
        "MCL" AS s,          -- VBA: S(i, j) = Worksheets(List_Name_2).Cells(num, 3).Value
        CASE 
            WHEN "Exp" > 0 THEN "MCL" / "Exp"  -- VBA: If V(i, j) > 0 Then Z(i, j) = S(i, j) / V(i, j)
            ELSE 0                             -- VBA: Else Z(i, j) = 0
        END AS z
    FROM actuary.glm_data;
    
    -- Создаем индексы для ускорения запросов
    CREATE INDEX idx_tm_action ON temp_matrix ("Месяц действия");
    CREATE INDEX idx_tm_calendar ON temp_matrix ("Месяц календарный");
    
    -- VBA: ReDim V(N1 - 1, N2 - 1) и т.д.
    V := array_fill(0, ARRAY[N1, N2]);
    S := array_fill(0, ARRAY[N1, N2]);
    Z := array_fill(0, ARRAY[N1, N2]);
    
    -- =====================================================
    -- ШАГ 3: ЗАПОЛНЕНИЕ МАТРИЦ (как в VBA)
    -- VBA: Worksheets(List_Name_2).Activate
    -- VBA: Count = Application.WorksheetFunction.CountA(Columns(1))
    -- VBA: For num = 2 To Count
    -- VBA:     g1 = Worksheets(List_Name_2).Cells(num, 1).Value
    -- VBA:     g2 = Worksheets(List_Name_2).Cells(num, 2).Value
    -- VBA:     If g1 = F1(i) And g2 = F2(j) Then
    -- VBA:         V(i, j) = Worksheets(List_Name_2).Cells(num, 4).Value
    -- VBA:         S(i, j) = Worksheets(List_Name_2).Cells(num, 3).Value
    -- VBA:         If V(i, j) > 0 Then Z(i, j) = S(i, j) / V(i, j) Else Z(i, j) = 0
    -- VBA:     End If
    -- VBA: Next num
    -- =====================================================
    
    foundCount := 0;
    
    FOR i IN 1..N1 LOOP
        FOR j IN 1..N2 LOOP
            -- VBA: V(i, j) = Worksheets(List_Name_2).Cells(num, 4).Value
            -- VBA: S(i, j) = Worksheets(List_Name_2).Cells(num, 3).Value
            SELECT COALESCE(v, 0), COALESCE(s, 0), COALESCE(z, 0)
            INTO s1, s2, V[i][j]
            FROM temp_matrix
            WHERE "Месяц действия" = F1[i]
              AND "Месяц календарный" = F2[j];
            
            V[i][j] := s1;  -- VBA: V(i, j)
            S[i][j] := s2;  -- VBA: S(i, j)
            Z[i][j] := V[i][j];  -- VBA: Z(i, j) уже вычислен в temp_matrix
            
            IF s1 > 0 OR s2 > 0 THEN
                foundCount := foundCount + 1;
            END IF;
        END LOOP;
    END LOOP;
    
    -- =====================================================
    -- ШАГ 4: РАСЧЕТ Ind1 (индексы по месяцам действия)
    -- VBA: ' Вычисление Ind1()
    -- VBA: ReDim V_plus_i(N2 - 1)
    -- VBA: ReDim V_i_plus(N1 - 1)
    -- VBA: ReDim Z_plus_i(N2 - 1)
    -- VBA: ReDim Z_i_plus(N1 - 1)
    -- VBA: ReDim Z_i(N1 - 1)
    -- =====================================================
    
    -- VBA: ReDim V_plus_i(N2 - 1) и т.д.
    V_plus_i := array_fill(0, ARRAY[N2]);
    V_i_plus := array_fill(0, ARRAY[N1]);
    Z_plus_i := array_fill(0, ARRAY[N2]);
    Z_i_plus := array_fill(0, ARRAY[N1]);
    Z_i := array_fill(0, ARRAY[N1]);
    Ind1 := array_fill(0, ARRAY[N1]);
    
    -- VBA: For num = 0 To N1 - 1
    FOR num IN 1..N1 LOOP
        
        -- VBA: ' Вычисление V_plus_i()
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     V_plus_i(j) = 0
        -- VBA:     For i = 0 To N1 - 1
        -- VBA:         V_plus_i(j) = V_plus_i(j) + V(i, j)
        -- VBA:     Next i
        -- VBA: Next j
        FOR j IN 1..N2 LOOP
            V_plus_i[j] := 0;
            FOR i IN 1..N1 LOOP
                V_plus_i[j] := V_plus_i[j] + V[i][j];
            END LOOP;
        END LOOP;
        
        -- VBA: ' Вычисление V_i_plus(num)
        -- VBA: V_i_plus(num) = 0
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     V_i_plus(num) = V_i_plus(num) + V(num, j)
        -- VBA: Next j
        V_i_plus[num] := 0;
        FOR j IN 1..N2 LOOP
            V_i_plus[num] := V_i_plus[num] + V[num][j];
        END LOOP;
        
        -- VBA: ' Вычисление Z_plus_i()
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     Z_plus_i(j) = 0
        -- VBA:     For i = 0 To N1 - 1
        -- VBA:         Z_plus_i(j) = Z_plus_i(j) + V(i, j) * Z(i, j)
        -- VBA:     Next i
        -- VBA:     If V_plus_i(j) > 0 Then
        -- VBA:         Z_plus_i(j) = Z_plus_i(j) / V_plus_i(j)
        -- VBA:     Else
        -- VBA:         Z_plus_i(j) = 0
        -- VBA:     End If
        -- VBA: Next j
        FOR j IN 1..N2 LOOP
            Z_plus_i[j] := 0;
            FOR i IN 1..N1 LOOP
                Z_plus_i[j] := Z_plus_i[j] + V[i][j] * Z[i][j];
            END LOOP;
            IF V_plus_i[j] > 0 THEN
                Z_plus_i[j] := Z_plus_i[j] / V_plus_i[j];
            ELSE
                Z_plus_i[j] := 0;
            END IF;
        END LOOP;
        
        -- VBA: ' Вычисление Z_i_plus(num)
        -- VBA: Z_i_plus(num) = 0
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     Z_i_plus(num) = Z_i_plus(num) + V(num, j) * Z(num, j)
        -- VBA: Next j
        -- VBA: If V_i_plus(num) > 0 Then
        -- VBA:     Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
        -- VBA: Else
        -- VBA:     Z_i_plus(num) = 0
        -- VBA: End If
        Z_i_plus[num] := 0;
        FOR j IN 1..N2 LOOP
            Z_i_plus[num] := Z_i_plus[num] + V[num][j] * Z[num][j];
        END LOOP;
        IF V_i_plus[num] > 0 THEN
            Z_i_plus[num] := Z_i_plus[num] / V_i_plus[num];
        ELSE
            Z_i_plus[num] := 0;
        END IF;
        
        -- VBA: ' Вычисление Z_i(num)
        -- VBA: Z_i(num) = 0
        -- VBA: For j = 0 To N2 - 1
        -- VBA:     Z_i(num) = Z_i(num) + V(num, j) * Z_plus_i(j)
        -- VBA: Next j
        -- VBA: If V_i_plus(num) > 0 Then
        -- VBA:     Z_i(num) = Z_i(num) / V_i_plus(num)
        -- VBA: Else
        -- VBA:     Z_i(num) = 0
        -- VBA: End If
        Z_i[num] := 0;
        FOR j IN 1..N2 LOOP
            Z_i[num] := Z_i[num] + V[num][j] * Z_plus_i[j];
        END LOOP;
        IF V_i_plus[num] > 0 THEN
            Z_i[num] := Z_i[num] / V_i_plus[num];
        ELSE
            Z_i[num] := 0;
        END IF;
        
        -- VBA: ' Непосредственное вычисление Ind1(num)
        -- VBA: If Z_i(num) > 0 Then
        -- VBA:     Ind1(num) = Z_i_plus(num) / Z_i(num)
        -- VBA: Else
        -- VBA:     Ind1(num) = 0
        -- VBA: End If
        -- VBA: Worksheets(List_Name_1).Cells(num + 2, 2).Value = Ind1(num)
        IF Z_i[num] > 0 THEN
            Ind1[num] := Z_i_plus[num] / Z_i[num];
        ELSE
            Ind1[num] := 0;
        END IF;
        
    END LOOP;
    
    -- VBA: Сохраняем Ind1 в таблицу
    FOR i IN 1..N1 LOOP
        INSERT INTO actuary.glm_ind ("Месяц действия", "Ind 1")
        VALUES (F1[i], Ind1[i]);
    END LOOP;
    
    -- =====================================================
    -- ШАГ 5: РАСЧЕТ Ind2 (индексы по календарным месяцам)
    -- VBA: ' Вычисление Ind2()
    -- VBA: ReDim V_plus_i(N1 - 1)
    -- VBA: ReDim V_i_plus(N2 - 1)
    -- VBA: ReDim Z_plus_i(N1 - 1)
    -- VBA: ReDim Z_i_plus(N2 - 1)
    -- VBA: ReDim Z_i(N2 - 1)
    -- =====================================================
    
    -- VBA: ReDim V_plus_i(N1 - 1) и т.д.
    V_plus_i := array_fill(0, ARRAY[N1]);
    V_i_plus := array_fill(0, ARRAY[N2]);
    Z_plus_i := array_fill(0, ARRAY[N1]);
    Z_i_plus := array_fill(0, ARRAY[N2]);
    Z_i := array_fill(0, ARRAY[N2]);
    Ind2 := array_fill(0, ARRAY[N2]);
    
    -- VBA: For num = 0 To N2 - 1
    FOR num IN 1..N2 LOOP
        
        -- VBA: ' Вычисление V_plus_i()
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     V_plus_i(i) = 0
        -- VBA:     For j = 0 To N2 - 1
        -- VBA:         V_plus_i(i) = V_plus_i(i) + V(i, j)
        -- VBA:     Next j
        -- VBA: Next i
        FOR i IN 1..N1 LOOP
            V_plus_i[i] := 0;
            FOR j IN 1..N2 LOOP
                V_plus_i[i] := V_plus_i[i] + V[i][j];
            END LOOP;
        END LOOP;
        
        -- VBA: ' Вычисление V_i_plus(num)
        -- VBA: V_i_plus(num) = 0
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     V_i_plus(num) = V_i_plus(num) + V(i, num)
        -- VBA: Next i
        V_i_plus[num] := 0;
        FOR i IN 1..N1 LOOP
            V_i_plus[num] := V_i_plus[num] + V[i][num];
        END LOOP;
        
        -- VBA: ' Вычисление Z_plus_i()
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     Z_plus_i(i) = 0
        -- VBA:     For j = 0 To N2 - 1
        -- VBA:         Z_plus_i(i) = Z_plus_i(i) + V(i, j) * Z(i, j)
        -- VBA:     Next j
        -- VBA:     If V_plus_i(i) > 0 Then
        -- VBA:         Z_plus_i(i) = Z_plus_i(i) / V_plus_i(i)
        -- VBA:     Else
        -- VBA:         Z_plus_i(i) = 0
        -- VBA:     End If
        -- VBA: Next i
        FOR i IN 1..N1 LOOP
            Z_plus_i[i] := 0;
            FOR j IN 1..N2 LOOP
                Z_plus_i[i] := Z_plus_i[i] + V[i][j] * Z[i][j];
            END LOOP;
            IF V_plus_i[i] > 0 THEN
                Z_plus_i[i] := Z_plus_i[i] / V_plus_i[i];
            ELSE
                Z_plus_i[i] := 0;
            END IF;
        END LOOP;
        
        -- VBA: ' Вычисление Z_i_plus(num)
        -- VBA: Z_i_plus(num) = 0
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     Z_i_plus(num) = Z_i_plus(num) + V(i, num) * Z(i, num)
        -- VBA: Next i
        -- VBA: If V_i_plus(num) > 0 Then
        -- VBA:     Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
        -- VBA: Else
        -- VBA:     Z_i_plus(num) = 0
        -- VBA: End If
        Z_i_plus[num] := 0;
        FOR i IN 1..N1 LOOP
            Z_i_plus[num] := Z_i_plus[num] + V[i][num] * Z[i][num];
        END LOOP;
        IF V_i_plus[num] > 0 THEN
            Z_i_plus[num] := Z_i_plus[num] / V_i_plus[num];
        ELSE
            Z_i_plus[num] := 0;
        END IF;
        
        -- VBA: ' Вычисление Z_i(num)
        -- VBA: Z_i(num) = 0
        -- VBA: For i = 0 To N1 - 1
        -- VBA:     Z_i(num) = Z_i(num) + V(i, num) * Z_plus_i(i)
        -- VBA: Next i
        -- VBA: If V_i_plus(num) > 0 Then
        -- VBA:     Z_i(num) = Z_i(num) / V_i_plus(num)
        -- VBA: Else
        -- VBA:     Z_i(num) = 0
        -- VBA: End If
        Z_i[num] := 0;
        FOR i IN 1..N1 LOOP
            Z_i[num] := Z_i[num] + V[i][num] * Z_plus_i[i];
        END LOOP;
        IF V_i_plus[num] > 0 THEN
            Z_i[num] := Z_i[num] / V_i_plus[num];
        ELSE
            Z_i[num] := 0;
        END IF;
        
        -- VBA: ' Непосредственное вычисление Ind2(num)
        -- VBA: If Z_i(num) > 0 Then
        -- VBA:     Ind2(num) = Z_i_plus(num) / Z_i(num)
        -- VBA: Else
        -- VBA:     Ind2(num) = 0
        -- VBA: End If
        -- VBA: Worksheets(List_Name_1).Cells(num + 2, 5).Value = Ind2(num)
        IF Z_i[num] > 0 THEN
            Ind2[num] := Z_i_plus[num] / Z_i[num];
        ELSE
            Ind2[num] := 0;
        END IF;
        
    END LOOP;
    
    -- VBA: Сохраняем Ind2 в таблицу
    FOR j IN 1..N2 LOOP
        INSERT INTO actuary.glm_ind ("Месяц календарный", "Ind 2")
        VALUES (F2[j], Ind2[j]);
    END LOOP;
    
    -- =====================================================
    -- ШАГ 6: ОЧИСТКА ВРЕМЕННЫХ ТАБЛИЦ
    -- VBA: Worksheets(List_Name_1).Activate
    -- =====================================================
    
    DROP TABLE IF EXISTS temp_matrix;
    
    RAISE NOTICE 'Расчет индексов завершен. N1=%, N2=%', N1, N2;
END;
$function$
;

-- Permissions

ALTER FUNCTION actuary.glm_calc_ind() OWNER TO mskazakov;
GRANT ALL ON FUNCTION actuary.glm_calc_ind() TO mskazakov;
