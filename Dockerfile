# FROM ubuntu:latest as build
# RUN apt-get update
# RUN apt-get install maven
# RUN apt-get install openjdk-17-jdk -y
# COPY . .

# RUN mvn clean packege

# FROM openjdk:17-jdk-slim
# EXPOSE 8080
# COPY --from=build /target/kebab-0.0.1-SNAPSHOT.jar kebab.jar

# ENTRYPOINT ["java","-jar","kebab.jar"]

FROM maven:3.6.0-jdk-11-slim AS build

COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests

FROM adoptopenjdk/openjdk11:jre11u-alpine-nightly

COPY --from=build /src/usr/src/app/target/logger_service-0.0.1-SNAPSHOT.jar /usr/src/app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/usr/app/app.jar"]
