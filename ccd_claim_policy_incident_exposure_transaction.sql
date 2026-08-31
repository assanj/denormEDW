2026/08/31 15:36:30 - Spoon - Using legacy execution engine
2026/08/31 15:36:31 - Spoon - Transformation opened.
2026/08/31 15:36:31 - Spoon - Launching transformation [xls2edw_ref_xls4triangles]...
2026/08/31 15:36:31 - Spoon - Started the transformation execution.
2026/08/31 15:36:32 - xls2edw_ref_xls4triangles - Dispatching started for transformation [xls2edw_ref_xls4triangles]
2026/08/31 15:36:32 - ref_xls4triangles_regions.0 - Connected to database [EDW] (commit=1000)
2026/08/31 15:36:32 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 15:36:32 - Регионы.0 - org.apache.poi.openxml4j.exceptions.InvalidOperationException: Can't open the specified file input stream from file: 'file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx'
2026/08/31 15:36:32 - Регионы.0 - Can't open the specified file input stream from file: 'file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx'
2026/08/31 15:36:32 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 15:36:32 - Регионы.0 - org.apache.poi.openxml4j.exceptions.InvalidOperationException: Can't open the specified file input stream from file: 'file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx'
2026/08/31 15:36:32 - Регионы.0 - Can't open the specified file input stream from file: 'file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx'
2026/08/31 15:36:32 - Регионы.0 - 
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.staxpoi.StaxPoiWorkbook.<init>(StaxPoiWorkbook.java:81)
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:43)
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 15:36:32 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 15:36:32 - Регионы.0 - Caused by: org.apache.poi.openxml4j.exceptions.InvalidOperationException: Can't open the specified file input stream from file: 'file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx'
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.ZipPackage.openZipEntrySourceStream(ZipPackage.java:155)
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.ZipPackage.<init>(ZipPackage.java:142)
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.ZipPackage.<init>(ZipPackage.java:117)
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.OPCPackage.open(OPCPackage.java:257)
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.OPCPackage.open(OPCPackage.java:187)
2026/08/31 15:36:32 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.staxpoi.StaxPoiWorkbook.<init>(StaxPoiWorkbook.java:78)
2026/08/31 15:36:32 - Регионы.0 - 	... 5 more
2026/08/31 15:36:32 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников.xlsx (Синтаксическая ошибка в имени файла, имени папки или метке тома)
2026/08/31 15:36:32 - Регионы.0 - 	at java.io.FileInputStream.open0(Native Method)
2026/08/31 15:36:32 - Регионы.0 - 	at java.io.FileInputStream.open(FileInputStream.java:195)
2026/08/31 15:36:32 - Регионы.0 - 	at java.io.FileInputStream.<init>(FileInputStream.java:138)
2026/08/31 15:36:32 - Регионы.0 - 	at org.apache.poi.openxml4j.opc.ZipPackage.openZipEntrySourceStream(ZipPackage.java:152)
2026/08/31 15:36:32 - Регионы.0 - 	... 10 more
2026/08/31 15:36:32 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 15:36:32 - xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 15:36:32 - xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 15:36:33 - xls2edw_ref_xls4triangles - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Errors detected!
2026/08/31 15:36:33 - Spoon - The transformation has finished!!
2026/08/31 15:36:33 - xls2edw_ref_xls4triangles - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Errors detected!
2026/08/31 15:36:33 - xls2edw_ref_xls4triangles - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Errors detected!
