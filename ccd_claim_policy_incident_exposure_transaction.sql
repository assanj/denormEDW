@echo off
title Apache Hop Launcher
color 0A

echo ================================================
echo          Apache Hop Launcher
echo ================================================
echo.

set "HOP_DIR=%~dp0"
if "%HOP_DIR:~-1%"=="\" set "HOP_DIR=%HOP_DIR:~0,-1%"

echo Hop directory: %HOP_DIR%
echo.

rem Поиск Java в подпапках
echo Searching for Java in subfolders...
set "JAVA_FOUND=0"
set "JAVA_HOME="

for /d /r "%HOP_DIR%" %%i in (*) do (
    if exist "%%i\bin\java.exe" (
        set "JAVA_HOME=%%i"
        set "JAVA_FOUND=1"
        echo Found Java: %%i
        goto :found_java
    )
)

if "%JAVA_FOUND%"=="0" (
    echo Checking for JDK folders...
    for /d %%i in ("%HOP_DIR%\jdk*") do (
        if exist "%%i\bin\java.exe" (
            set "JAVA_HOME=%%i"
            set "JAVA_FOUND=1"
            echo Found Java: %%i
            goto :found_java
        )
    )
)

:found_java
if "%JAVA_FOUND%"=="0" (
    echo ERROR: Java not found in subfolders!
    echo Checking system Java...
    where java >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Java not found in PATH either!
        echo Please install Java 11+ or place JDK in Hop folder
        pause
        exit /b 1
    ) else (
        echo Using system Java from PATH
    )
) else (
    set "PATH=%JAVA_HOME%\bin;%PATH%"
    echo Using Java: %JAVA_HOME%
)

rem Установка переменных Hop
set "HOP_CONFIG_FOLDER=%HOP_DIR%\config"
set "HOP_AUDIT_FOLDER=%HOP_DIR%\audit"
set "HOP_OPTIONS=-Xmx2048m -Dfile.encoding=UTF-8"

rem Создаем папку audit если нет
if not exist "%HOP_AUDIT_FOLDER%" mkdir "%HOP_AUDIT_FOLDER%"

echo.
echo ================================================
echo          Apache Hop v2.16.0 Ready
echo ================================================
echo.

:menu
echo.
echo Please select action:
echo ================================================
echo 1. Launch Hop GUI (Desktop Interface)
echo 2. Launch Hop Server (Web Interface)
echo 3. Run Hop from Command Line
echo 4. Search in Hop
echo 5. Import configurations
echo 6. Encrypt passwords
echo 7. Show current configuration
echo 8. Open Hop folder in Explorer
echo 9. Check Java version
echo 0. Exit
echo ================================================
echo.

set /p choice="Enter choice [0-9]: "

if "%choice%"=="1" goto launch_gui
if "%choice%"=="2" goto launch_server
if "%choice%"=="3" goto launch_cli
if "%choice%"=="4" goto launch_search
if "%choice%"=="5" goto launch_import
if "%choice%"=="6" goto launch_encrypt
if "%choice%"=="7" goto show_config
if "%choice%"=="8" goto open_folder
if "%choice%"=="9" goto check_java
if "%choice%"=="0" goto exit_program

echo Invalid choice! Please enter 0-9
goto menu

:launch_gui
echo.
echo Launching Hop GUI...
echo.
call hop-gui.bat
goto menu

:launch_server
echo.
echo Launching Hop Server...
echo Will be available at: http://localhost:8080
echo Press Ctrl+C to stop the server
echo.
call hop-server.bat
goto menu

:launch_cli
echo.
echo ================================================
echo Hop Command Line Interface
echo ================================================
echo Usage examples:
echo   hop-run.bat -e dev -r local -f "workflow.hwf"
echo   hop-run.bat -e prod -r local -f "pipeline.hpl"
echo.
echo Common options:
echo   -e : Environment name (dev, prod, etc.)
echo   -r : Run configuration (local, spark, etc.)
echo   -f : File to execute (.hwf or .hpl)
echo   -p : Project name
echo   -v : Variable values (key=value)
echo.
echo Current directory: %HOP_DIR%
echo.
echo Type your command or press Enter for menu:
set /p cmd="hop-run.bat "
if "%cmd%"=="" goto menu
call hop-run.bat %cmd%
echo.
pause
goto menu

:launch_search
echo.
echo Launching Hop Search...
call hop-search.bat
goto menu

:launch_import
echo.
echo Launching Hop Import...
call hop-import.bat
goto menu

:launch_encrypt
echo.
echo Launching Hop Encrypt...
call hop-encrypt.bat
goto menu

:show_config
echo.
echo ================================================
echo Current Configuration
echo ================================================
echo Hop Directory: %HOP_DIR%
echo Java Home: %JAVA_HOME%
echo Hop Config: %HOP_CONFIG_FOLDER%
echo Hop Audit: %HOP_AUDIT_FOLDER%
echo Hop Options: %HOP_OPTIONS%
echo.
echo Available scripts:
dir /b "%HOP_DIR%\*.bat"
echo.
pause
goto menu

:open_folder
echo.
echo Opening Hop folder in Explorer...
start explorer "%HOP_DIR%"
goto menu

:check_java
echo.
echo Java Information:
java -version
echo.
echo JAVA_HOME: %JAVA_HOME%
echo.
pause
goto menu

:exit_program
echo.
echo ================================================
echo Thank you for using Apache Hop!
echo ================================================
timeout /t 2 >nul
exit
