@echo off
rem Pulls the latest source, builds the application, and deploys all components.

call "%~dp0\1-pull.bat"
if errorlevel 1 exit /b 1
call "%~dp0\2-build.bat"
if errorlevel 1 exit /b 1
call "%~dp0\3-deploy_config.bat"
if errorlevel 1 exit /b 1
call "%~dp0\4-deploy_webapps.bat"
if errorlevel 1 exit /b 1
