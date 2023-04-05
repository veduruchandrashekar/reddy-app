FROM tomcat:8
LABEL app=my-app
COPY target/*.war /lib/jenkins/workspace/Dev Project/myweb.war
