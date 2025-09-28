@echo off
rem Builds the application using Maven and deploys the libraries.

rem Check if mvn is installed
where mvn >nul 2>nul
if %errorlevel% neq 0 echo Error: Maven (mvn) is not installed. Please install it and try again.
if %errorlevel% neq 0 exit /b 1

rem Load environment variables
call "%~dp0\setenv.bat"

pushd "%REPO_DIR%"
call mvn clean package -U -Dmaven.test.skip=true %1
popd

echo Deploying libraries to %DEPLOY_DIR%\lib ...
if exist "%DEPLOY_DIR%\lib\" (
    for /d %%i in ("%DEPLOY_DIR%\lib\*") do rmdir /s /q "%%i"
    del /f /q "%DEPLOY_DIR%\lib\*.*"
) else (
    mkdir "%DEPLOY_DIR%\lib"
)
if exist "%REPO_DIR%\app\lib" (
    xcopy /s /e /i /q /y "%REPO_DIR%\app\lib\*" "%DEPLOY_DIR%\lib"
    if exist "%DEPLOY_DIR%\lib\.ignore" del /f /q "%DEPLOY_DIR%\lib\.ignore"
)
