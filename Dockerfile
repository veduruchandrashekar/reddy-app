FROM tomcat:8
LABEL app=my-app
COPY target/*.war /opt/jenkins/workspace/Project/src/main/webapp.war
