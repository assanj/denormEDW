-- DROP FUNCTION actuary.glm_calc_ind();

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
ПРОМТ:
этот код приведи в соответсвие названия переменных и комментарии по экселю 

Option Explicit
Dim N1 As Integer
Dim N2 As Integer

Dim i, j, num As Integer

Dim V() As Double
Dim S() As Double
Dim Z() As Double

Dim Ind1() As Double
Dim Ind2() As Double

Dim F1() As String
Dim F2() As String

Dim V_plus_i() As Double
Dim V_i_plus() As Double
Dim Z_plus_i() As Double
Dim Z__plus() As Double
Dim Z_i() As Double

Dim s1, s2 As Double
Dim g1, g2 As String

Sub Calc_Ind()
Dim List_Name_1 As String
Dim List_Name_2 As String
Dim Count As Integer

Worksheets("Ind").Activate
List_Name_1 = ActiveSheet.Name
List_Name_2 = "Data"

N1 = Worksheets(List_Name_1).Cells(1, 8).Value
N2 = Worksheets(List_Name_1).Cells(2, 8).Value

ReDim V(N1 - 1, N2 - 1)
ReDim S(N1 - 1, N2 - 1)
ReDim Z(N1 - 1, N2 - 1)

ReDim Ind1(N1 - 1)
ReDim Ind2(N2 - 1)

ReDim F1(N1 - 1)
ReDim F2(N2 - 1)

For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets(List_Name_1).Cells(i + 2, 1).Value)
Next i
For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets(List_Name_1).Cells(i + 2, 4).Value)
Next i

Worksheets(List_Name_2).Activate
Count = Application.WorksheetFunction.CountA(Columns(1))
For num = 2 To Count
    g1 = Worksheets(List_Name_2).Cells(num, 1).Value
    g2 = Worksheets(List_Name_2).Cells(num, 2).Value
    For i = 0 To N1 - 1
        For j = 0 To N2 - 1
            If g1 = F1(i) And g2 = F2(j) Then
                V(i, j) = Worksheets(List_Name_2).Cells(num, 4).Value
                S(i, j) = Worksheets(List_Name_2).Cells(num, 3).Value
                If V(i, j) > 0 Then
                    Z(i, j) = S(i, j) / V(i, j)
                Else
                    Z(i, j) = 0
                End If
            End If
        Next j
    Next i
Next num

' Вычисление Ind1()
ReDim V_plus_i(N2 - 1)
ReDim V_i_plus(N1 - 1)
ReDim Z_plus_i(N2 - 1)
ReDim Z_i_plus(N1 - 1)
ReDim Z_i(N1 - 1)

For num = 0 To N1 - 1
    ' Вычисление V_plus_i()
    For j = 0 To N2 - 1
        V_plus_i(j) = 0
        For i = 0 To N1 - 1
            V_plus_i(j) = V_plus_i(j) + V(i, j)
        Next i
    Next j
    ' Вычисление V_i_plus(num)
    V_i_plus(num) = 0
    For j = 0 To N2 - 1
        V_i_plus(num) = V_i_plus(num) + V(num, j)
    Next j

    ' Вычисление Z_plus_i()
    For j = 0 To N2 - 1
        Z_plus_i(j) = 0
        For i = 0 To N1 - 1
            Z_plus_i(j) = Z_plus_i(j) + V(i, j) * Z(i, j)
        Next i
        If V_plus_i(j) > 0 Then
            Z_plus_i(j) = Z_plus_i(j) / V_plus_i(j)
        Else
            Z_plus_i(j) = 0
        End If
    Next j
    
    ' Вычисление Z_i_plus(num)
    Z_i_plus(num) = 0
    For j = 0 To N2 - 1
        Z_i_plus(num) = Z_i_plus(num) + V(num, j) * Z(num, j)
    Next j
    If V_i_plus(num) > 0 Then
        Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
    Else
        Z_i_plus(num) = 0
    End If

    ' Вычисление Z_i(num)
    Z_i(num) = 0
    For j = 0 To N2 - 1
        Z_i(num) = Z_i(num) + V(num, j) * Z_plus_i(j)
    Next j
    If V_i_plus(num) > 0 Then
        Z_i(num) = Z_i(num) / V_i_plus(num)
    Else
        Z_i(num) = 0
    End If

    ' Непосредственное вычисление Ind1(num)
    If Z_i(num) > 0 Then
        Ind1(num) = Z_i_plus(num) / Z_i(num)
    Else
        Ind1(num) = 0
    End If
    Worksheets(List_Name_1).Cells(num + 2, 2).Value = Ind1(num)
Next num

' Вычисление Ind2()
ReDim V_plus_i(N1 - 1)
ReDim V_i_plus(N2 - 1)
ReDim Z_plus_i(N1 - 1)
ReDim Z_i_plus(N2 - 1)
ReDim Z_i(N2 - 1)

For num = 0 To N2 - 1
    ' Вычисление V_plus_i()
    For i = 0 To N1 - 1
        V_plus_i(i) = 0
        For j = 0 To N2 - 1
            V_plus_i(i) = V_plus_i(i) + V(i, j)
        Next j
    Next i
    
    ' Вычисление V_i_plus(num)
    V_i_plus(num) = 0
    For i = 0 To N1 - 1
        V_i_plus(num) = V_i_plus(num) + V(i, num)
    Next i

    ' Вычисление Z_plus_i()
    For i = 0 To N1 - 1
        Z_plus_i(i) = 0
        For j = 0 To N2 - 1
            Z_plus_i(i) = Z_plus_i(i) + V(i, j) * Z(i, j)
        Next j
        If V_plus_i(i) > 0 Then
            Z_plus_i(i) = Z_plus_i(i) / V_plus_i(i)
        Else
            Z_plus_i(i) = 0
        End If
    Next i
    ' Вычисление Z_i_plus(num)
    Z_i_plus(num) = 0
    For i = 0 To N1 - 1
        Z_i_plus(num) = Z_i_plus(num) + V(i, num) * Z(i, num)
    Next i
    If V_i_plus(num) > 0 Then
        Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
    Else
        Z_i_plus(num) = 0
    End If

    ' Вычисление Z_i(num)
    Z_i(num) = 0
    For i = 0 To N1 - 1
        Z_i(num) = Z_i(num) + V(i, num) * Z_plus_i(i)
    Next i
    If V_i_plus(num) > 0 Then
        Z_i(num) = Z_i(num) / V_i_plus(num)
    Else
        Z_i(num) = 0
    End If

    ' Непосредственное вычисление Ind2(num)
    If Z_i(num) > 0 Then
        Ind2(num) = Z_i_plus(num) / Z_i(num)
    Else
        Ind2(num) = 0
    End If
    Worksheets(List_Name_1).Cells(num + 2, 5).Value = Ind2(num)
Next num

Worksheets(List_Name_1).Activate
End Sub


