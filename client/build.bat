@echo off
rem Builds bin\unit.swf with mxmlc.
rem The SDK is taken from FLEX_HOME (default: ..\tools\flexsdk460). Paths can be set in
rem local.bat (not in git, see local.bat.example). Adobe Flex SDK 4.6.0 build 23201 is the
rem toolchain of the original unit.swf; Apache Flex 4.16 also works but gives different bytecode.
rem Usage: build.bat [output.swf]
setlocal
cd /d "%~dp0"
if exist "%~dp0local.bat" call "%~dp0local.bat"
if "%FLEX_HOME%"=="" set "FLEX_HOME=%~dp0..\tools\flexsdk460"
set "OUT=%~1"
if "%OUT%"=="" set "OUT=bin/unit.swf"
if not exist bin mkdir bin
set OPTS=-source-path+=src -target-player=11.1 -swf-version=14 -static-link-runtime-shared-libraries=true -warnings=false
if exist "%FLEX_HOME%\bin\mxmlc.bat" goto apache
if not exist "%FLEX_HOME%\lib\mxmlc.jar" goto nosdk
rem Adobe Flex 4.6: its mxmlc.exe looks for a 32-bit JRE in the registry, so start the compiler jar directly
java -Xmx384m -Dsun.io.useCanonCaches=false -jar "%FLEX_HOME%\lib\mxmlc.jar" +flexlib="%FLEX_HOME%\frameworks" %OPTS% "-output=%OUT%" src/unit.as
exit /b %ERRORLEVEL%
:apache
rem Apache Flex 4.16 looks for playerglobal.swc through the {playerglobalHome} token
if "%PLAYERGLOBAL_HOME%"=="" set "PLAYERGLOBAL_HOME=%FLEX_HOME%\frameworks\libs\player"
call "%FLEX_HOME%\bin\mxmlc.bat" +playerglobalHome="%PLAYERGLOBAL_HOME%" %OPTS% "-output=%OUT%" src/unit.as
exit /b %ERRORLEVEL%
:nosdk
echo Flex SDK not found in %FLEX_HOME%; set FLEX_HOME (see local.bat.example).
exit /b 1
