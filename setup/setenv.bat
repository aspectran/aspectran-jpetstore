@echo off
rem ==============================================================================
rem Application Installation and Execution Configuration for Windows
rem ==============================================================================
rem This file is called by other batch scripts to configure deployment and
rem runtime variables.

rem The name of the application. Used for directory names and service names.
set "APP_NAME=aspectow-todo-webapp"

rem The Git repository URL for the application source code.
set "REPO_URL=https://github.com/aspectran/%APP_NAME%"

rem The root directory for the application installation.
set "BASE_DIR=C:\Aspectran\%APP_NAME%"

rem A temporary directory for cloning and building the application from source.
set "BUILD_DIR=%BASE_DIR%\.build"

rem The path to the cloned Git repository within the build directory.
set "REPO_DIR=%BUILD_DIR%\%APP_NAME%"

rem The directory where the runnable application files will be deployed.
set "DEPLOY_DIR=%BASE_DIR%\app"

rem A directory for backing up the previous version during an update.
set "RESTORE_DIR=%BASE_DIR%\app-restore"

rem Java system properties to be passed to the Aspectran application at runtime.
set "ASPECTRAN_OPTS=-Daspectran.profiles.active=prod"
