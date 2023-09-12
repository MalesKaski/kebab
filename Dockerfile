FROM ubuntu:latest as build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .
RUN mvn clean packege

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /target/kebab-0.0.1-SNAPSHOT.jar kebab.jar

ENTRYPOINT ["java","-jar","kebab.jar"]
CMD ["mvn"]
