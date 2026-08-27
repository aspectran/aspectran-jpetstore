@echo off
rem Pulls the latest source and deploys configuration files only.

call "%~dp01-pull.bat" %*
if errorlevel 1 exit /b 1
call "%~dp03-deploy_config.bat"
if errorlevel 1 exit /b 1
