@echo off
rem Starts the interactive shell with debug mode enabled.

setlocal

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"
call "%SCRIPT_DIR%setenv.bat"

call "%DEPLOY_DIR%\bin\shell.bat" debug %*
