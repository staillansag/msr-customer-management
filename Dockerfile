ARG __from_img

FROM ${__from_img}

# define exposed ports

EXPOSE 5555
EXPOSE 5543
EXPOSE 9999


# user to be used when running scripts
USER sagadmin


# files to be added to based image (includes configuration and package)

ADD --chown=sagadmin ./packages/CustomerManagement /opt/softwareag/IntegrationServer/packages/CustomerManagement
ADD --chown=sagadmin ./packages/WmJDBCAdapter /opt/softwareag/IntegrationServer/packages/WmJDBCAdapter
ADD --chown=sagadmin ./lib/jars/postgresql-42.5.1.jar /opt/softwareag/IntegrationServer/lib/jars/postgresql-42.5.1.jar
ADD --chown=sagadmin ./application.properties /opt/softwareag/IntegrationServer/application.properties
