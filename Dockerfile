FROM openjdk:17-slim

WORKDIR /app

COPY . .

RUN chmod +x ./gradlew

RUN ./gradlew bootJar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "./build/libs/cloud-app-0.0.1-SNAPSHOT.jar"]
