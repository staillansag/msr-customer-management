@echo off
rem -----------------------------------------------------------
rem -- Registers/Unregisters webMethods.dll on 32 bit platforms
rem -- or webMethods64.dll on 64 bit platforms
rem -----------------------------------------------------------
rem

rem -----------------------------------------------------------
rem IS_DIR points to your IS installation
rem This should be modified to point to your installation
rem -----------------------------------------------------------

SET IS_DIR=C:\SoftwareAG\IntegrationServer

rem -----------------------------------------------------------
rem JAVA_DIR points to jvm within your IS installation
rem This should be modified to point to your installation
rem Typical value for 32 bit platform is:
rem JAVA_DIR=C:\SoftwareAG\jvm\win160\jre
rem Typical value for 64 bit platform is:
rem JAVA_DIR=C:\SoftwareAG\jvm\w64_160\jre
rem -----------------------------------------------------------

SET JAVA_DIR=C:\SoftwareAG\jvm\win160\jre

SET PATH=%PATH%;%JAVA_DIR%\bin\server;%JAVA_DIR%\bin

SET unreg=%1
if "%unreg%"=="" goto reg
if "%unreg%"=="unreg" goto unreg
if "%unreg%"=="reg64" goto reg64
if "%unreg%"=="unreg64" goto unreg64

:reg
echo Registering webMethods.dll.  Please wait...
regsvr32 /s /c "%IS_DIR%\support\win32\webMethods.dll"
goto end

:unreg
echo Unregistering webMethods.dll.  Please wait...
regsvr32 /s /c /u "%IS_DIR%\support\win32\webMethods.dll"
goto end

:reg64
echo Registering webMethods64.dll.  Please wait...
regsvr32 /s /c "%IS_DIR%\support\win32\webMethods64.dll"
goto end

:unreg64
echo Unregistering webMethods64.dll.  Please wait...
regsvr32 /s /c /u "%IS_DIR%\support\win32\webMethods64.dll"
goto end 

:end
