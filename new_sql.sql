' Добавьте эту переменную в начало процедуры
Dim foundCount As Integer

' Инициализируйте перед циклом
foundCount = 0

' Внутри цикла, где заполняются матрицы:
For num = 2 To Count
    g1 = Worksheets("Data").Cells(num, 1).Value
    g2 = Worksheets("Data").Cells(num, 2).Value
    For i = 0 To N1 - 1
        For j = 0 To N2 - 1
            If g1 = F1(i) And g2 = F2(j) Then
                foundCount = foundCount + 1  ' <-- ДОБАВЬТЕ ЭТУ СТРОКУ
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

' После цикла добавьте:
MsgBox "Найдено соответствий: " & foundCount & vbCrLf & _
       "Ожидалось: " & N1 * N2 & " (13*12=156)"
