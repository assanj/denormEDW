' После заполнения F1
For i = 0 To N1 - 1
    F1(i) = CStr(Worksheets("Result").Cells(i + 2, 1).Value)
Next i

' После заполнения F2
For i = 0 To N2 - 1
    F2(i) = CStr(Worksheets("Result").Cells(i + 2, 3).Value)
Next i

' ДОБАВЬТЕ ПРОВЕРКУ:
MsgBox "F1(0)=" & F1(0) & ", F1(12)=" & F1(12) & vbCrLf & _
       "F2(0)=" & F2(0) & ", F2(11)=" & F2(11)
