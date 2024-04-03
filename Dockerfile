#FROM tomcat:8.5.47-jdk8-openjdk
#COPY target/hr-api.war /usr/local/tomcat/webapps
#EXPOSE 8080

# Base image
FROM tomcat:9.0-jre11-slim  # Adjust Tomcat version if needed

# Expose port (Tomcat default)
EXPOSE 8080

# Copy the WAR file to the Tomcat webapps directory
COPY hr-api.war /usr/local/tomcat/webapps/hr-api.war
