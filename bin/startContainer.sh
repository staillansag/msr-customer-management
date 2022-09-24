#!/bin/sh

for var in "$@"
do
    export "$var"
    echo $var
done

echo "HOST_DIR=$HOST_DIR"
echo "SERVICE_NAME=$SERVICE_NAME"

export IN_CONTAINER=true
echo "Running in a container"

DIRNAME=`dirname $0`
BINDIR=${DIRNAME}
CONTAINER_INSTANCE_DIR=${DIRNAME}/..
SAG_ROOT_DIR=${DIRNAME}/../..

useVolume="true"
persistLogs="true"
persistConfigs="true"
persistPkgs="false"

if [ "x$HOST_DIR" = "x" ]; then
    useVolume="false"
else

  if [ -d $HOST_DIR ]; then
    echo "Directory hostDir ["$HOST_DIR"] already exist."
  else
    echo "Directory hostDir ["$HOST_DIR"] does not exist. Mount volume is not defined for this service. Now starting service without volume."
    useVolume="false"
  fi

  if [ "x$PERSIST_LOGS" = "x" ]; then
    echo "Logs will be persisted."
  else
    persistLogs=$PERSIST_LOGS
  fi

  if [ "x$PERSIST_CONFIGS" = "x" ]; then
    echo "Configuration will be persisted."
  else
    persistConfigs=$PERSIST_CONFIGS
  fi

  if [ "x$EXTERNALIZE_PACKAGES" = "x" ]; then
    echo "Packages will not be externalized."
  else
    persistPkgs=$EXTERNALIZE_PACKAGES
  fi

fi

if [ "x$SAG_IS_HEALTH_ENDPOINT_ACL" = "x" ]; then
  export SAG_IS_HEALTH_ENDPOINT_ACL=Anonymous
fi
echo "/health endpoint access set to $SAG_IS_HEALTH_ENDPOINT_ACL"

if [ "x$SAG_IS_METRICS_ENDPOINT_ACL" = "x" ]; then
  export SAG_IS_METRICS_ENDPOINT_ACL=Anonymous
fi
echo "/metrics endpoint access set to $SAG_IS_METRICS_ENDPOINT_ACL"

# START OF  USE VOLUME CONDITION
if [ $useVolume == true ]; then

  if [ "x$SERVICE_NAME" = "x" ]; then
   SERVICE_DIR=$HOST_DIR
  else
   SERVICE_DIR=$HOST_DIR/$SERVICE_NAME
  fi


echo CONTAINER_INSTANCE_DIR=$CONTAINER_INSTANCE_DIR

if [ -d $SERVICE_DIR ]; then
  echo "Directory ["$SERVICE_DIR"] already exist."
else
  echo "Directory ["$SERVICE_DIR"] does not exist. Creating the directory."
  mkdir $SERVICE_DIR
fi

if [ $persistLogs == true ]; then

  CONTAINER_LOGS_DIR=${CONTAINER_INSTANCE_DIR}/logs

  echo CONTAINER_LOGS_DIR=$CONTAINER_LOGS_DIR

  LOGS_DIR=$SERVICE_DIR/logs
  echo LOGS_DIR=$LOGS_DIR

  if [ -d $LOGS_DIR ]; then
    echo "Directory ["$LOGS_DIR"] already exist."
  else
    echo "Directory ["$LOGS_DIR"] does not exist. Creating the directory."
    mkdir $LOGS_DIR
  fi

  cp -r -n $CONTAINER_LOGS_DIR/ $SERVICE_DIR/
  rm -r $CONTAINER_LOGS_DIR
  ln -s $LOGS_DIR $CONTAINER_LOGS_DIR
fi


if [ $persistConfigs == true ]; then

  CONTAINER_CONFIG_DIR=${CONTAINER_INSTANCE_DIR}/config
  echo CONTAINER_CONFIG_DIR=$CONTAINER_CONFIG_DIR

  CONFIG_DIR=$SERVICE_DIR/config
  echo CONFIG_DIR=$CONFIG_DIR

  if [ -d $CONFIG_DIR ]; then
    echo "Directory ["$CONFIG_DIR"] already exist."
  else
    echo "Directory ["$CONFIG_DIR"] does not exist. Creating the directory."
    mkdir $CONFIG_DIR
  fi

  cp -r -n $CONTAINER_CONFIG_DIR/ $SERVICE_DIR/
  rm -r $CONTAINER_CONFIG_DIR
  ln -s $CONFIG_DIR $CONTAINER_CONFIG_DIR
fi

if [ $persistPkgs == true ]; then

  CONTAINER_PKGS_DIR=${CONTAINER_INSTANCE_DIR}/packages
  echo CONTAINER_PKGS_DIR=$CONTAINER_PKGS_DIR

  PKGS_DIR=$SERVICE_DIR/packages
  echo PKGS_DIR=$PKGS_DIR

  if [ -d $PKGS_DIR ]; then
    echo "Directory ["$PKGS_DIR"] already exist."
  else
    echo "Directory ["$PKGS_DIR"] does not exist. Creating the directory."
    mkdir $PKGS_DIR
  fi

  cp -rf $CONTAINER_PKGS_DIR/ $SERVICE_DIR/
  rm -r $CONTAINER_PKGS_DIR
  ln -s $PKGS_DIR $CONTAINER_PKGS_DIR
fi

# END OF IF USE VOLUME CONDITION
fi

trap shutdown 0

shutdown()
{
  echo "Trapped Shutdown Signal"
  .${BINDIR}/shutdown.sh
}

if [ -e ${BINDIR}/.lock ]; then
    rm -f ${BINDIR}/.lock
fi

.${BINDIR}/server.sh -log both
