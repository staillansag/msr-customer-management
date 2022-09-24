#!/bin/sh

##############################################################################
# This file can only be used to run Microservices Runtime.                   #
##############################################################################

BINDIR=`dirname $0`
LOGDIR=`dirname ${BINDIR}`/logs

[ -d "${LOGDIR}" ] || mkdir "${LOGDIR}"

NOHUP=""
tty -s && NOHUP=nohup
export NOHUP

${NOHUP} "${BINDIR}/server.sh" $* > "${LOGDIR}/server.out" 2>&1 &
stat=$?
[ -z "${NOHUP}" ] && sleep 3

exit $stat
