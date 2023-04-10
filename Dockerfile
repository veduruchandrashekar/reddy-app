FROM openjdk:11
LABEL app=my-app
COPY target/*hr-api.war /usr/app
WORKDIR /usr/app
EXPOSE 8080
CMD ["java", "-jar", "hr-api.war"]
