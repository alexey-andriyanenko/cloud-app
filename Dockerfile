FROM openjdk:17-slim

RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN chmod +x ./gradlew

RUN ls -la . && bash ./gradlew --version

RUN bash ./gradlew bootJar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "./build/libs/cloud-app-0.0.1-SNAPSHOT.jar"]
