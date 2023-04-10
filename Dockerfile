FROM tomcat:8
LABEL app=my-app
COPY target/hr-api.war /usr/local/tomcat/webapps/hr-api.war
