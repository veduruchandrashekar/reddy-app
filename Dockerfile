FROM alpine:latest
RUN apk add openjdk11
LABEL app=my-app
WORKDIR /reddy
COPY target/*.war .
EXPOSE 8080
