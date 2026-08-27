@echo off
rem A wrapper script to run the daemon with the configured application context.

setlocal

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"
call "%SCRIPT_DIR%setenv.bat"

call "%DEPLOY_DIR%\bin\daemon.bat" %*
