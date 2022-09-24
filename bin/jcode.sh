#!/bin/sh

cd `dirname $0`
SCRIPTDIR=`pwd`

IS_DIR=${SCRIPTDIR}/..

IS_COMMON_DIR=${IS_DIR}

CLASSPATH=

# Read the configuration file
if [ "x$RUN_COMMON_SERVER" = "x" ]; then
    RUN_COMMON_SERVER="${IS_COMMON_DIR}/bin/setenv.sh"
fi

if [ -r "$RUN_COMMON_SERVER" ]; then    
    . "$RUN_COMMON_SERVER"
fi

parsejar(){
for dd in $1/code/jars/static/*.jar; do
        if [ "${dd}" != "$1/code/jars/static/*.jar" ]; then
            CLASSPATH=${CLASSPATH}:${dd}
            fi
    
    done

}
Addjarstoclasspath(){
for pkg in $1/*
do
    if [ -d $pkg/code/jars/static ]; then

       parsejar $pkg
    
    fi
    
done

}

Addjarstoclasspath ${IS_DIR}/packages
Addjarstoclasspath ${IS_DIR}/lib/jars
Addjarstoclasspath ${IS_COMMON_DIR}/lib/jars
Addjarstoclasspath ${IS_COMMON_DIR}/../common/lib/ext

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

$JAVA_EXE -cp ${CLASSPATH}:${IS_COMMON_DIR}/../common/lib/glassfish/gf.jakarta.mail.jar:${IS_COMMON_DIR}/../common/lib/glassfish/gf.jaxb-api.jar:${IS_COMMON_DIR}/../common/lib/glassfish/gf.webservices-api-osgi.jar:${IS_COMMON_DIR}/../common/lib/ext/*:${IS_DIR}/lib/jars/custom/*:${IS_COMMON_DIR}/lib/jars/custom/*:${IS_COMMON_DIR}/../common/lib/wm-g11nutils.jar:${IS_COMMON_DIR}/../common/lib/wm-isclient.jar:${IS_COMMON_DIR}/../common/lib/wm-scg-audit.jar:${IS_COMMON_DIR}/../common/lib/wm-scg-core.jar:${IS_COMMON_DIR}/lib/wm-isserver.jar com.wm.app.b2b.server.NodeUtil ${IS_DIR} $*

