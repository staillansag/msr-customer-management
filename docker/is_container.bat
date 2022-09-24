@echo off

SETLOCAL

set SCRIPT_DIR=%~dp0
set DOCKER_DIR=%SCRIPT_DIR%
set IS_HOME=%DOCKER_DIR%..
set WM_HOME=%IS_HOME%\..
set COMMON_LIB_EXT_DIR=%WM_HOME%\common\lib\ext
set ANT_DIR=%WM_HOME%\common\lib\ant
set ANT_LIB_DIR=%ANT_DIR%\lib

call %WM_HOME%\install\bin\setenv.bat

IF "%JAVA_HOME%" == "" (
    set JAVA_HOME=%WM_HOME%\jvm\jvm
) 

IF "%JRE_HOME%" == "" (
    set JAVA_EXE="%WM_HOME%\jvm\jvm\jre\bin\java"
) ELSE (
    SET JAVA_EXE="%JRE_HOME%\bin\java"
)

echo.
echo Executing ANT task. Please wait...
%JAVA_EXE% -jar "%ANT_LIB_DIR%\ant-launcher.jar" -lib "%ANT_LIB_DIR%\ant.jar;%ANT_DIR%\ant-contrib-1.0b3.jar;" -f "%DOCKER_DIR%\is_container.xml" %*

ENDLOCAL

