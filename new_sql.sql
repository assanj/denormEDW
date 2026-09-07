-- DROP FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4);

CREATE OR REPLACE FUNCTION actuary.glm_norma(p_k1 numeric[], p_temp_k1 numeric[], p_k2 numeric[], p_temp_k2 numeric[], p_n1 integer, p_n2 integer)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_s1 NUMERIC := 0;  -- Сумма квадратов разностей для K1
    v_s2 NUMERIC := 0;  -- Сумма квадратов разностей для K2
    v_i INTEGER;        -- Счетчик для цикла
BEGIN
    -- Проверка: если какой-либо массив NULL, возвращаем 1 (максимальная ошибка)
    IF p_k1 IS NULL OR p_temp_k1 IS NULL OR p_k2 IS NULL OR p_temp_k2 IS NULL THEN
        RETURN 1;
    END IF;
    
    -- Вычисляем сумму квадратов разностей для K1
    -- Формула: Σ(K1[i] - tempK1[i])²
    FOR v_i IN 1..p_n1 LOOP
        -- Проверяем, что индекс существует в обоих массивах
        IF v_i <= array_length(p_k1, 1) AND v_i <= array_length(p_temp_k1, 1) THEN
            v_s1 := v_s1 + (COALESCE(p_k1[v_i], 0) - COALESCE(p_temp_k1[v_i], 0)) ^ 2;
        END IF;
    END LOOP;
    
    -- Вычисляем сумму квадратов разностей для K2
    -- Формула: Σ(K2[j] - tempK2[j])²
    FOR v_i IN 1..p_n2 LOOP
        -- Проверяем, что индекс существует в обоих массивах
        IF v_i <= array_length(p_k2, 1) AND v_i <= array_length(p_temp_k2, 1) THEN
            v_s2 := v_s2 + (COALESCE(p_k2[v_i], 0) - COALESCE(p_temp_k2[v_i], 0)) ^ 2;
        END IF;
    END LOOP;
    
    -- Возвращаем корень из суммы квадратов (евклидова норма)
    -- Формула: √(s1 + s2)
    RETURN SQRT(v_s1 + v_s2);
END;
$function$
;

-- Permissions

ALTER FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4) OWNER TO mskazakov;
GRANT ALL ON FUNCTION actuary.glm_norma(_numeric, _numeric, _numeric, _numeric, int4, int4) TO mskazakov;


Option Explicit
Dim i As Integer
Dim j As Integer
Dim k As Integer

Dim N1 As Integer
Dim N2 As Integer

Dim Z() As Double
Dim V() As Double
Dim S() As Double

Dim F1() As String
Dim F2() As String

Dim K1() As Double
Dim tempK1() As Double
Dim K2() As Double
Dim tempK2() As Double

Dim dist As Double
Dim eps As Double

Dim s1, s2 As Double

Function norma(A, tempA, B, tempB, N1, N2) As Double

s1 = 0
s2 = 0
For i = 0 To N1 - 1
    s1 = s1 + (A(i) - tempA(i)) ^ 2
Next i
For i = 0 To N2 - 1
    s2 = s2 + (B(i) - tempB(i)) ^ 2
Next i
norma = Sqr(s1 + s2)

End Function

Sub Расчет()
On Error GoTo ErrorHandler

Dim Count As Integer
Dim num As Integer
Dim g1, g2 As String
Dim iterCount As Integer
Dim rowDiag As Integer
Dim foundCount As Integer
Dim sumV As Double
Dim sumS As Double

' ========================================
' ПОЛНАЯ ОЧИСТКА ПЕРЕД ЗАПУСКОМ
' ========================================

' 1. Очищаем все массивы
Erase Z
Erase V
Erase S
Erase K1
Erase tempK1
Erase K2
Erase tempK2
Erase F1
Erase F2

' 2. Очищаем колонки с результатами
Worksheets("Result").Activate
Columns("B:B").ClearContents
Columns("D:D").ClearContents
Columns("G:Z").ClearContents

' 3. Записываем заголовки
Cells(1, 1).Value = "Месяц действия"
Cells(1, 2).Value = "K1"
Cells(1, 3).Value = "Месяц календарный"
Cells(1, 4).Value = "K2"
Cells(1, 5).Value = "Базовая частота"

' ========================================
' ОПРЕДЕЛЕНИЕ РАЗМЕРНОСТЕЙ
' ========================================

N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
eps = 0.000001

' Проверка: если N1 или N2 = 0, то выходим
If N1 = 0 Or N2 = 0 Then
    MsgBox "Ошибка: N1 или N2 равны 0! Проверьте данные на листе Result"
    Exit Sub
End If

' ========================================
' ПЕРЕОПРЕДЕЛЕНИЕ МАССИВОВ
' ========================================

ReDim Z(N1 - 1, N2 - 1)
ReDim V(N1 - 1, N2 - 1)
ReDim S(N1 - 1, N2 - 1)
ReDim K1(N1 - 1)
ReDim tempK1(N1 - 1)
ReDim K2(N2 - 1)
ReDim tempK2(N2 - 1)
ReDim F1(N1 - 1)
ReDim F2(N2 - 1)

