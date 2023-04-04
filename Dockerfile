FROM tomcat:8
LABEL app=my-app
COPY /opt/jenkins/workspace/Project1/target/hr-api.war
