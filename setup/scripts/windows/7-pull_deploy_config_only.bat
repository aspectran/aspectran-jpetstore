@echo off
rem Pulls the latest source and deploys configuration files only.

call "%~dp0\1-pull.bat"
if errorlevel 1 exit /b 1
call "%~dp0\3-deploy_config.bat"
if errorlevel 1 exit /b 1
