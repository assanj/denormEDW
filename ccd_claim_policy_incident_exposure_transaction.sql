Calc Ind
___________________________________
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
