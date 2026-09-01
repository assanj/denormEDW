Sub Расчет_по_всем()

' Расчет 1: ответственный страховщик, ФЛ, первоначальные

Sheets("DataFull").Select
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=1, Criteria1:="ОтвСтр"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=2, Criteria1:="ФЛ"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=3, Criteria1:="Первоначальный"
Range("D1:G1").Select
Range(Selection, Selection.End(xlDown)).Select
Application.CutCopyMode = False
Selection.Copy
Sheets("Data").Select
Range("A1").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

Calc_Ind
Расчет

Sheets("Result").Select
Range("A2:D14").Select
Selection.Copy
Sheets("ResultFull").Select
Range("A4").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

' Расчет 2: ответственный страховщик, ФЛ, возобновлённые

Sheets("DataFull").Select
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=1, Criteria1:="ОтвСтр"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=2, Criteria1:="ФЛ"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=3, Criteria1:="Возобновлённый"
Range("D1:G1").Select
Range(Selection, Selection.End(xlDown)).Select
Application.CutCopyMode = False
Selection.Copy
Sheets("Data").Select
Range("A1").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

Calc_Ind
Расчет

Sheets("Result").Select
Range("A2:D14").Select
Selection.Copy
Sheets("ResultFull").Select
Range("A20").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

' Расчет 3: ответственный страховщик, ФЛ, ЕГП

Sheets("DataFull").Select
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=1, Criteria1:="ОтвСтр"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=2, Criteria1:="ФЛ"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=3, Criteria1:="ЕГП"
Range("D1:G1").Select
Range(Selection, Selection.End(xlDown)).Select
Application.CutCopyMode = False
Selection.Copy
Sheets("Data").Select
Range("A1").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

Calc_Ind
Расчет

Sheets("Result").Select
Range("A2:D14").Select
Selection.Copy
Sheets("ResultFull").Select
Range("A36").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

' Расчет 4: ответственный страховщик, ЮЛ, первоначальные

Sheets("DataFull").Select
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=1, Criteria1:="ОтвСтр"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=2, Criteria1:="ЮЛ"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=3, Criteria1:="Первоначальный"
Range("D1:G1").Select
Range(Selection, Selection.End(xlDown)).Select
Application.CutCopyMode = False
Selection.Copy
Sheets("Data").Select
Range("A1").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

Calc_Ind
Расчет

Sheets("Result").Select
Range("A2:D14").Select
Selection.Copy
Sheets("ResultFull").Select
Range("A52").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

' Расчет 5: ответственный страховщик, ЮЛ, возобновлённые

Sheets("DataFull").Select
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=1, Criteria1:="ОтвСтр"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=2, Criteria1:="ЮЛ"
ActiveSheet.Range("$A$1:$G$1873").AutoFilter Field:=3, Criteria1:="Возобновлённый"
Range("D1:G1").Select
Range(Selection, Selection.End(xlDown)).Select
Application.CutCopyMode = False
Selection.Copy
Sheets("Data").Select
Range("A1").Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False

Calc_Ind
Расчет

Sheets("Result").Select
Range("A2:D14").Select
Selection.Copy
Sheets("ResultFull").Select
Range("A68").Select
Selecti
