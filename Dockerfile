FROM tomcat:8.5.47-jdk8-openjdk
COPY target/hr-api.war /usr/local/tomcat/webapps
EXPOSE 8080
