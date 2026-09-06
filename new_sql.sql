' После инициализации всех массивов
For i = 0 To N1 - 1
    tempK1(i) = 1
Next i
For j = 0 To N2 - 1
    tempK2(j) = 1
Next j
For j = 0 To N2 - 1
    K2(j) = 1
Next j

' ДОБАВЬТЕ ПРОВЕРКУ:
MsgBox "tempK1(0)=" & tempK1(0) & ", tempK1(12)=" & tempK1(12) & vbCrLf & _
       "tempK2(0)=" & tempK2(0) & ", tempK2(11)=" & tempK2(11) & vbCrLf & _
       "K2(0)=" & K2(0) & ", K2(11)=" & K2(11)
