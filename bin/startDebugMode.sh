#!/bin/sh
DIRNAME=`dirname $0`

#Default debug port
DEBUG_PORT=10033
#Default suspend mode
SUSPEND_MODE=y

SKIP_SUSPEND=n
SKIP_PORT=n

for p in $*
do
	if [ "$#" -ge 2 ]; then
	  if [ "$1" = "address" ]; then 
	     if [ "$SKIP_PORT" != "y" ]; then
		    DEBUG_PORT=$2
			SKIP_PORT=y			
		 fi
		 shift 2
	  fi  
	fi
	
	if [ "$#" -ge 2 ]; then
	  if [ "$1" = "suspend" ]; then
	     if [ "$SKIP_SUSPEND" != "y" ]; then
	        SUSPEND_MODE=$2
			SKIP_SUSPEND=y
		 fi
		 shift 2
	  fi
	fi	
done

JAVA_DEBUGGER_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=$SUSPEND_MODE,address=*:$DEBUG_PORT"

if [ -x "${DIRNAME}/server.sh" ]; then
  . ${DIRNAME}/server.sh $*
fi
