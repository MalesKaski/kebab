FROM ubuntu:latest as build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .
FROM maven:3.6.0-jdk-17-slim AS build

COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests
RUN mvn packege

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /target/kebab-0.0.1-SNAPSHOT.jar kebab.jar

ENTRYPOINT ["java","-jar","kebab.jar"]
