#!/bin/sh


#############################################################################
#                                                                           #
# shutdown.sh : Stops webMethods Microservices Runtime                      #
#                                                                           #
#############################################################################

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

if [ -e ${SCRIPTDIR}/.shutdown ]; then
    rm -f ${SCRIPTDIR}/.shutdown
fi

waitforstop() {
    CNT=0
    while [ $CNT -lt $SHUTDOWN_WAIT ] ; do
        CNT=`expr $CNT + 1`
        echo Waiting for ${APP_NAME} to exit...
        sleep 1
    
        if [ -e ${SCRIPTDIR}/.shutdown ]; then
           echo Stopped ${APP_NAME}.
           rm -f ${SCRIPTDIR}/.shutdown
           exit 0
        fi
    done
}

if [ -e ${SCRIPTDIR}/.lock ]; then
    echo Stopping ${APP_NAME}
    rm -f ${SCRIPTDIR}/.lock
    waitforstop
else
    echo ${SCRIPTDIR}/.lock file doesnot exist. ${APP_NAME} is not running.
fi


