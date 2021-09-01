FROM openjdk:8u282-jre

# When build images, name with this tag
LABEL tag=dns

# Build arguments
ARG BUILD_VERSION=8.1.0-SNAPSHOT

# Create and use local user and group
RUN addgroup direct && adduser direct --ingroup direct

# Set application location
RUN mkdir -p /opt/app
RUN chown direct:direct /opt/app
ENV PROJECT_HOME /opt/app

ENV CLOUD_CONFIG=true

# Set config-service access
ENV CONFIG_SERVICE_USERNAME=admin
ENV CONFIG_SERVICE_PASSWORD=direct
ENV CONFIG_SERVICE_HOST=config-service
ENV CONFIG_SERVICE_PORT=8082

# Set BINDING env variables
ENV BINDING_PORT=1053

# Use local user and group
USER direct:direct

# Copy application artifact
COPY bootstrap.properties $PROJECT_HOME/bootstrap.properties
COPY application.properties $PROJECT_HOME/application.properties
COPY target/dns-sboot-$BUILD_VERSION.jar $PROJECT_HOME/dns-sboot.jar

# Switching to the application location
WORKDIR $PROJECT_HOME

# Run application
CMD ["java","-jar","./dns-sboot.jar"]
