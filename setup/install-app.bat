@echo off
rem Installs the application on a Windows environment.
rem This script clones/pulls the source code and sets up the basic directory structure.

setlocal

rem Get the absolute path of the setup directory
set "SETUP_DIR=%~dp0"

rem Load environment variables
call %SETUP_DIR%setenv.bat

echo Installing application to %BASE_DIR% ...

rem Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: git is not installed. Please install git and try again.
    exit /b 1
)

rem --- Git Clone/Pull ---
if not exist "%REPO_DIR%" (
  if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
  cd /d "%BUILD_DIR%"
  git clone "%REPO_URL%" "%APP_NAME%"
) else (
  cd /d "%REPO_DIR%"
  git pull
)
if errorlevel 1 (
    echo Git operation failed.
    exit /b 1
)

rem --- Create Directory Structure ---
echo Creating directory structure in %DEPLOY_DIR%...
if not exist "%DEPLOY_DIR%\bin" mkdir "%DEPLOY_DIR%\bin"
if not exist "%DEPLOY_DIR%\config" mkdir "%DEPLOY_DIR%\config"
if not exist "%DEPLOY_DIR%\lib" mkdir "%DEPLOY_DIR%\lib"
if not exist "%DEPLOY_DIR%\logs" mkdir "%DEPLOY_DIR%\logs"
if not exist "%DEPLOY_DIR%\temp" mkdir "%DEPLOY_DIR%\temp"
if not exist "%DEPLOY_DIR%\work" mkdir "%DEPLOY_DIR%\work"
if not exist "%RESTORE_DIR%" mkdir "%RESTORE_DIR%"

if exist "%REPO_DIR%\app\cmd" (
    if not exist "%DEPLOY_DIR%\cmd\completed" mkdir "%DEPLOY_DIR%\cmd\completed"
    if not exist "%DEPLOY_DIR%\cmd\failed" mkdir "%DEPLOY_DIR%\cmd\failed"
    if not exist "%DEPLOY_DIR%\cmd\incoming" mkdir "%DEPLOY_DIR%\cmd\incoming"
    if not exist "%DEPLOY_DIR%\cmd\queued" mkdir "%DEPLOY_DIR%\cmd\queued"
    if not exist "%DEPLOY_DIR%\cmd\sample" mkdir "%DEPLOY_DIR%\cmd\sample"
)
if exist "%REPO_DIR%\app\webapps" if not exist "%DEPLOY_DIR%\webapps" mkdir "%DEPLOY_DIR%\webapps"

rem --- Deploy bin and sample commands ---
echo Deploying bin to %DEPLOY_DIR%\bin ...
if exist "%DEPLOY_DIR%\bin" rmdir /s /q "%DEPLOY_DIR%\bin"
mkdir "%DEPLOY_DIR%\bin"
if exist "%REPO_DIR%\app\bin" xcopy /s /e /i /q /y "%REPO_DIR%\app\bin\*" "%DEPLOY_DIR%\bin"

if exist "%REPO_DIR%\app\cmd\sample" (
    if exist "%DEPLOY_DIR%\cmd\sample" rmdir /s /q "%DEPLOY_DIR%\cmd\sample"
    mkdir "%DEPLOY_DIR%\cmd\sample"
    xcopy /s /e /i /q /y "%REPO_DIR%\app\cmd\sample\*" "%DEPLOY_DIR%\cmd\sample"
)

rem --- Copy operational scripts ---
copy /y "%SETUP_DIR%setenv.bat" "%BASE_DIR%"
xcopy /s /e /i /q /y "%REPO_DIR%\setup\scripts\windows\*.bat" "%BASE_DIR%"

echo.
echo --------------------------------------------------------------------------
echo Your application initial setup is complete in "%BASE_DIR%".
echo.
echo To build and deploy the application, run one of the following scripts:
echo   - 5-pull_build_deploy.bat (for full update)
echo   - 8-pull_deploy_webapps_only.bat (for webapps update only)
echo.
echo After deployment, you can run the application interactively:
echo   %DEPLOY_DIR%\bin\shell.bat
echo.
echo To install as a Windows Service, run as an Administrator:
echo   %DEPLOY_DIR%\bin\procrun\install.bat
echo --------------------------------------------------------------------------

endlocal
