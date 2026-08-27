@echo off
rem Deploys web application (front-end) files.
rem It also restores specific web application files from the restore directory.

rem Load environment variables
call "%~dp0setenv.bat"

rem Auto-detect development mode if not explicitly set
if not defined DEV_MODE (
  if exist "%~dp0pom.xml" (
    git -C "%~dp0." rev-parse --is-inside-work-tree >nul 2>nul
    if not errorlevel 1 set "DEV_MODE=true"
  )
)

if "%DEV_MODE%"=="true" (
  echo Development environment detected.
  echo Skipping webapps deployment to preserve version-controlled files in %DEPLOY_DIR%\webapps.
  exit /b 0
)

echo Deploying web applications to %DEPLOY_DIR%\webapps ...
if exist "%REPO_DIR%\app\webapps" (
  if not exist "%DEPLOY_DIR%\webapps" mkdir "%DEPLOY_DIR%\webapps"
  if exist "%DEPLOY_DIR%\webapps" rmdir /s /q "%DEPLOY_DIR%\webapps"
  mkdir "%DEPLOY_DIR%\webapps"
  xcopy /s /e /i /q /y "%REPO_DIR%\app\webapps\*" "%DEPLOY_DIR%\webapps"
)

echo Restore specific web application files after deployment ...
if exist "%RESTORE_DIR%\webapps" xcopy /s /e /i /q /y "%RESTORE_DIR%\webapps\*" "%DEPLOY_DIR%\webapps"
