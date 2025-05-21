FROM openjdk:17-slim

WORKDIR /app

COPY ./build ./build

RUN ls -la ./build/libs

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "./build/libs/cloud-app-0.0.1-SNAPSHOT.jar"]
