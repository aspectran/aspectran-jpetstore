@echo off
setlocal

if "%1"=="/?" goto help

set CURRENT_DIR=%CD%
cd %~dp0..\..
set BASE_DIR=%CD%
cd %CURRENT_DIR%

rem Set any explicitly specified variables required to run.
if exist %~dp0\procrun.options (
    for /F "eol=# tokens=*" %%i in (%~dp0\procrun.options) do set "%%i"
)

if "%SERVICE_NAME%" == "" set SERVICE_NAME=%1
rem If no ServiceName is specified, the default is "Aspectran"
if not defined SERVICE_NAME (
  set SERVICE_NAME=Aspectran
)

rem Detect JAVA_HOME environment variable
if "%JAVA_HOME%" == "" goto java-not-set
call :ResolvePath JAVA_HOME %JAVA_HOME%
if not exist "%JAVA_HOME%" goto java-not-set

if "%JVM_MS%" == "" set JVM_MS=256
if "%JVM_MX%" == "" set JVM_MS=512
if "%JVM_SS%" == "" set JVM_MS=4096

echo Using SERVICE_NAME: %SERVICE_NAME%
echo Using JAVA_HOME: %JAVA_HOME%
echo Using JVM_MS: %JVM_MS%MB
echo Using JVM_MX: %JVM_MX%MB
echo Using JVM_SS: %JVM_SS%KB

rem Detect x86 or amd64
if PROCESSOR_ARCHITECTURE EQU "amd64" goto is-amd64
if PROCESSOR_ARCHITEW6432 EQU "amd64" goto is-amd64
if defined ProgramFiles(x86) goto is-amd64
:is-x86
echo Current System Architecture: x86
set PR_INSTALL=%BASE_DIR%\bin\procrun\prunsrv.exe
goto is-detected
:is-amd64
echo Current System Architecture: amd64
set PR_INSTALL=%BASE_DIR%\bin\procrun\amd64\prunsrv.exe
:is-detected
if not exist "%PR_INSTALL%" goto invalid-installer

echo Windows Service Name: %SERVICE_NAME%
echo Aspectran Home: %BASE_DIR%

rem Service log configuration
set PR_LOGPATH=%BASE_DIR%\logs
set PR_LOGPREFIX=%SERVICE_NAME%
set PR_LOGLEVEL=Debug
set PR_STDOUTPUT=%BASE_DIR%\logs\%SERVICE_NAME%.out
set PR_STDERROR=%BASE_DIR%\logs\%SERVICE_NAME%.err

rem Path to java installation
set PR_JVM=%JAVA_HOME%\jre\bin\server\jvm.dll
if exist "%PR_JVM%" goto jvm-detected
set PR_JVM=%JAVA_HOME%\bin\server\jvm.dll
:jvm-detected
if not exist "%PR_JVM%" goto invalid-jvm
echo Java VM: %PR_JVM%

set PR_CLASSPATH=%BASE_DIR%\lib\*

rem Startup configuration
set PR_STARTUP=manual
set PR_STARTMODE=jvm
set PR_STARTCLASS=com.aspectran.daemon.ProcrunDaemon
set PR_STARTMETHOD=start
set PR_STARTPARAMS=%BASE_DIR%\config\aspectran-config.apon

rem Shutdown configuration
set PR_STOPMODE=jvm
set PR_STOPCLASS=com.aspectran.daemon.ProcrunDaemon
set PR_STOPMETHOD=stop

rem JVM configuration
set PR_JVMMS=%JVM_MS%
set PR_JVMMX=%JVM_MX%
set PR_JVMSS=%JVM_SS%
set PR_JVMOPTIONS=-Duser.language=en;-Duser.region=US;^
-Djava.awt.headless=true;^
-Djava.net.preferIPv4Stack=true;^
-Djava.io.tmpdir=%BASE_DIR%\temp;^
-Daspectran.basePath=%BASE_DIR%;^
-Dlogback.configurationFile=%BASE_DIR%\config\logging\logback.xml

echo Creating Service...
%PR_INSTALL% //IS/%SERVICE_NAME% ^
--DisplayName="%SERVICE_NAME%" ^
--Description="%SERVICE_DESCRIPTION%" ^
--Install="%PR_INSTALL%" ^
--Startup="%PR_STARTUP%" ^
--LogPath="%PR_LOGPATH%" ^
--LogPrefix="%PR_LOGPREFIX%" ^
--LogLevel="%PR_LOGLEVEL%" ^
--StdOutput="%PR_STDOUTPUT%" ^
--StdError="%PR_STDERROR%" ^
--JavaHome="%JAVA_HOME%" ^
--Jvm="%PR_JVM%" ^
--JvmMs="%PR_JVMMS%" ^
--JvmMx="%PR_JVMMX%" ^
--JvmSs="%PR_JVMSS%" ^
--JvmOptions="%PR_JVMOPTIONS%" ^
--Classpath="%PR_CLASSPATH%" ^
--StartMode="%PR_STARTMODE%" ^
--StartClass="%PR_STARTCLASS%" ^
--StartMethod="%PR_STARTMETHOD%" ^
--StartParams="%PR_STARTPARAMS%" ^
--StopMode="%PR_STOPMODE%" ^
--StopClass="%PR_STOPCLASS%" ^
--StopMethod="%PR_STOPMETHOD%"
 
if not errorlevel 1 (
  echo For easy management, copy the prunmgr.exe file with the same name as the service name.
  copy /Y %BASE_DIR%\bin\procrun\prunmgr.exe %BASE_DIR%\bin\procrun\%SERVICE_NAME%.exe
  goto installed
)

echo Failed to install "%SERVICE_NAME%" service.
echo Refer to log in %PR_LOGPATH%
goto end

:java-not-set
echo JAVA_HOME environment variable missing. Please set it before using the script.
goto end

:invalid-jvm
echo Could not find the jvm.dll %PR_JVM%
goto end

:invalid-installer
echo Could not find the installer %PR_INSTALL%
goto end

:installed
echo Service %SERVICE_NAME% created.
if not exist "%SystemRoot%\System32\choice.exe" goto end
%SystemRoot%\System32\choice.exe /C YN /N /M "Do you want to run Service Manager now [Y/N]? "
if errorlevel 2 goto end
start %SERVICE_NAME%.exe
goto end

:help
echo Usage: %~n0 [ServiceName]

:end
exit /b

rem Resolve path to absolute.
rem Param 1: Name of output variable.
rem Param 2: Path to resolve.
rem Return: Resolved absolute path.
:ResolvePath
  set %1=%~dpfn2
  exit /b