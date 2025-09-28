@echo off
rem Deploys web application (front-end) files.
rem It also restores specific web application files from the restore directory.

rem Load environment variables
call "%~dp0\setenv.bat"

echo Deploying web applications to %DEPLOY_DIR%\webapps ...
if exist "%REPO_DIR%\app\webapps" (
  if not exist "%DEPLOY_DIR%\webapps" mkdir "%DEPLOY_DIR%\webapps"
  if exist "%DEPLOY_DIR%\webapps" rmdir /s /q "%DEPLOY_DIR%\webapps"
  mkdir "%DEPLOY_DIR%\webapps"
  xcopy /s /e /i /q /y "%REPO_DIR%\app\webapps\*" "%DEPLOY_DIR%\webapps"
)

echo Restore specific web application files after deployment ...
if exist "%RESTORE_DIR%\webapps" xcopy /s /e /i /q /y "%RESTORE_DIR%\webapps\*" "%DEPLOY_DIR%\webapps"
