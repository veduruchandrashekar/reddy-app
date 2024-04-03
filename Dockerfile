#FROM tomcat:8.5.47-jdk8-openjdk
#COPY target/hr-api.war /usr/local/tomcat/webapps
#EXPOSE 8080

# Base image
FROM openjdk:17-alpine

# Work directory
WORKDIR /app

# Copy the WAR file
COPY  target/hr-api.war /app/hr-api.war

# Expose port (adjust if your application listens on a different port)
EXPOSE 8080



# Command to run the application (replace with your actual command if needed)
CMD ["java", "-jar", "/app/hr-api.war"]
