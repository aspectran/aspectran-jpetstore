@echo off
rem Builds the application using Maven and deploys the libraries.

rem Load environment variables
call "%~dp0\setenv.bat"

rem Auto-detect development mode if not explicitly set
if not defined DEV_MODE (
    if exist "%~dp0pom.xml" (
        git -C "%~dp0." rev-parse --is-inside-work-tree >nul 2>nul
        if not errorlevel 1 set "DEV_MODE=true"
    )
)

rem Check if mvn is installed
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Maven (mvn^) is not installed. Please install it and try again.
    exit /b 1
)

echo ========================================================================
echo Build Environment
echo ------------------------------------------------------------------------
if defined JAVA_HOME echo JAVA_HOME: %JAVA_HOME%
for /f "tokens=*" %%i in ('where mvn') do (
    echo which mvn: %%i
    goto :mvn_checked
)
:mvn_checked
call mvn -version
echo ========================================================================

set "TARGET_BUILD_DIR=%REPO_DIR%"
if "%DEV_MODE%"=="true" set "TARGET_BUILD_DIR=%~dp0"
set "LOCK_DIR=%TARGET_BUILD_DIR%\.build.lock"

set /a WAIT_COUNT=0
:ACQUIRE_LOCK
mkdir "%LOCK_DIR%" 2>nul
if %errorlevel% neq 0 (
    if exist "%LOCK_DIR%\success" (
        echo [BUILD LOCK] Build was successfully completed by another node in the shared directory.
        echo [BUILD LOCK] Skipping redundant Maven compilation.
        goto :AFTER_BUILD
    )
    if %WAIT_COUNT% equ 0 (
        echo [BUILD LOCK] Another node is currently building in this directory.
        echo [BUILD LOCK] Waiting for active build to complete...
    )
    set /a WAIT_COUNT+=1
    timeout /t 1 /nobreak >nul
    goto :ACQUIRE_LOCK
)

if "%DEV_MODE%"=="true" (
    echo Development environment detected. Building in %~dp0 ...
    pushd "%~dp0"
    call mvn %MAVEN_ARGS% clean package -Dmaven.test.skip=true %*
    set "BUILD_EXIT_CODE=%errorlevel%"
    popd
    if %BUILD_EXIT_CODE% equ 0 (
        type nul > "%LOCK_DIR%\success"
        timeout /t 1 /nobreak >nul
    )
    rmdir /s /q "%LOCK_DIR%" 2>nul
    exit /b %BUILD_EXIT_CODE%
)

pushd "%REPO_DIR%"
call mvn %MAVEN_ARGS% clean package -Dmaven.test.skip=true %*
set "BUILD_EXIT_CODE=%errorlevel%"
popd
if %BUILD_EXIT_CODE% equ 0 (
    type nul > "%LOCK_DIR%\success"
    timeout /t 1 /nobreak >nul
)
rmdir /s /q "%LOCK_DIR%" 2>nul
if %BUILD_EXIT_CODE% neq 0 exit /b %BUILD_EXIT_CODE%

:AFTER_BUILD
echo Deploying libraries to %DEPLOY_DIR%\lib ...
if exist "%DEPLOY_DIR%\lib\" (
    for /d %%i in ("%DEPLOY_DIR%\lib\*") do rmdir /s /q "%%i"
    del /f /q "%DEPLOY_DIR%\lib\*.*"
) else (
    mkdir "%DEPLOY_DIR%\lib"
)
if exist "%REPO_DIR%\app\lib" (
    xcopy /s /e /i /q /y "%REPO_DIR%\app\lib\*" "%DEPLOY_DIR%\lib"
)
