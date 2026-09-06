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

' ========================================
' ФУНКЦИЯ НОРМЫ - ИСПРАВЛЕННАЯ
' ========================================
Function norma(A, tempA, B, tempB, N1, N2) As Double
    Dim s1 As Double
    Dim s2 As Double
    Dim idx As Integer
    
    s1 = 0
    s2 = 0
    
    ' Проверяем, что массивы не пустые
    If IsEmpty(A) Or IsEmpty(tempA) Or IsEmpty(B) Or IsEmpty(tempB) Then
        norma = 999999
        Exit Function
    End If
    
    ' Суммируем для K1
    For idx = 0 To N1 - 1
        ' Защита от пустых значений
        If IsNumeric(A(idx)) And IsNumeric(tempA(idx)) Then
            s1 = s1 + (A(idx) - tempA(idx)) ^ 2
        End If
    Next idx
    
    ' Суммируем для K2
    For idx = 0 To N2 - 1
        If IsNumeric(B(idx)) And IsNumeric(tempB(idx)) Then
            s2 = s2 + (B(idx) - tempB(idx)) ^ 2
        End If
    Next idx
    
    norma = Sqr(s1 + s2)
End Function

' ========================================
' ОСНОВНАЯ ПРОЦЕДУРА
' ========================================
Sub Расчет()
    Dim Count As Integer
    Dim num As Integer
    Dim g1, g2 As String
    Dim iterCount As Integer
    Dim foundCount As Integer

    Worksheets("Result").Activate

    ' Определяем размерности
    N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
    N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
    eps = 0.000001
    
    ' Проверка размерностей
    MsgBox "N1=" & N1 & ", N2=" & N2

    ' Переопределяем массивы
    ReDim Z(N1 - 1, N2 - 1)
    ReDim V(N1 - 1, N2 - 1)
    ReDim S(N1 - 1, N2 - 1)
    ReDim K1(N1 - 1)
    ReDim tempK1(N1 - 1)
    ReDim K2(N2 - 1)
    ReDim tempK2(N2 - 1)
    ReDim F1(N1 - 1)
    ReDim F2(N2 - 1)

    ' Заполняем F1 (месяцы действия)
    For i = 0 To N1 - 1
        F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
    Next i
    
    ' Заполняем F2 (календарные месяцы)
    For i = 0 To N2 - 1
        F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
    Next i

    ' Проверка F1 и F2
    MsgBox "F1(0)=" & F1(0) & ", F1(" & N1-1 & ")=" & F1(N1-1) & vbCrLf & _
           "F2(0)=" & F2(0) & ", F2(" & N2-1 & ")=" & F2(N2-1)

    ' Читаем данные
    Worksheets("Data").Activate
    Count = Application.WorksheetFunction.CountA(Columns(1))
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

    ' Проверка заполнения матриц
    MsgBox "Найдено соответствий: " & foundCount & vbCrLf & _
           "Ожидалось: " & N1 * N2

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
    While dist > eps And iterCount < 1000
        iterCount = iterCount + 1
        
        ' Обновляем K1
        For i = 0 To N1 - 1
            s1 = 0
            s2 = 0
            For j = 0 To N2 - 1
                ' ВАЖНО: используем tempK2 (предыдущие значения) или K2 (текущие)?
                ' В классическом GLM используется tempK2 (предыдущие)
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
                ' ВАЖНО: используем tempK1 (предыдущие значения) или K1 (текущие)?
                ' В классическом GLM используется tempK1 (предыдущие)
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
        
        ' Вычисляем ошибку
        dist = norma(K1, tempK1, K2, tempK2, N1, N2)
        
        ' Сохраняем текущие значения как предыдущие
        For i = 0 To N1 - 1
            tempK1(i) = K1(i)
        Next i
        
        For j = 0 To N2 - 1
            tempK2(j) = K2(j)
        Next j
        
        ' Диагностика каждые 10 итераций
        If iterCount Mod 10 = 0 Then
            MsgBox "Итерация " & iterCount & vbCrLf & _
                   "Ошибка: " & dist & vbCrLf & _
                   "K1(0)=" & K1(0) & ", K2(0)=" & K2(0)
        End If
    Wend

    ' ========================================
    ' НОРМАЛИЗАЦИЯ ИНДЕКСОВ (ВАЖНО!)
    ' ========================================
    ' В GLM индексы нормализуются так, чтобы их произведение было равно 1
    ' Или сумма логарифмов = 0
    
    ' Способ 1: Нормализация умножением (как в вашем эталоне)
    Dim sumK1 As Double
    Dim sumK2 As Double
    Dim avgK1 As Double
    Dim avgK2 As Double
    
    sumK1 = 0
    For i = 0 To N1 - 1
        sumK1 = sumK1 + K1(i)
    Next i
    avgK1 = sumK1 / N1
    
    sumK2 = 0
    For j = 0 To N2 - 1
        sumK2 = sumK2 + K2(j)
    Next j
    avgK2 = sumK2 / N2
    
    ' Нормализуем чтобы среднее было = 1
    For i = 0 To N1 - 1
        K1(i) = K1(i) / avgK1
    Next i
    
    For j = 0 To N2 - 1
        K2(j) = K2(j) / avgK2
    Next j

    ' ========================================
    ' ВЫВОД РЕЗУЛЬТАТОВ
    ' ========================================
    Worksheets("Result").Activate
    
    ' Выводим K1 в столбец B
    For i = 2 To 1 + N1
        Worksheets("Result").Cells(i, 2).Value = K1(i - 2)
    Next i
    
    ' Выводим K2 в столбец D
    For j = 2 To 1 + N2
        Worksheets("Result").Cells(j, 4).Value = K2(j - 2)
    Next j

    ' Базовая частота
    Worksheets("Result").Cells(2, 5).Value = 1

    ' Финальное сообщение
    MsgBox "Расчет завершен!" & vbCrLf & _
           "Итераций: " & iterCount & vbCrLf & _
           "Финальная ошибка: " & dist & vbCrLf & _
           "K1(0)=" & K1(0) & ", K2(0)=" & K2(0)
           
    Worksheets("Result").Activate
End Sub
