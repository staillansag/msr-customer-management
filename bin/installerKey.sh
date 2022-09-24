#!/bin/sh
DIRNAME=`dirname $0`
GLOBAL_SETENV=${DIRNAME}/../../install/bin/setenv.sh
IS_DIR=${DIRNAME}
JAVA_MIN_MEM=256M
JAVA_MAX_MEM=1024M
DIRNAME=$IS_DIR

if [ -r "$GLOBAL_SETENV" ]; then
  . "$GLOBAL_SETENV"
fi

SAVED_CP=${CLASSPATH}
SAVED_LD=${LD_LIBRARY_PATH}
SAVED_HP=${SHLIB_PATH}
SAVED_AIX=${LIBPATH}

CLASSPATH="$IS_DIR/lib/wm-isserver.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../../install/jars/DistMan.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../../common/lib/wm-isclient.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../../common/lib/glassfish/gf.jakarta.mail.jar"


if [ "x$JRE_HOME" = "x" ]; then
  JAVA_EXE=$IS_DIR/../../jvm/jvm/jre/bin/java
else
  JAVA_EXE=$JRE_HOME/bin/java
fi


$JAVA_EXE -classpath $CLASSPATH com.wm.security.installerKey $1 $2

rc=$?

CLASSPATH=${SAVED_CP}
LD_LIBRARY_PATH=${SAVED_LD}

export CLASSPATH
export LD_LIBRARY_PATH

if [ -n "${SAVED_HP}" ]; then
   SHLIB_PATH=${SAVED_HP}
   export SHLIB_PATH
fi

if [ -n "${SAVED_AIX}" ]; then
   LIBPATH=${SAVED_AIX}
   export LIBPATH
fi


exit $rc
