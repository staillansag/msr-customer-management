#!/bin/sh

#############################################################################
#                                                                           #
# migrate.sh : Migrate webMethods Integration Server data                   #
#                                                                           #
#############################################################################

cd `dirname $0`
SCRIPTDIR=`pwd`

IS_DIR=${SCRIPTDIR}/../..
JAVA_MIN_MEM=256M
JAVA_MAX_MEM=1024M

DIRNAME=$IS_DIR/bin

if [ "$1" = "-help" ]; then
	echo ""
	echo "  Usage: migrate.sh [options]"
	echo "  options"
	echo "		-srcDir             Full path to root directory of old Integration Server installation."
	echo "		-srcFile            Full path to ZIP file containing old Integration Server installation."
	echo "		-importFile         migrate<old_release>sbs.dat file containing default migration settings, or full path to migrate.dat file containing custom settings."
	echo "		-instanceName       Name of instance to migrate."
	echo "		-newInstanceName    New name to use for migrated instance."
	echo "		-cloneDbURL         Database URL if you are using a cloned database."
	echo "		-cloneDbUser        Cloned database user."
	echo "		-cloneDbPassword    Cloned database password."
	echo "		-silent true        Runs the migration utility without prompting for user input."
	echo ""
	exit
fi

# Read the configuration file
if [ "x$RUN_CONF" = "x" ]; then
    RUN_CONF="${DIRNAME}/setenv.sh"
fi

if [ -r "$RUN_CONF" ]; then
    . "$RUN_CONF"
fi

GLOBAL_SETENV=${IS_DIR}/../install/bin/setenv.sh
if [ -r "$GLOBAL_SETENV" ]; then
    . "$GLOBAL_SETENV"
fi

MSR_PROD_CHECK=${IS_DIR}/../install/products/MSC.prop
if [ -r "$MSR_PROD_CHECK" ]; then
   PRODUCT_NAME="Microservices Runtime"
else 
   PRODUCT_NAME="Integration Server"
fi

## ---- BE CAREFUL MAKING ANY CHANGES BELOW THIS LINE ----

JAVA_OPT_80_AUDIT_TBLS="-Dcom.webmethods.sc.auditing.Use80TableFormat=true" 

ALLOW_ARRAY_CLASSLOADING="-Dsun.lang.ClassLoader.allowArraySyntax=true"

##
## ---- BE CAREFUL MAKING ANY CHANGES BELOW THIS LINE ----
##

## ---- JAVA VM SETUP ----

if [ "x$JRE_HOME" = "x" ]; then
    JAVA_EXE=$IS_DIR/../jvm/jvm/jre/bin/java
else
    JAVA_EXE=$JRE_HOME/bin/java
fi

if [ `uname -s` = "HP-UX" ]; then
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET} ${JAVA_ARG1}"
else
    JAVA_RUN="${JAVA_EXE} ${JAVA_MEMSET}"
fi

##	SAVE PATHS TO BE RESTORED WHEN FINISHED

SAVED_CP=${CLASSPATH}
SAVED_LD=${LD_LIBRARY_PATH}

## NOTE: for HP-UX 
SAVED_HP=${SHLIB_PATH}

## NOTE: for AIX 
SAVED_AIX=${LIBPATH}


## GATHER ARGUMENTS 

CLASSPATH="$IS_DIR/bin/migrate/lib/migration.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/bin/migrate"
CLASSPATH=${CLASSPATH}:"$IS_DIR/bin/migrate/classes"
CLASSPATH=${CLASSPATH}:"$IS_DIR/bin/migrate/updates/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/lib/wm-isserver.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-is-migration-framework.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-isclient.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-scg-security.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-scg-audit.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-scg-core.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-scg-cluster.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/dd-cjdbc.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/derby.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/glassfish/gf.jakarta.mail.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/glassfish/gf.jaxb-api.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/glassfish/gf.webservices-api-osgi.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/enttoolkit.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/xmlsec.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/log4j/log4j-api.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/log4j/log4j-core.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/log4j/log4j-slf4j-impl.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/activation.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../WS-Stack/lib/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/wm-g11nutils.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/runtime/bundles/tes/eclipse/plugins/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/icu4j.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/packages/WmTN/code/jars/static/tncore.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/packages/WmTN/code/jars/editn.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/packages/WmCloudStreams/code/jars/cloudstreams-connector.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/packages/WmMFT/code/jars/mftutil.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/packages/WmAPIGateway/code/jars/static/apigateway-passman.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ant/lib/ant.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ant/lib/ant-launcher.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ant/ant-contrib-1.0b3.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/migrate/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../install/jars/DistMan.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../install/jars/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/db/lib/*"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/jackson-annotations.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/jackson-core.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/jackson-databind.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/jsch.jar"
CLASSPATH=${CLASSPATH}:"$IS_DIR/../common/lib/ext/maverick-ssh-client.jar"

DB_DIR="$IS_DIR/../common/db"
SSO_DIR="$IS_DIR/../common/bin"

echo ""
echo "webMethods $PRODUCT_NAME Migration Utility"
echo ""

$JAVA_RUN $JAVA_D64 $JAVA_OPTS -Dwatt.migrate.product.dataProvider=com.wm.app.b2b.server.migrate.MigratorAppDataProviderImpl -Dwatt.migrate.product.name="$PRODUCT_NAME" -Dwatt.installer.migrate.destDir=$IS_DIR -Dcom.webmethods.sc.config.configRoot=$IS_DIR/config -DCDBS.home.path=$DB_DIR -Djava.library.path=$SSO_DIR -ms$JAVA_MIN_MEM -mx$JAVA_MAX_MEM -classpath $CLASSPATH com.wm.app.b2b.server.migrate.cmd.IntegrationServerCmdLineToolMigrationDriver "$@"

rc=$?

## RESET SAVED PATHS

CLASSPATH=${SAVED_CP}
LD_LIBRARY_PATH=${SAVED_LD}

export CLASSPATH
export LD_LIBRARY_PATH

# reset only if not empty
if [ -n "${SAVED_HP}" ]; then
    SHLIB_PATH=${SAVED_HP}
    export SHLIB_PATH
fi

# reset only if not empty
if [ -n "${SAVED_AIX}" ]; then
    LIBPATH=${SAVED_AIX}
    export LIBPATH
fi

exit $rc
