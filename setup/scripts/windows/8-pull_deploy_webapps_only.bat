@echo off
rem Pulls the latest source and deploys webapps files only.

call "%~dp01-pull.bat" %*
if errorlevel 1 exit /b 1
call "%~dp04-deploy_webapps.bat"
if errorlevel 1 exit /b 1
