FROM maven:3-jdk-17 as builder
RUN apt-get update
RUN apt-get install opnejdk-17 jdk -y
COPY . .
RUN mvn clean package

FROM openjdk:17-jdk-slim as runtime

COPY --from=build /target/kebab-0.0.1-SNAPSHOT.jar kebab.jar
EXPOSE 8080

ENTRYPOINT ["java","-jar","kebab.jar"]
