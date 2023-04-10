From tomcat:8-jre8
LABEL app=my-app
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
EXPOSE 8080
