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

' Âû÷èñëåíèå Ind1()
ReDim V_plus_i(N2 - 1)
ReDim V_i_plus(N1 - 1)
ReDim Z_plus_i(N2 - 1)
ReDim Z_i_plus(N1 - 1)
ReDim Z_i(N1 - 1)

For num = 0 To N1 - 1
    ' Âû÷èñëåíèå V_plus_i()
    For j = 0 To N2 - 1
        V_plus_i(j) = 0
        For i = 0 To N1 - 1
            V_plus_i(j) = V_plus_i(j) + V(i, j)
        Next i
    Next j
    ' Âû÷èñëåíèå V_i_plus(num)
    V_i_plus(num) = 0
    For j = 0 To N2 - 1
        V_i_plus(num) = V_i_plus(num) + V(num, j)
    Next j

    ' Âû÷èñëåíèå Z_plus_i()
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
    
    ' Âû÷èñëåíèå Z_i_plus(num)
    Z_i_plus(num) = 0
    For j = 0 To N2 - 1
        Z_i_plus(num) = Z_i_plus(num) + V(num, j) * Z(num, j)
    Next j
    If V_i_plus(num) > 0 Then
        Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
    Else
        Z_i_plus(num) = 0
    End If

    ' Âû÷èñëåíèå Z_i(num)
    Z_i(num) = 0
    For j = 0 To N2 - 1
        Z_i(num) = Z_i(num) + V(num, j) * Z_plus_i(j)
    Next j
    If V_i_plus(num) > 0 Then
        Z_i(num) = Z_i(num) / V_i_plus(num)
    Else
        Z_i(num) = 0
    End If

    ' Íåïîñðåäñòâåííîå âû÷èñëåíèå Ind1(num)
    If Z_i(num) > 0 Then
        Ind1(num) = Z_i_plus(num) / Z_i(num)
    Else
        Ind1(num) = 0
    End If
    Worksheets(List_Name_1).Cells(num + 2, 2).Value = Ind1(num)
Next num

' Âû÷èñëåíèå Ind2()
ReDim V_plus_i(N1 - 1)
ReDim V_i_plus(N2 - 1)
ReDim Z_plus_i(N1 - 1)
ReDim Z_i_plus(N2 - 1)
ReDim Z_i(N2 - 1)

For num = 0 To N2 - 1
    ' Âû÷èñëåíèå V_plus_i()
    For i = 0 To N1 - 1
        V_plus_i(i) = 0
        For j = 0 To N2 - 1
            V_plus_i(i) = V_plus_i(i) + V(i, j)
        Next j
    Next i
    
    ' Âû÷èñëåíèå V_i_plus(num)
    V_i_plus(num) = 0
    For i = 0 To N1 - 1
        V_i_plus(num) = V_i_plus(num) + V(i, num)
    Next i

    ' Âû÷èñëåíèå Z_plus_i()
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
    ' Âû÷èñëåíèå Z_i_plus(num)
    Z_i_plus(num) = 0
    For i = 0 To N1 - 1
        Z_i_plus(num) = Z_i_plus(num) + V(i, num) * Z(i, num)
    Next i
    If V_i_plus(num) > 0 Then
        Z_i_plus(num) = Z_i_plus(num) / V_i_plus(num)
    Else
        Z_i_plus(num) = 0
    End If

    ' Âû÷èñëåíèå Z_i(num)
    Z_i(num) = 0
    For i = 0 To N1 - 1
        Z_i(num) = Z_i(num) + V(i, num) * Z_plus_i(i)
    Next i
    If V_i_plus(num) > 0 Then
        Z_i(num) = Z_i(num) / V_i_plus(num)
    Else
        Z_i(num) = 0
    End If

    ' Íåïîñðåäñòâåííîå âû÷èñëåíèå Ind2(num)
    If Z_i(num) > 0 Then
        Ind2(num) = Z_i_plus(num) / Z_i(num)
    Else
        Ind2(num) = 0
    End If
    Worksheets(List_Name_1).Cells(num + 2, 5).Value = Ind2(num)
Next num

Worksheets(List_Name_1).Activate
End Sub



в чем разница, ы меня проблема алгоритмы не дают одинаковый результат. эталон на бейсике. постгрес надо привести к этому эталону. в ччем расхождений . исправлять весь код не надо. точечно.  
    -- DROP FUNCTION actuary.glm_calc_main();

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
$function$
;

-- Permissions

ALTER FUNCTION actuary.glm_calc_main() OWNER TO mskazakov;
GRANT ALL ON FUNCTION actuary.glm_calc_main() TO mskazakov;


