
2026/08/31 14:07:11 - Spoon - Using legacy execution engine
2026/08/31 14:07:12 - Spoon - Transformation opened.
2026/08/31 14:07:12 - Spoon - Launching transformation [xls2edw_ref_xls4triangles]...
2026/08/31 14:07:12 - Spoon - Started the transformation execution.
2026/08/31 14:07:17 - Spoon - The transformation has finished!!
2026/08/31 14:25:01 - Spoon - Save as...
2026/08/31 14:29:23 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:29:23 - Регионы.0 - Finished processing (I=91, O=0, R=0, W=91, U=0, E=0)
2026/08/31 14:29:23 - dummy.0 - Finished processing (I=0, O=0, R=91, W=91, U=0, E=0)
2026/08/31 14:29:51 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:29:51 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:29:51 - Регионы.0 - jxl.read.biff.BiffException: Unable to recognize OLE stream
2026/08/31 14:29:51 - Регионы.0 - Unable to recognize OLE stream
2026/08/31 14:29:51 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:29:51 - Регионы.0 - jxl.read.biff.BiffException: Unable to recognize OLE stream
2026/08/31 14:29:51 - Регионы.0 - Unable to recognize OLE stream
2026/08/31 14:29:51 - Регионы.0 - 
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.jxl.XLSWorkbook.<init>(XLSWorkbook.java:54)
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:39)
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:29:51 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:29:51 - Регионы.0 - Caused by: jxl.read.biff.BiffException: Unable to recognize OLE stream
2026/08/31 14:29:51 - Регионы.0 - 	at jxl.read.biff.CompoundFile.<init>(CompoundFile.java:116)
2026/08/31 14:29:51 - Регионы.0 - 	at jxl.read.biff.File.<init>(File.java:127)
2026/08/31 14:29:51 - Регионы.0 - 	at jxl.Workbook.getWorkbook(Workbook.java:268)
2026/08/31 14:29:51 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.jxl.XLSWorkbook.<init>(XLSWorkbook.java:52)
2026/08/31 14:29:51 - Регионы.0 - 	... 5 more
2026/08/31 14:29:51 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:29:51 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:29:51 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:30:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:30:22 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:30:22 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:30:22 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:30:22 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:30:22 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:30:22 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:30:22 - Регионы.0 - 
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:30:22 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:30:22 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:30:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:30:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:30:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:30:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:30:22 - Регионы.0 - 	... 5 more
2026/08/31 14:30:22 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:30:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:30:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:30:52 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:31:24 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:31:24 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:31:24 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:31:24 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:31:24 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:31:24 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:31:24 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:31:24 - Регионы.0 - 
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:31:24 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:31:24 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:31:24 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:31:24 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:31:24 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:31:24 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:31:24 - Регионы.0 - 	... 5 more
2026/08/31 14:31:24 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:31:24 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:31:24 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:32:08 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:32:08 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:32:08 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:32:08 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:32:08 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:32:08 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:32:08 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:32:08 - Регионы.0 - 
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:32:08 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:32:08 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:32:08 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:32:08 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:32:08 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:32:08 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:32:08 - Регионы.0 - 	... 5 more
2026/08/31 14:32:08 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:32:08 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:32:08 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:32:24 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:34:16 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:34:16 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:34:16 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:34:16 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:34:16 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:34:16 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:34:16 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:34:16 - Регионы.0 - 
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:34:16 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:34:16 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:34:16 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:34:16 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:34:16 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:34:16 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:34:16 - Регионы.0 - 	... 5 more
2026/08/31 14:34:16 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:34:16 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:34:16 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:34:26 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Shutting down heartbeat signal for /Projects/Actuary/trash/xls2edw_ref_xls4triangles
2026/08/31 14:35:56 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:36:26 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:37:04 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:37:04 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:37:04 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:37:04 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:37:04 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:37:04 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:37:04 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:37:04 - Регионы.0 - 
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:37:04 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:37:04 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:37:04 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:37:04 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:37:04 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:37:04 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:37:04 - Регионы.0 - 	... 5 more
2026/08/31 14:37:04 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:37:04 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:37:04 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:37:40 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:38:02 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:38:13 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:38:34 - FileInputList - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleFileException: 
2026/08/31 14:38:34 - FileInputList - 
2026/08/31 14:38:34 - FileInputList - Unable to get VFS File object for filename 'ftp://qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx' : Could not connect to FTP server on "qs9".
2026/08/31 14:38:34 - FileInputList - Could not connect to FTP server on "qs9".
2026/08/31 14:38:34 - FileInputList - 
2026/08/31 14:38:34 - FileInputList - Could not connect to FTP server on "qs9".
2026/08/31 14:38:34 - FileInputList - 
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:158)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:109)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.fileinput.FileInputList.createFileList(FileInputList.java:277)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.fileinput.FileInputList.createFileList(FileInputList.java:146)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.trans.steps.excelinput.ExcelInputMeta.getFileList(ExcelInputMeta.java:1339)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.init(ExcelInput.java:786)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.trans.step.StepInitThread.run(StepInitThread.java:69)
2026/08/31 14:38:34 - FileInputList - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:38:34 - FileInputList - Caused by: org.apache.commons.vfs2.FileSystemException: Could not connect to FTP server on "qs9".
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory$ConnectionFactory.createConnection(FtpClientFactory.java:207)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory.createConnection(FtpClientFactory.java:59)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.createClient(FTPClientWrapper.java:77)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.createClient(FTPClientWrapper.java:69)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.getFtpClient(FTPClientWrapper.java:87)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.<init>(FTPClientWrapper.java:51)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpFileProvider.doCreateFileSystem(FtpFileProvider.java:70)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.getFileSystem(AbstractOriginatingFileProvider.java:92)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.findFile(AbstractOriginatingFileProvider.java:71)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.findFile(AbstractOriginatingFileProvider.java:55)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.impl.DefaultFileSystemManager.resolveFile(DefaultFileSystemManager.java:711)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.vfs.ConcurrentFileSystemManager.resolveFile(ConcurrentFileSystemManager.java:91)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.impl.DefaultFileSystemManager.resolveFile(DefaultFileSystemManager.java:648)
2026/08/31 14:38:34 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:152)
2026/08/31 14:38:34 - FileInputList - 	... 7 more
2026/08/31 14:38:34 - FileInputList - Caused by: java.net.ConnectException: Connection timed out: connect
2026/08/31 14:38:34 - FileInputList - 	at java.net.DualStackPlainSocketImpl.connect0(Native Method)
2026/08/31 14:38:34 - FileInputList - 	at java.net.DualStackPlainSocketImpl.socketConnect(DualStackPlainSocketImpl.java:79)
2026/08/31 14:38:34 - FileInputList - 	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
2026/08/31 14:38:34 - FileInputList - 	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
2026/08/31 14:38:34 - FileInputList - 	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
2026/08/31 14:38:34 - FileInputList - 	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:172)
2026/08/31 14:38:34 - FileInputList - 	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
2026/08/31 14:38:34 - FileInputList - 	at java.net.Socket.connect(Socket.java:606)
2026/08/31 14:38:34 - FileInputList - 	at java.net.Socket.connect(Socket.java:555)
2026/08/31 14:38:34 - FileInputList - 	at java.net.Socket.<init>(Socket.java:451)
2026/08/31 14:38:34 - FileInputList - 	at java.net.Socket.<init>(Socket.java:228)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.net.DefaultSocketFactory.createSocket(DefaultSocketFactory.java:53)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.net.SocketClient.connect(SocketClient.java:162)
2026/08/31 14:38:34 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory$ConnectionFactory.createConnection(FtpClientFactory.java:150)
2026/08/31 14:38:34 - FileInputList - 	... 20 more
2026/08/31 14:38:55 - FileInputList - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleFileException: 
2026/08/31 14:38:55 - FileInputList - 
2026/08/31 14:38:55 - FileInputList - Unable to get VFS File object for filename 'ftp://qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx' : Could not connect to FTP server on "qs9".
2026/08/31 14:38:55 - FileInputList - Could not connect to FTP server on "qs9".
2026/08/31 14:38:55 - FileInputList - 
2026/08/31 14:38:55 - FileInputList - Could not connect to FTP server on "qs9".
2026/08/31 14:38:55 - FileInputList - 
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:158)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:109)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.fileinput.FileInputList.createFileList(FileInputList.java:277)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.fileinput.FileInputList.createFilePathList(FileInputList.java:128)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.fileinput.FileInputList.createFilePathList(FileInputList.java:121)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.trans.steps.excelinput.ExcelInputMeta.getFilePaths(ExcelInputMeta.java:1333)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.metaverse.analyzer.kettle.step.excelinput.ExcelInputExternalResourceConsumer.getResourcesFromMeta(ExcelInputExternalResourceConsumer.java:63)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.metaverse.analyzer.kettle.step.excelinput.ExcelInputExternalResourceConsumer.getResourcesFromMeta(ExcelInputExternalResourceConsumer.java:45)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.metaverse.api.analyzer.kettle.step.BaseStepExternalResourceConsumer.getResourcesFromMeta(BaseStepExternalResourceConsumer.java:61)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.metaverse.api.analyzer.kettle.step.BaseStepExternalResourceConsumer.getResourcesFromMeta(BaseStepExternalResourceConsumer.java:43)
2026/08/31 14:38:55 - FileInputList - 	at Proxy960a2ad0_8817_4105_a27f_4fff7c72881c.getResourcesFromMeta(Unknown Source)
2026/08/31 14:38:55 - FileInputList - 	at Proxy960a2ad0_8817_4105_a27f_4fff7c72881c.getResourcesFromMeta(Unknown Source)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.metaverse.analyzer.kettle.extensionpoints.trans.step.StepExternalResourceConsumerListener.callExtensionPoint(StepExternalResourceConsumerListener.java:87)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.extension.ExtensionPointMap.callExtensionPoint(ExtensionPointMap.java:151)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.extension.ExtensionPointHandler.callExtensionPoint(ExtensionPointHandler.java:45)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.trans.Trans.startThreads(Trans.java:1482)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.ui.trans.dialog.TransPreviewProgressDialog.doPreview(TransPreviewProgressDialog.java:187)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.ui.trans.dialog.TransPreviewProgressDialog.access$000(TransPreviewProgressDialog.java:51)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.ui.trans.dialog.TransPreviewProgressDialog$1.run(TransPreviewProgressDialog.java:89)
2026/08/31 14:38:55 - FileInputList - 	at org.eclipse.jface.operation.ModalContext$ModalContextThread.run(ModalContext.java:113)
2026/08/31 14:38:55 - FileInputList - Caused by: org.apache.commons.vfs2.FileSystemException: Could not connect to FTP server on "qs9".
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory$ConnectionFactory.createConnection(FtpClientFactory.java:207)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory.createConnection(FtpClientFactory.java:59)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.createClient(FTPClientWrapper.java:77)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.createClient(FTPClientWrapper.java:69)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.getFtpClient(FTPClientWrapper.java:87)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FTPClientWrapper.<init>(FTPClientWrapper.java:51)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpFileProvider.doCreateFileSystem(FtpFileProvider.java:70)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.getFileSystem(AbstractOriginatingFileProvider.java:92)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.findFile(AbstractOriginatingFileProvider.java:71)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.AbstractOriginatingFileProvider.findFile(AbstractOriginatingFileProvider.java:55)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.impl.DefaultFileSystemManager.resolveFile(DefaultFileSystemManager.java:711)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.vfs.ConcurrentFileSystemManager.resolveFile(ConcurrentFileSystemManager.java:91)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.impl.DefaultFileSystemManager.resolveFile(DefaultFileSystemManager.java:648)
2026/08/31 14:38:55 - FileInputList - 	at org.pentaho.di.core.vfs.KettleVFS.getFileObject(KettleVFS.java:152)
2026/08/31 14:38:55 - FileInputList - 	... 19 more
2026/08/31 14:38:55 - FileInputList - Caused by: java.net.ConnectException: Connection timed out: connect
2026/08/31 14:38:55 - FileInputList - 	at java.net.DualStackPlainSocketImpl.connect0(Native Method)
2026/08/31 14:38:55 - FileInputList - 	at java.net.DualStackPlainSocketImpl.socketConnect(DualStackPlainSocketImpl.java:79)
2026/08/31 14:38:55 - FileInputList - 	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
2026/08/31 14:38:55 - FileInputList - 	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
2026/08/31 14:38:55 - FileInputList - 	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
2026/08/31 14:38:55 - FileInputList - 	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:172)
2026/08/31 14:38:55 - FileInputList - 	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
2026/08/31 14:38:55 - FileInputList - 	at java.net.Socket.connect(Socket.java:606)
2026/08/31 14:38:55 - FileInputList - 	at java.net.Socket.connect(Socket.java:555)
2026/08/31 14:38:55 - FileInputList - 	at java.net.Socket.<init>(Socket.java:451)
2026/08/31 14:38:55 - FileInputList - 	at java.net.Socket.<init>(Socket.java:228)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.net.DefaultSocketFactory.createSocket(DefaultSocketFactory.java:53)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.net.SocketClient.connect(SocketClient.java:162)
2026/08/31 14:38:55 - FileInputList - 	at org.apache.commons.vfs2.provider.ftp.FtpClientFactory$ConnectionFactory.createConnection(FtpClientFactory.java:150)
2026/08/31 14:38:55 - FileInputList - 	... 32 more
2026/08/31 14:41:30 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:41:30 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:41:30 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:30 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:30 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:41:30 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:30 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:30 - Регионы.0 - 
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:41:30 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:41:30 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:30 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:41:30 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:41:30 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:41:30 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:41:30 - Регионы.0 - 	... 5 more
2026/08/31 14:41:30 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:41:30 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:41:30 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:41:43 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:41:43 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file://///qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:41:43 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:43 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:43 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:41:43 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:43 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:43 - Регионы.0 - 
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:41:43 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:41:43 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:41:43 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:41:43 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:41:43 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:41:43 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:41:43 - Регионы.0 - 	... 5 more
2026/08/31 14:41:43 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:41:43 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:41:43 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:42:13 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:42:13 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:42:13 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:42:13 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:42:13 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:42:13 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:42:13 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:42:13 - Регионы.0 - 
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:42:13 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:42:13 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:42:13 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:42:13 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:42:13 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:42:13 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:42:13 - Регионы.0 - 	... 5 more
2026/08/31 14:42:13 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:42:13 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:42:13 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:43:03 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:43:03 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:03 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:03 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:03 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:03 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:03 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:03 - Регионы.0 - 
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:43:03 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:43:03 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:03 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:43:03 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:43:03 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:43:03 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:43:03 - Регионы.0 - 	... 5 more
2026/08/31 14:43:03 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:43:03 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:43:03 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:43:12 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:43:12 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file:////qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:12 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:12 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:12 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:12 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:12 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:12 - Регионы.0 - 
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:43:12 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:43:12 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:12 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:43:12 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:43:12 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:43:12 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:43:12 - Регионы.0 - 	... 5 more
2026/08/31 14:43:12 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:43:12 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:43:12 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:43:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:43:22 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file://///qs9/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:22 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:22 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:22 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:43:22 - Регионы.0 - java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:22 - Регионы.0 - file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:22 - Регионы.0 - 
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:43:22 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:43:22 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\qs9\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:43:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:43:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:43:22 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:43:22 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:43:22 - Регионы.0 - 	... 5 more
2026/08/31 14:43:22 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:43:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:43:22 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
2026/08/31 14:46:35 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Dispatching started for transformation [/Projects/Actuary/trash/xls2edw_ref_xls4triangles]
2026/08/31 14:46:35 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : Error processing row from Excel file [file://///10.221.189.19/qfs_Actuary/Справочники для треугольников_tst.xlsx] : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:46:35 - Регионы.0 - java.io.FileNotFoundException: file:\10.221.189.19\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:46:35 - Регионы.0 - file:\10.221.189.19\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:46:35 - Регионы.0 - ERROR (version 8.2.0.0-342, build 8.2.0.0-342 from 2018-11-14 10.30.55 by buildguy) : org.pentaho.di.core.exception.KettleException: 
2026/08/31 14:46:35 - Регионы.0 - java.io.FileNotFoundException: file:\10.221.189.19\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:46:35 - Регионы.0 - file:\10.221.189.19\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:46:35 - Регионы.0 - 
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:81)
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.WorkbookFactory.getWorkbook(WorkbookFactory.java:41)
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.getRowFromWorkbooks(ExcelInput.java:552)
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.ExcelInput.processRow(ExcelInput.java:432)
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.step.RunThread.run(RunThread.java:62)
2026/08/31 14:46:35 - Регионы.0 - 	at java.lang.Thread.run(Thread.java:748)
2026/08/31 14:46:35 - Регионы.0 - Caused by: java.io.FileNotFoundException: file:\10.221.189.19\qfs_Actuary\Справочники для треугольников_tst.xlsx
2026/08/31 14:46:35 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:250)
2026/08/31 14:46:35 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:226)
2026/08/31 14:46:35 - Регионы.0 - 	at org.apache.poi.ss.usermodel.WorkbookFactory.create(WorkbookFactory.java:205)
2026/08/31 14:46:35 - Регионы.0 - 	at org.pentaho.di.trans.steps.excelinput.poi.PoiWorkbook.<init>(PoiWorkbook.java:73)
2026/08/31 14:46:35 - Регионы.0 - 	... 5 more
2026/08/31 14:46:35 - Регионы.0 - Finished processing (I=0, O=0, R=0, W=0, U=0, E=1)
2026/08/31 14:46:35 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation detected one or more steps with errors.
2026/08/31 14:46:35 - /Projects/Actuary/trash/xls2edw_ref_xls4triangles - Transformation is killing the other steps!
