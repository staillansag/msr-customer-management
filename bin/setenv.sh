#!/bin/sh

##############################################################################
#
# This file contains parameters that can be modified by users.
#
##############################################################################

## ---- SET INITIALLY BY THE INSTALLER ----

BINDIR=`dirname $0`
GLOBAL_SETENV=${BINDIR}/../../install/bin/setenv.sh
APP_NAME="Software AG Microservices Runtime"

OLD_JAVA_HOME=$JAVA_HOME
if [ -r "$GLOBAL_SETENV" ]; then
    . "$GLOBAL_SETENV"
fi

if [ "x$JRE_HOME" = "x" ]; then
    JAVA_DIR=$OLD_JAVA_HOME
else
    JAVA_DIR=$JRE_HOME
fi

##############################################################################
#
# This file contains parameters that can be modified by users.
#
##############################################################################

if [ "x$JAVA_MIN_MEM" = "x" ]; then
    JAVA_MIN_MEM=256M
fi

if [ "x$JAVA_MAX_MEM" = "x" ]; then
    JAVA_MAX_MEM=1024M
fi

JAVA_MEMSET="-ms${JAVA_MIN_MEM} -mx${JAVA_MAX_MEM}"

JAVA_OPT_PREFER_IP4V="-Djava.net.preferIPv4Stack=true"

##############################################################################
#
# Items in PREPENDCLASSES will be added to the classpath right after the server.jar
# Items in the APPENDCLASSES will be added to the absolute end of the CLASSPATH
#
##############################################################################

PREPENDCLASSES=
APPENDCLASSES=

##############################################################################
#
# Items in PREPEND_SYSTEM_CLASSPATH will be added to the classpath before proxy.jar
# Items in APPEND_SYSTEM_CLASSPATH will be added to the absolute end of the CLASSPATH
#
##############################################################################

PREPEND_SYSTEM_CLASSPATH=
APPEND_SYSTEM_CLASSPATH=

if [ "x$SHUTDOWN_WAIT" = "x" ]; then
    SHUTDOWN_WAIT=300 
fi

##############################################################################
#
# Enter your custom Java options in the variable JAVA_CUSTOM_OPTS
# e.g. JAVA_CUSTOM_OPTS="-Dmy.prop1=value1 -Dmy.prop2=value2"
##############################################################################

JAVA_CUSTOM_OPTS="${JAVA_CUSTOM_OPTS} ${JAVA_DEBUGGER_OPTS}"

##############################################################################
#
# Java options for Remote Debugging, JMX, and Profiling
# 
##############################################################################

JMX_ENABLED=false
PROFILER_ENABLED=false

JMX_PORT=9192

JAVA_JMX_OPTS="-Dcom.sun.management.jmxremote.port=${JMX_PORT} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
JAVA_PROFILER_OPTS="-javaagent:lib/jars/profiler-agent.jar=log=logs/profiler.log,level=2"

if [ "$JMX_ENABLED" = "true" ]; then
     JAVA_CUSTOM_OPTS="${JAVA_CUSTOM_OPTS} ${JAVA_JMX_OPTS}"
fi

if [ "$PROFILER_ENABLED" = "true" ]; then
  	JAVA_CUSTOM_OPTS="${JAVA_CUSTOM_OPTS} ${JAVA_PROFILER_OPTS}"
fi
