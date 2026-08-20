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

if "%DEV_MODE%"=="true" (
    echo Development environment detected. Building in %~dp0 ...
    pushd "%~dp0"
    call mvn %MAVEN_ARGS% clean package -U -Dmaven.test.skip=true %*
    popd
    exit /b 0
)

pushd "%REPO_DIR%"
call mvn %MAVEN_ARGS% clean package -U -Dmaven.test.skip=true %*
popd

echo Deploying libraries to %DEPLOY_DIR%\lib ...
if exist "%DEPLOY_DIR%\lib\" (
    for /d %%i in ("%DEPLOY_DIR%\lib\*") do rmdir /s /q "%%i"
    del /f /q "%DEPLOY_DIR%\lib\*.*"
) else (
    mkdir "%DEPLOY_DIR%\lib"
)
if exist "%REPO_DIR%\app\lib" (
    xcopy /s /e /i /q /y "%REPO_DIR%\app\lib\*" "%DEPLOY_DIR%\lib"
    if exist "%DEPLOY_DIR%\lib\.ignore" del /f /q "%DEPLOY_DIR%\lib\.ignore"
)
