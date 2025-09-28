@echo off
rem Pulls the latest source code from the Git repository.
rem If the repository is not cloned yet, it will be cloned.

rem Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 echo Error: git is not installed. Please install it and try again.
if %errorlevel% neq 0 exit /b 1

rem Load environment variables
call "%~dp0\setenv.bat"

if not exist "%REPO_DIR%" (
  if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
  pushd "%BUILD_DIR%"
  git clone "%REPO_URL%" "%APP_NAME%"
  popd
) else (
  pushd "%REPO_DIR%"
  git pull
  popd
)
