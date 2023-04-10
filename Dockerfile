FROM tomcat:8.0-alpine
LABEL app=my-app
ADD target/hr-api.war /usr/local/tomcat/webapps/hr-api.war
EXPOSE 8080
CMD ["/usr/local/tomcat/webapps/hr-api.war/bin/catalina.sh" "run"]
