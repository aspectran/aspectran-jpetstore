@echo off
rem Deploys configuration files.
rem It also restores specific configuration files from the restore directory.

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
  echo Skipping config deployment to preserve version-controlled files in %DEPLOY_DIR%\config.
  exit /b 0
)

echo Deploying configurations to %DEPLOY_DIR%\config ...
if exist "%DEPLOY_DIR%\config" rmdir /s /q "%DEPLOY_DIR%\config"
mkdir "%DEPLOY_DIR%\config"
if exist "%REPO_DIR%\app\config" xcopy /s /e /i /q /y "%REPO_DIR%\app\config\*" "%DEPLOY_DIR%\config"

echo Restore specific configuration files after deployment ...
if exist "%RESTORE_DIR%\config" xcopy /s /e /i /q /y "%RESTORE_DIR%\config\*" "%DEPLOY_DIR%\config"
