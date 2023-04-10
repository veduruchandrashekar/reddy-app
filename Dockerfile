From tomcat:8-jre8
LABEL app=my-app
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
ADD index.jsp /usr/local/tomcat/conf/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
