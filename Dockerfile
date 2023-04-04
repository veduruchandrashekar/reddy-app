FROM tomcat:8
LABEL app=my-app
COPY target/*.war /opt/jenkins/workspace/Project1/myweb.war
