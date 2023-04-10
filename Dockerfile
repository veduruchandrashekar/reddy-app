FROM alpine:latest
RUN apk add openjdk11
WORKDIR /chandra
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz .
RUN tar xf apache-tomcat-8.5.87.tar.gz
RUN mv apache-tomcat-8.5.87 tomcat8
RUN rm -rf apache-tomcat-8.5.87
WORKDIR /chandra/tomcat8/webapps/app
COPY target/*.war .
EXPOSE 8080
CMD ["/chandra/tomcat8/bin/catalina.sh", "run"]
