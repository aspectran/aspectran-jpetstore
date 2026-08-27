@echo off
rem Pulls the latest source and deploys config/webapps components without building.

call "%~dp01-pull.bat" %*
if errorlevel 1 exit /b 1
call "%~dp03-deploy_config.bat"
if errorlevel 1 exit /b 1
call "%~dp04-deploy_webapps.bat"
if errorlevel 1 exit /b 1
