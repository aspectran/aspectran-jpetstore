@echo off
rem Pulls the latest source and deploys webapps files only.

call "%~dp0\1-pull.bat"
if errorlevel 1 exit /b 1
call "%~dp0\4-deploy_webapps.bat"
if errorlevel 1 exit /b 1
