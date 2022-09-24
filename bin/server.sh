#!/bin/sh

#############################################################################
#                                                                           #
# server.sh : launch webMethods Microservices Runtime                       #
#                                                                           #
#############################################################################

[ -z "$NOHUP" ] && trap "" TERM HUP
unset NOHUP

cd `dirname $0`
SCRIPTDIR=`pwd`

MSR_DIR=${SCRIPTDIR}/..

# Read the configuration file
if [ "x$RUN_CONF" = "x" ]; then
    RUN_CONF="${MSR_DIR}/bin/setenv.sh"
fi

if [ -r "$RUN_CONF" ]; then
    . "$RUN_CONF"
fi

## ---- BE CAREFUL MAKING ANY CHANGES BELOW THIS LINE ----

# Globalization support
WM_HOME=${MSR_DIR}/..
export WM_HOME

USE_80_AUDIT_TBLS="-Dcom.webmethods.sc.auditing.Use80TableFormat=true" 
ALLOW_ARRAY_CLASSLOADING="-Dsun.lang.ClassLoader.allowArraySyntax=true"
DTM_MANAGER="-Dorg.apache.xml.dtm.DTMManager=org.apache.xml.dtm.ref.DTMManagerDefault"
XPATH_IMPL="-Djavax.xml.xpath.XPathFactory:http://java.sun.com/jaxp/xpath/dom=com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl"
OVERRIDE_JAVA_SECURITY="-Djava.security.properties=config/security/webm_override_java.security -Djdk.security.auth.login.useCachedLoginModules=true"

## ---- JAVA VM SETUP ----

if [ -x "${JRE_HOME}/bin/java" ]; then
    JAVA_EXE="${JRE_HOME}/bin/java"
else
	if [ -x "${JAVA_HOME}/bin/java" ]; then
		JAVA_EXE="${JAVA_HOME}/bin/java"
	else 
		JAVA_EXE="java"
	fi
fi

echo Starting ${APP_NAME}
JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET} -server ${JAVA_OPT_PREFER_IP4V} ${USE_80_AUDIT_TBLS} ${ALLOW_ARRAY_CLASSLOADING} ${DTM_MANAGER} ${XPATH_IMPL} ${OVERRIDE_JAVA_SECURITY}"

SAVED_CP=${CLASSPATH}
SAVED_LD=${LD_LIBRARY_PATH}

### NOTE: for AIX ###
SAVED_AIX=${LIBPATH}

## ---- SERVER RUN LOOP ----

### Loop while the exit code is 42 ###

err=42

while [ "${err}" = "42" ]
do

## .... always launch from server directory

if [ -e ${SCRIPTDIR}/.lock ]; then

    echo Only one Microservices Runtime instance may be run from a particular
    echo installation at a time. Make sure that this server is shutdown
    echo before trying to start it. If no server is running, then
    echo delete the file 
    echo ${SCRIPTDIR}/.lock
    echo and try to start the server again.

    exit 0
fi

cd ${MSR_DIR}

touch ${MSR_DIR}/bin/.lock

LD_LIBRARY_PATH=${MSR_DIR}/lib:${SAVED_LD}
LIBPATH=${MSR_DIR}/lib:${SAVED_AIX}

PROXY_MAIN="com.wm.app.server.Main"
PROXY_JAR=${MSR_DIR}/lib/wm-isproxy.jar
WM_CONVERTERS_JAR=${WM_HOME}/common/lib/wm-converters.jar

PREPENDCLASSES_SWITCH="-pcp"
APPENDCLASSES_SWITCH="-acp"
ENV_CLASSPATH_SWITCH="-ecp"

CLASSPATH=${CLASSPATH}:${PROXY_JAR}:${WM_CONVERTERS_JAR}

# SSL support
LD_LIBRARY_PATH=${MSR_DIR}/../common/lib:${MSR_DIR}/../common/bin:${MSR_DIR}/lib:${LD_LIBRARY_PATH}
LIBPATH=${MSR_DIR}/../common/lib:${MSR_DIR}/../common/bin:${MSR_DIR}/lib:${LIBPATH}

for pkg in packages/*
do
    if [ -d $pkg/code/libs ]; then
        path_add=${MSR_DIR}/$pkg/code/libs
        LD_LIBRARY_PATH=${path_add}:${LD_LIBRARY_PATH}
        LIBPATH=${path_add}:${LIBPATH}
    fi
done

CLASSPATH=${CLASSPATH}:${MSR_DIR}/config/Caching

CLASSPATH=$PREPEND_SYSTEM_CLASSPATH:$CLASSPATH:$APPEND_SYSTEM_CLASSPATH

export LD_LIBRARY_PATH
export LIBPATH
export CLASSPATH

JAVA_OPTS="${JAVA_CUSTOM_OPTS}"

## .... run Microservices Runtime
${JAVA_RUN} ${JAVA_D64} ${JAVA_OPTS} -DWM_HOME=${WM_HOME} -Dwatt.server.homeDir=${MSR_DIR} -classpath ${CLASSPATH} ${PROXY_MAIN} ${MSR_DIR}/bin/ini.cnf ${PREPENDCLASSES_SWITCH} ${PREPENDCLASSES} ${APPENDCLASSES_SWITCH} ${APPENDCLASSES} ${ENV_CLASSPATH_SWITCH} ${SAVED_CP}: $*

err=$?

rm -f ${MSR_DIR}/bin/.lock

done

#
# reset some environment variables back to original settings
#
CLASSPATH=${SAVED_CP}
LD_LIBRARY_PATH=${SAVED_LD}

export CLASSPATH
export LD_LIBRARY_PATH

# reset only if not empty
if [ -n "${SAVED_AIX}" ]; then
    LIBPATH=${SAVED_AIX}
    export LIBPATH
fi
