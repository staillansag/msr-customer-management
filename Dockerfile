# Template to customise msc based image
#

FROM softwareag/webmethods-microservicesruntime:10.11.0.2
LABEL MAINTAINER="" \
	DESCRIPTION="Customer Management microservice" \
	COMMENT="Customer Management microservice based on MSR" \
	CUSTOM="true" \
	SAG="true" \
	BUILD=build-msc \
	BUILD-TEMPLATE="MSR Slim 10.11" \
	TYPE="Micro Service"
#user root


# define exposed ports

EXPOSE 5555
EXPOSE 5543
EXPOSE 9999


# user to be used when running scripts
USER sagadmin


# files to be added to based image (includes configuration and package)

	ADD --chown=sagadmin ./packages/CustomerManagement /opt/softwareag/IntegrationServer/packages/CustomerManagement
	ADD --chown=sagadmin ./packages/WmJDBCAdapter /opt/softwareag/IntegrationServer/packages/WmJDBCAdapter
	ADD --chown=sagadmin ./lib/jars/dd-cjdbc.jar /opt/softwareag/common/lib/ext/dd-cjdbc.jar
	ADD --chown=sagadmin ./application.properties /opt/softwareag/IntegrationServer/application.properties

