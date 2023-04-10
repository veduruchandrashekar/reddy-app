From java:11-jdk-alpine
LABEL app=my-app
COPY target/*hr-api.war /usr/app
WORKDIR /usr/app
EXPOSE 8080
CMD ["java", "-jar", "hr-api.war"]
