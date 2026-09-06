Option Explicit
Dim i As Integer
Dim j As Integer
Dim k As Integer

Dim N1 As Integer 'количество групп по месяцу действия
Dim N2 As Integer 'количество групп по месяцу календарному

Dim Z() As Double 'матрица значений нормированного убытка
Dim V() As Double 'матрица значений экспозиции (объема)
Dim S() As Double 'матрица значений убытка

Dim F1() As String
Dim F2() As String

Dim K1() As Double 'вектор значений коэффициентов по месяцу действия
Dim tempK1() As Double 'текущий вектор значений коэффициентов по месяцу действия
Dim K2() As Double 'вектор значений коэффициентов по месяцу календарному
Dim tempK2() As Double 'текущий вектор значений коэффициентов по месяцу календарному

Dim dist As Double 'величина ошибки при текущей итерации
Dim eps As Double 'допустимая ошибка (критерий прекращения итераций)

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
Dim Count As Integer
Dim num As Integer
Dim g1, g2 As String
Dim iterCount As Integer  ' ДОБАВЛЕНО для диагностики
Dim rowDiag As Integer   ' ДОБАВЛЕНО для диагностики

Worksheets("Result").Activate

' ===== ДИАГНОСТИКА: очищаем колонки для вывода =====
Columns("G:Z").ClearContents
rowDiag = 1

N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
eps = 0.000001

' ===== ДИАГНОСТИКА: выводим N1, N2 =====
Cells(rowDiag, 7).Value = "N1"
Cells(rowDiag, 8).Value = N1
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "N2"
Cells(rowDiag, 8).Value = N2
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "eps"
Cells(rowDiag, 8).Value = eps
rowDiag = rowDiag + 2

ReDim Z(N1 - 1, N2 - 1)
ReDim V(N1 - 1, N2 - 1)
ReDim S(N1 - 1, N2 - 1)
ReDim K1(N1 - 1)
ReDim tempK1(N1 - 1)
ReDim K2(N2 - 1)
ReDim tempK2(N2 - 1)
ReDim F1(N1 - 1)
ReDim F2(N2 - 1)

' ===== ДИАГНОСТИКА: выводим F1 и F2 =====
Cells(rowDiag, 7).Value = "F1 (месяцы действия)"
rowDiag = rowDiag + 1
For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
    Cells(rowDiag + i, 7).Value = "F1(" & i & ")"
    Cells(rowDiag + i, 8).Value = F1(i)
Next i
rowDiag = rowDiag + N1 + 1

Cells(rowDiag, 7).Value = "F2 (календарные месяцы)"
rowDiag = rowDiag + 1
For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
    Cells(rowDiag + i, 7).Value = "F2(" & i & ")"
    Cells(rowDiag + i, 8).Value = F2(i)
Next i
rowDiag = rowDiag + N2 + 2

Worksheets("Data").Activate
Count = Application.WorksheetFunction.CountA(Columns(1))

' ===== ДИАГНОСТИКА: счетчик найденных соответствий =====
Dim foundCount As Integer
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

' ===== ДИАГНОСТИКА: выводим количество найденных соответствий =====
Cells(rowDiag, 7).Value = "Найдено соответствий"
Cells(rowDiag, 8).Value = foundCount
Cells(rowDiag, 9).Value = "Ожидалось: " & N1 * N2
rowDiag = rowDiag + 2

' ===== ДИАГНОСТИКА: выводим суммы V и S =====
Dim sumV As Double
Dim sumS As Double
sumV = 0
sumS = 0
For i = 0 To N1 - 1
    For j = 0 To N2 - 1
        sumV = sumV + V(i, j)
        sumS = sumS + S(i, j)
    Next j
Next i

Cells(rowDiag, 7).Value = "Сумма V (Exp)"
Cells(rowDiag, 8).Value = sumV
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Сумма S (MCL)"
Cells(rowDiag, 8).Value = sumS
rowDiag = rowDiag + 2

