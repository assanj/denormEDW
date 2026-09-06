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
' ФУНКЦИЯ НОРМЫ
' ========================================
Function norma(A, tempA, B, tempB, N1, N2) As Double
    Dim s1 As Double
    Dim s2 As Double
    Dim idx As Integer
    
    s1 = 0
    s2 = 0
    
    ' Суммируем для K1
    For idx = 0 To N1 - 1
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
    Dim rowDebug As Integer  ' Строка для вывода диагностики

    Worksheets("Result").Activate
    
    ' ========================================
    ' ОЧИСТКА ЛИСТА ДЛЯ ДИАГНОСТИКИ
    ' ========================================
    ' Очищаем колонки для диагностики (начиная с колонки G)
    Columns("G:Z").ClearContents
    
    ' Заголовки диагностики
    Cells(1, 7).Value = "=== ДИАГНОСТИКА ==="
    Cells(2, 7).Value = "Параметр"
    Cells(2, 8).Value = "Значение"
    Cells(2, 9).Value = "Примечание"
    
    rowDebug = 3

    ' ========================================
    ' ШАГ 1: ОПРЕДЕЛЕНИЕ РАЗМЕРНОСТЕЙ
    ' ========================================
    N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
    N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
    eps = 0.000001
    
    ' Вывод диагностики
    Cells(rowDebug, 7).Value = "N1 (месяцы действия)"
    Cells(rowDebug, 8).Value = N1
    Cells(rowDebug, 9).Value = "Столбец A"
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "N2 (календарные месяцы)"
    Cells(rowDebug, 8).Value = N2
    Cells(rowDebug, 9).Value = "Столбец C"
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Точность eps"
    Cells(rowDebug, 8).Value = eps
    rowDebug = rowDebug + 2

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

    ' ========================================
    ' ШАГ 2: ЗАПОЛНЕНИЕ F1 и F2
    ' ========================================
    For i = 0 To N1 - 1
        F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
    Next i
    
    For i = 0 To N2 - 1
        F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
    Next i
    
    ' Вывод диагностики
    Cells(rowDebug, 7).Value = "F1(0)"
    Cells(rowDebug, 8).Value = F1(0)
    Cells(rowDebug, 9).Value = "Первый месяц действия"
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "F1(" & N1-1 & ")"
    Cells(rowDebug, 8).Value = F1(N1-1)
    Cells(rowDebug, 9).Value = "Последний месяц действия"
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "F2(0)"
    Cells(rowDebug, 8).Value = F2(0)
    Cells(rowDebug, 9).Value = "Первый календарный месяц"
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "F2(" & N2-1 & ")"
    Cells(rowDebug, 8).Value = F2(N2-1)
    Cells(rowDebug, 9).Value = "Последний календарный месяц"
    rowDebug = rowDebug + 2

    ' ========================================
    ' ШАГ 3: ЗАПОЛНЕНИЕ МАТРИЦ ИЗ ДАННЫХ
    ' ========================================
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
    
    ' Вывод диагностики
    Worksheets("Result").Activate
    Cells(rowDebug, 7).Value = "Найдено соответствий"
    Cells(rowDebug, 8).Value = foundCount
    Cells(rowDebug, 9).Value = "Ожидалось: " & N1 * N2
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Всего строк в Data"
    Cells(rowDebug, 8).Value = Count - 1
    Cells(rowDebug, 9).Value = "Строки данных (без заголовка)"
    rowDebug = rowDebug + 2

    ' Проверка матриц - выводим суммы
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
    
    Cells(rowDebug, 7).Value = "Сумма V (Exp)"
    Cells(rowDebug, 8).Value = sumV
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Сумма S (MCL)"
    Cells(rowDebug, 8).Value = sumS
    rowDebug = rowDebug + 2

    ' ========================================
    ' ШАГ 4: ИНИЦИАЛИЗАЦИЯ ИНДЕКСОВ
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
    
    ' Заголовки для итераций
    Cells(rowDebug, 7).Value = "=== ИТЕРАЦИИ ==="
    rowDebug = rowDebug + 1
    Cells(rowDebug, 7).Value = "Итерация"
    Cells(rowDebug, 8).Value = "Ошибка (dist)"
    Cells(rowDebug, 9).Value = "K1(0)"
    Cells(rowDebug, 10).Value = "K1(1)"
    Cells(rowDebug, 11).Value = "K2(0)"
    Cells(rowDebug, 12).Value = "K2(1)"
    rowDebug = rowDebug + 1

    ' ========================================
    ' ШАГ 5: ИТЕРАТИВНЫЙ ПРОЦЕСС
    ' ========================================
    While dist > eps And iterCount < 1000
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
        
        ' Вычисляем ошибку
        dist = norma(K1, tempK1, K2, tempK2, N1, N2)
        
        ' Сохраняем текущие значения как предыдущие
        For i = 0 To N1 - 1
            tempK1(i) = K1(i)
        Next i
        
        For j = 0 To N2 - 1
            tempK2(j) = K2(j)
        Next j
        
        ' Вывод диагностики каждой итерации (каждую 5-ю для экономии места)
        If iterCount Mod 5 = 0 Or iterCount = 1 Then
            Cells(rowDebug, 7).Value = iterCount
            Cells(rowDebug, 8).Value = dist
            Cells(rowDebug, 9).Value = K1(0)
            Cells(rowDebug, 10).Value = K1(1)
            Cells(rowDebug, 11).Value = K2(0)
            Cells(rowDebug, 12).Value = K2(1)
            rowDebug = rowDebug + 1
        End If
    Wend

    ' ========================================
    ' ШАГ 6: НОРМАЛИЗАЦИЯ ИНДЕКСОВ
    ' ========================================
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
    
    ' Сохраняем значения до нормализации
    Cells(rowDebug, 7).Value = "Сумма K1 до норм."
    Cells(rowDebug, 8).Value = sumK1
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Среднее K1 до норм."
    Cells(rowDebug, 8).Value = avgK1
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Сумма K2 до норм."
    Cells(rowDebug, 8).Value = sumK2
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Среднее K2 до норм."
    Cells(rowDebug, 8).Value = avgK2
    rowDebug = rowDebug + 2
    
    ' Нормализуем чтобы среднее было = 1
    For i = 0 To N1 - 1
        K1(i) = K1(i) / avgK1
    Next i
    
    For j = 0 To N2 - 1
        K2(j) = K2(j) / avgK2
    Next j
    
    ' Вывод после нормализации
    Cells(rowDebug, 7).Value = "K1(0) после норм."
    Cells(rowDebug, 8).Value = K1(0)
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "K2(0) после норм."
    Cells(rowDebug, 8).Value = K2(0)
    rowDebug = rowDebug + 2

    ' ========================================
    ' ШАГ 7: ВЫВОД РЕЗУЛЬТАТОВ
    ' ========================================
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

    ' ========================================
    ' ШАГ 8: ФИНАЛЬНАЯ ДИАГНОСТИКА
    ========================================
    rowDebug = rowDebug + 1
    Cells(rowDebug, 7).Value = "=== ФИНАЛЬНЫЙ ОТЧЕТ ==="
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Всего итераций"
    Cells(rowDebug, 8).Value = iterCount
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Финальная ошибка"
    Cells(rowDebug, 8).Value = dist
    rowDebug = rowDebug + 1
    
    Cells(rowDebug, 7).Value = "Статус"
    If dist <= eps Then
        Cells(rowDebug, 8).Value = "СХОДИМОСТЬ ДОСТИГНУТА"
        Cells(rowDebug, 9).Value = "OK"
    Else
        Cells(rowDebug, 8).Value = "ПРЕВЫШЕН ЛИМИТ ИТЕРАЦИЙ"
        Cells(rowDebug, 9).Value = "Проверьте данные"
    End If
    rowDebug = rowDebug + 2
    
    ' Вывод всех K1 и K2 для сравнения
    Cells(rowDebug, 7).Value = "=== K1 (все значения) ==="
    rowDebug = rowDebug + 1
    For i = 0 To N1 - 1
        Cells(rowDebug + i, 7).Value = "K1(" & i & ")"
        Cells(rowDebug + i, 8).Value = K1(i)
    Next i
    rowDebug = rowDebug + N1 + 1
    
    Cells(rowDebug, 7).Value = "=== K2 (все значения) ==="
    rowDebug = rowDebug + 1
    For j = 0 To N2 - 1
        Cells(rowDebug + j, 7).Value = "K2(" & j & ")"
        Cells(rowDebug + j, 8).Value = K2(j)
    Next j
    
    ' Автоподбор ширины колонок для диагностики
    Columns("G:Z").AutoFit
    
    Worksheets("Result").Activate
    
    MsgBox "Расчет завершен!" & vbCrLf & _
           "Итераций: " & iterCount & vbCrLf & _
           "Финальная ошибка: " & dist & vbCrLf & _
           "Результаты и диагностика на листе Result" & vbCrLf & _
           "Смотрите колонки G-Z"
End Sub