' ========================================
' ЗАПОЛНЕНИЕ F1 и F2
' ========================================

For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
Next i

For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
Next i

' ========================================
' ЧТЕНИЕ ДАННЫХ
' ========================================

Worksheets("Data").Activate
Count = Application.WorksheetFunction.CountA(Columns(1))

If Count = 0 Then
    MsgBox "Ошибка: нет данных на листе Data!"
    Exit Sub
End If

foundCount = 0

For num = 2 To Count
    g1 = Worksheets("Data").Cells(num, 1).Value
    g2 = Worksheets("Data").Cells(num, 2).Value
    For i = 0 To N1 - 1
        For j = 0 To N2 - 1
            If g1 = F1(i) And g2 = F2(j) Then
                foundCount = foundCount + 1
                V(i, j) = Worksheets("Data").Cells(num, 4).Value
                S(i, j) = Worksheets("Data").Cells(num, 3).Value
                If V(i, j) > 0 Then
                    Z(i, j) = S(i, j) / V(i, j)
                Else
                    Z(i, j) = 0
                End If
            End If
        Next j
    Next i
Next num

' Проверка: все ли данные найдены
If foundCount <> N1 * N2 Then
    MsgBox "Внимание! Найдено " & foundCount & " соответствий, ожидалось " & N1 * N2
End If

' ========================================
' ИНИЦИАЛИЗАЦИЯ ИНДЕКСОВ
' ========================================

For i = 0 To N1 - 1
    tempK1(i) = 1
    K1(i) = 1
Next i

For j = 0 To N2 - 1
    tempK2(j) = 1
    K2(j) = 1
Next j

dist = 1
iterCount = 0

' ========================================
' ИТЕРАТИВНЫЙ ПРОЦЕСС
' ========================================

While dist > eps And iterCount < 10000
    iterCount = iterCount + 1
    
    ' Обновляем K1
    For i = 0 To N1 - 1
        s1 = 0
        s2 = 0
        For j = 0 To N2 - 1
            If K2(j) <> 0 Then
                s1 = s1 + S(i, j) / K2(j)
            End If
            s2 = s2 + V(i, j)
        Next j
        If s2 > 0 Then
            K1(i) = s1 / s2
        Else
            K1(i) = 1
        End If
    Next i
    
    ' Обновляем K2
    For j = 0 To N2 - 1
        s1 = 0
        s2 = 0
        For i = 0 To N1 - 1
            If K1(i) <> 0 Then
                s1 = s1 + S(i, j) / K1(i)
            End If
            s2 = s2 + V(i, j)
        Next i
        If s2 > 0 Then
            K2(j) = s1 / s2
        Else
            K2(j) = 1
        End If
    Next j
    
    dist = norma(K1, tempK1, K2, tempK2, N1, N2)
    
    For i = 0 To N1 - 1
        tempK1(i) = K1(i)
    Next i
    
    For j = 0 To N2 - 1
        tempK2(j) = K2(j)
    Next j
     
Wend

' ========================================
' ВЫВОД РЕЗУЛЬТАТОВ
' ========================================

Worksheets("Result").Activate

For i = 2 To 1 + N1
    Worksheets("Result").Cells(i, 2).Value = K1(i - 2)
Next i

For j = 2 To 1 + N2
    Worksheets("Result").Cells(j, 4).Value = K2(j - 2)
Next j

Worksheets("Result").Cells(2, 5).Value = 1

' ========================================
' ДИАГНОСТИКА
' ========================================

rowDiag = 1
Cells(rowDiag, 7).Value = "=== ДИАГНОСТИКА ==="
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "N1"
Cells(rowDiag, 8).Value = N1
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "N2"
Cells(rowDiag, 8).Value = N2
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Найдено соответствий"
Cells(rowDiag, 8).Value = foundCount
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Итераций"
Cells(rowDiag, 8).Value = iterCount
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Финальная ошибка"
Cells(rowDiag, 8).Value = dist
rowDiag = rowDiag + 2

' Выводим все K1
Cells(rowDiag, 7).Value = "K1 (все значения)"
rowDiag = rowDiag + 1
For i = 0 To N1 - 1
    Cells(rowDiag + i, 7).Value = "K1(" & i & ")"
    Cells(rowDiag + i, 8).Value = K1(i)
Next i
rowDiag = rowDiag + N1 + 1

' Выводим все K2
Cells(rowDiag, 7).Value = "K2 (все значения)"
rowDiag = rowDiag + 1
For j = 0 To N2 - 1
    Cells(rowDiag + j, 7).Value = "K2(" & j & ")"
    Cells(rowDiag + j, 8).Value = K2(j)
Next j

Columns("G:Z").AutoFit

Worksheets("Result").Activate

MsgBox "Расчет завершен!" & vbCrLf & _
       "Итераций: " & iterCount & vbCrLf & _
       "Финальная ошибка: " & dist

Exit Sub

ErrorHandler:
    MsgBox "Ошибка: " & Err.Description & vbCrLf & "Номер: " & Err.Number
    Resume Next
End Sub


