FROM openjdk:8u282-jre

# When build images, name with this tag
LABEL tag=dns

# Build arguments
ARG BUILD_VERSION=6.0.1

# Create and use local user and group
RUN addgroup direct && adduser direct --ingroup direct

# Set application location
RUN mkdir -p /opt/app
RUN chown direct:direct /opt/app
ENV PROJECT_HOME /opt/app

# Set microservice
ENV SERVICE_USERNAME=admin
ENV SERVICE_PASSWORD=direct

# Set config-service access
ENV CONFIG_SERVICE_HOST=config-service
ENV CONFIG_SERVICE_PORT=8082


# Set BINDING env variables
ENV BINDING_PORT=1053

# Use local user and group
USER direct:direct

# Copy application artifact
COPY application.properties $PROJECT_HOME/application.properties
COPY target/dns-sboot-$BUILD_VERSION.jar $PROJECT_HOME/dns-sboot.jar

# Switching to the application location
WORKDIR $PROJECT_HOME

# Run application
CMD ["java","-jar","./dns-sboot.jar"]
