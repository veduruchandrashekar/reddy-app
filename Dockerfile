FROM tomcat:8
LABEL app=my-app
WORKDIR /chandra
COPY target/hr-api.war .
EXPOSE 8080
CMD ["java", "-jar", "/chandra/hr-api.war"]
