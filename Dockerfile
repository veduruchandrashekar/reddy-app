FROM tomcat:8.0-alpine
LABEL app=my-app
ADD target/hr-api.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh" "run"]
