Option Explicit
Dim i As Integer
Dim j As Integer
Dim k As Integer


Dim foundCount As Integer

Dim N1 As Integer 'êîëè÷åñòâî ãðóïï ïî ìåñÿöó äåéñòâèÿ
Dim N2 As Integer 'êîëè÷åñòâî ãðóïï ïî ìåñÿöó êàëåíäàðíîìó

Dim Z() As Double 'ìàòðèöà çíà÷åíèé íîðìèðîâàííîãî óáûòêà
Dim V() As Double 'ìàòðèöà çíà÷åíèé ýêñïîçèöèè (îáúåìà)
Dim S() As Double 'ìàòðèöà çíà÷åíèé óáûòêà

Dim F1() As String
Dim F2() As String

Dim K1() As Double 'âåêòîð çíà÷åíèé êîýôôèöèåíòîâ ïî ìåñÿöó äåéñòâèÿ
Dim tempK1() As Double 'òåêóùèé âåêòîð çíà÷åíèé êîýôôèöèåíòîâ ïî ìåñÿöó äåéñòâèÿ
Dim K2() As Double 'âåêòîð çíà÷åíèé êîýôôèöèåíòîâ ïî ìåñÿöó êàëåíäàðíîìó
Dim tempK2() As Double 'òåêóùèé âåêòîð çíà÷åíèé êîýôôèöèåíòîâ ïî ìåñÿöó êàëåíäàðíîìó

Dim dist As Double 'âåëè÷èíà îøèáêè ïðè òåêóùåé èòåðàöèè
Dim eps As Double 'äîïóñòèìàÿ îøèáêà (êðèòåðèé ïðåêðàùåíèÿ èòåðàöèé)

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

Sub Ðàñ÷åò()
Dim Count As Integer
Dim num As Integer
Dim g1, g2 As String

Worksheets("Result").Activate

N1 = Application.WorksheetFunction.CountA(Columns(1)) - 1
N2 = Application.WorksheetFunction.CountA(Columns(3)) - 1
eps = 0.000001

ReDim Z(N1 - 1, N2 - 1)
ReDim V(N1 - 1, N2 - 1)
ReDim S(N1 - 1, N2 - 1)
ReDim K1(N1 - 1)
ReDim tempK1(N1 - 1)
ReDim K2(N2 - 1)
ReDim tempK2(N2 - 1)
ReDim F1(N1 - 1)
ReDim F2(N2 - 1)


' Ïîñëå èíèöèàëèçàöèè âñåõ ìàññèâîâ
For i = 0 To N1 - 1
    tempK1(i) = 1
Next i
For j = 0 To N2 - 1
    tempK2(j) = 1
Next j
For j = 0 To N2 - 1
    K2(j) = 1
Next j

' ÄÎÁÀÂÜÒÅ ÏÐÎÂÅÐÊÓ:
MsgBox "tempK1(0)=" & tempK1(0) & ", tempK1(12)=" & tempK1(12) & vbCrLf & _
       "tempK2(0)=" & tempK2(0) & ", tempK2(11)=" & tempK2(11) & vbCrLf & _
       "K2(0)=" & K2(0) & ", K2(11)=" & K2(11)
       
For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
Next i
' Ïîñëå çàïîëíåíèÿ F1
For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
Next i
' Ïîñëå çàïîëíåíèÿ F2
For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
Next i

' ÄÎÁÀÂÜÒÅ ÏÐÎÂÅÐÊÓ:
MsgBox "F1(0)=" & F1(0) & ", F1(12)=" & F1(12) & vbCrLf & _
       "F2(0)=" & F2(0) & ", F2(11)=" & F2(11)
For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
Next i

Worksheets("Data").Activate
Count = Application.WorksheetFunction.CountA(Columns(1))
foundCount = 0
For num = 2 To Count
    g1 = Worksheets("Data").Cells(num, 1).Value
    g2 = Worksheets("Data").Cells(num, 2).Value
    For i = 0 To N1 - 1
        For j = 0 To N2 - 1
            If g1 = F1(i) And g2 = F2(j) Then
                foundCount = foundCount + 1  ' <-- ÄÎÁÀÂÜÒÅ ÝÒÓ ÑÒÐÎÊÓ

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

' Ïîñëå öèêëà äîáàâüòå:
MsgBox "Íàéäåíî ñîîòâåòñòâèé: " & foundCount & vbCrLf & _
       "Îæèäàëîñü: " & N1 * N2 & " (13*12=156)"

'Ìåòîä ìàêñèìàëüíîãî ïðàâäîïîäîáèÿ
For i = 0 To N1 - 1
    tempK1(i) = 1
Next i
For j = 0 To N2 - 1
    tempK2(j) = 1
Next j

For j = 0 To N2 - 1 'çàäàåì íà÷àëüíûé åäèíè÷íûé âåêòîð äëÿ èòåðàöèé
    K2(j) = 1
Next j

dist = 1

While dist > eps
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
    
    For i = 0 To N1 - 1
        tempK1(i) = K1(i)
    Next i
    
    For j = 0 To N2 - 1
        tempK2(j) = K2(j)
    Next j
     
Wend

For i = 2 To 1 + N1
    Worksheets("Result").Cells(i, 2).Value = K1(i - 2)
Next i
For j = 2 To 1 + N2
    Worksheets("Result").Cells(j, 4).Value = K2(j - 2)
Next j

Worksheets("Result").Cells(2, 5).Value = 1

Worksheets("Result").Activate
End Sub

