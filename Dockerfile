FROM alpine:latest
LABEL app=my-app
WORKDIR /reddy
COPY target/*.war .
EXPOSE 8080