'Метод максимального правдоподобия
For i = 0 To N1 - 1
    tempK1(i) = 1
Next i
For j = 0 To N2 - 1
    tempK2(j) = 1
Next j

For j = 0 To N2 - 1 'задаем начальный единичный вектор для итераций
    K2(j) = 1
Next j

dist = 1
iterCount = 0

' ===== ДИАГНОСТИКА: заголовки для итераций =====
Cells(rowDiag, 7).Value = "=== ИТЕРАЦИИ ==="
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "№"
Cells(rowDiag, 8).Value = "dist"
Cells(rowDiag, 9).Value = "K1(0)"
Cells(rowDiag, 10).Value = "K2(0)"
rowDiag = rowDiag + 1

While dist > eps
    iterCount = iterCount + 1
    
    For i = 0 To N1 - 1
        s1 = 0
        s2 = 0
        For j = 0 To N2 - 1
            s1 = s1 + S(i, j) / K2(j)
            s2 = s2 + V(i, j)
        Next j
        K1(i) = s1 / s2
    Next i
    
    For j = 0 To N2 - 1
        s1 = 0
        s2 = 0
        For i = 0 To N1 - 1
                s1 = s1 + S(i, j) / K1(i)
                s2 = s2 + V(i, j)
        Next i
        K2(j) = s1 / s2
    Next j
    
        
    dist = norma(K1, tempK1, K2, tempK2, N1, N2)
    
    ' ===== ДИАГНОСТИКА: выводим каждую 5-ю итерацию =====
    If iterCount Mod 5 = 0 Or iterCount = 1 Then
        Cells(rowDiag, 7).Value = iterCount
        Cells(rowDiag, 8).Value = dist
        Cells(rowDiag, 9).Value = K1(0)
        Cells(rowDiag, 10).Value = K2(0)
        rowDiag = rowDiag + 1
    End If
    
    For i = 0 To N1 - 1
        tempK1(i) = K1(i)
    Next i
    
    For j = 0 To N2 - 1
        tempK2(j) = K2(j)
    Next j
     
Wend

' ===== ДИАГНОСТИКА: финальный отчет =====
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "=== ФИНАЛЬНЫЙ ОТЧЕТ ==="
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Всего итераций"
Cells(rowDiag, 8).Value = iterCount
rowDiag = rowDiag + 1
Cells(rowDiag, 7).Value = "Финальная ошибка"
Cells(rowDiag, 8).Value = dist
rowDiag = rowDiag + 2

' ===== ДИАГНОСТИКА: выводим все K1 и K2 =====
Cells(rowDiag, 7).Value = "=== ВСЕ K1 ==="
rowDiag = rowDiag + 1
For i = 0 To N1 - 1
    Cells(rowDiag + i, 7).Value = "K1(" & i & ")"
    Cells(rowDiag + i, 8).Value = K1(i)
Next i
rowDiag = rowDiag + N1 + 1

Cells(rowDiag, 7).Value = "=== ВСЕ K2 ==="
rowDiag = rowDiag + 1
For j = 0 To N2 - 1
    Cells(rowDiag + j, 7).Value = "K2(" & j & ")"
    Cells(rowDiag + j, 8).Value = K2(j)
Next j

' ===== ВЫВОД РЕЗУЛЬТАТОВ (ОРИГИНАЛЬНЫЙ КОД) =====
For i = 2 To 1 + N1
    Worksheets("Result").Cells(i, 2).Value = K1(i - 2)
Next i
For j = 2 To 1 + N2
    Worksheets("Result").Cells(j, 4).Value = K2(j - 2)
Next j

Worksheets("Result").Cells(2, 5).Value = 1

' ===== ДИАГНОСТИКА: автоподбор ширины =====
Columns("G:Z").AutoFit

Worksheets("Result").Activate

MsgBox "Расчет завершен!" & vbCrLf & _
       "Итераций: " & iterCount & vbCrLf & _
       "Финальная ошибка: " & dist & vbCrLf & _
       "Смотрите диагностику в колонках G-Z"

End Sub
