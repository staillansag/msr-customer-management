#!/bin/sh

cd `dirname $0`
SCRIPTDIR=`pwd`
DOCKER_DIR=${SCRIPTDIR}/
IS_HOME=${DOCKER_DIR}..
WM_HOME=${IS_HOME}/..

COMMON_LIB_EXT_DIR=${WM_HOME}/common/lib/ext
ANT_DIR=${WM_HOME}/common/lib/ant
ANT_LIB_DIR=${ANT_DIR}/lib

GLOBAL_SETENV=${WM_HOME}/install/bin/setenv.sh

if [ -r "$GLOBAL_SETENV" ]; then
    . "$GLOBAL_SETENV"
fi

export JAVA_HOME
export JRE_HOME

JAVA=

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

${JAVA_EXE} -jar "${ANT_LIB_DIR}/ant-launcher.jar" -lib "${ANT_LIB_DIR}/ant.jar:${ANT_DIR}/ant-contrib-1.0b3.jar" -f "${DOCKER_DIR}/is_container.xml" "$@"
