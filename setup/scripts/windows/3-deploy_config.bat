@echo off
rem Deploys configuration files.
rem It also restores specific configuration files from the restore directory.

rem Load environment variables
call "%~dp0\setenv.bat"

echo Deploying configurations to %DEPLOY_DIR%\config ...
if exist "%DEPLOY_DIR%\config" rmdir /s /q "%DEPLOY_DIR%\config"
mkdir "%DEPLOY_DIR%\config"
if exist "%REPO_DIR%\app\config" xcopy /s /e /i /q /y "%REPO_DIR%\app\config\*" "%DEPLOY_DIR%\config"

echo Restore specific configuration files after deployment ...
if exist "%RESTORE_DIR%\config" xcopy /s /e /i /q /y "%RESTORE_DIR%\config\*" "%DEPLOY_DIR%\config"
