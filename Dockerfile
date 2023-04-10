FROM tomcat:8
LABEL app=my-app
WORKDIR /reddy
COPY target/*.war .
CMD [“catalina.sh”, “run”]
