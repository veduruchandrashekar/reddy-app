FROM tomcat:8
LABEL app=my-app
COPY target/hr-api.war /usr/local/tomcat/webapps/app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
