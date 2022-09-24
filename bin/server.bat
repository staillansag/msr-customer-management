@echo off

SETLOCAL

SET MSR_DIR=%~dp0..

call "%MSR_DIR%\bin\setenv.bat"

set WM_HOME=%MSR_DIR%\..

set USE_80_AUDIT_TBLS="-Dcom.webmethods.sc.auditing.Use80TableFormat=true" 
set DTM_MANAGER="-Dorg.apache.xml.dtm.DTMManager=org.apache.xml.dtm.ref.DTMManagerDefault"

set XPATH_IMPL=-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl
set ALLOW_ARRAY_CLASSLOADING="-Dsun.lang.ClassLoader.allowArraySyntax=true"
set OVERRIDE_JAVA_SECURITY=-Djava.security.properties=config/security/webm_override_java.security -Djdk.security.auth.login.useCachedLoginModules=true
set LOG4J="-Dlog4j.configurationFile=config/log4j2.properties"

set JAVA_MEMSET=-Xms%JAVA_MIN_MEM% -Xmx%JAVA_MAX_MEM% 
 
set CP_SWITCH=-cp
if exist "%JRE_HOME%\bin\java.exe" (
    set JAVA_EXE="%JRE_HOME%\bin\java.exe"
) else (
	if exist "%JAVA_HOME%\bin\java.exe" (
		set JAVA_EXE="%JAVA_HOME%\bin\java.exe"
	) else (
		set JAVA_EXE="java.exe"
	)    
)

set JAVA_RUN=%JAVA_EXE% %JAVA_MEMSET% -server

set SAVED_CP=%CLASSPATH%
set SAVED_PATH=%PATH%

SET USE_ENV_CLASSPATH=true
SET ENV_CLASSPATH=
if %USE_ENV_CLASSPATH%==true (
	set ENV_CLASSPATH=%SAVED_CP%
)

set PROXY_MAIN=com.wm.app.server.Main
set PROXY_JAR="%MSR_DIR%\lib\wm-isproxy.jar"
set WM_CONVERTERS_JAR="%WM_HOME%\common\lib\wm-converters.jar"
set PREPENDCLASSES_SWITCH=-pcp
set APPENDCLASSES_SWITCH=-acp
set ENV_CLASSPATH_SWITCH=-ecp

:start

if exist %MSR_DIR%\bin\.lock (
    echo Only one Microservices Runtime instance may be run from a particular
    echo installation at a time. Make sure that this server is shutdown
    echo before trying to start it. If no server is running, then
    echo delete the file 
    echo    %MSR_DIR%\bin\.lock 
    echo and try to start the server again.
    goto :EOF
)

rem .... server must start in install directory
cd /d "%MSR_DIR%"

set PATH=%SAVED_PATH%
set CLASSPATH=%PROXY_JAR%;%WM_CONVERTERS_JAR%

rem SSL support
set PATH=%PATH%;%MSR_DIR%\..\common\bin;%MSR_DIR%\..\common\lib;%MSR_DIR%\lib;%MSR_DIR%\support\win32

rem
rem look for native packages: update path as needed
rem native packages contain DLLs that must be added to the path
rem in order to be dynamically loaded by the VM.
rem
for /D %%D in (packages\*) do call :updatePackageInfo %%D

set CLASSPATH=%PREPEND_SYSTEM_CLASSPATH%;%CLASSPATH%;%APPEND_SYSTEM_CLASSPATH%

SET JAVA_OPTS=%JAVA_CUSTOM_OPTS% 

echo Starting %APP_NAME%
title webMethods Microservices Runtime
%JAVA_RUN% %JAVA_OPTS% -DWM_HOME="%WM_HOME%" -Dwatt.server.homeDir="%MSR_DIR%" %USE_80_AUDIT_TBLS% %ALLOW_ARRAY_CLASSLOADING% %OVERRIDE_JAVA_SECURITY% %LOG4J% -classpath %CLASSPATH% %PROXY_MAIN% "%MSR_DIR%"\bin\ini.cnf %PREPENDCLASSES_SWITCH% %PREPENDCLASSES% %APPENDCLASSES_SWITCH% %APPENDCLASSES% %ENV_CLASSPATH_SWITCH% %ENV_CLASSPATH% %* 
set EL=%ERRORLEVEL%

if exist %MSR_DIR%\bin\.lock del %MSR_DIR%\bin\.lock

if "%EL%"=="42" goto start

rem
rem .... restore original classpath and path
set CLASSPATH=%SAVED_CP%
set PATH=%SAVED_PATH%

ENDLOCAL

goto :EOF

:updatePackageInfo
if not exist %1\code\libs goto :EOF
call :prependToPath %1\code\libs
goto :EOF


:prependToPath
set PATH=%1;%PATH%
goto :EOF


:appendClasspath
set CLASSPATH=%CLASSPATH%;%1
goto :EOF
