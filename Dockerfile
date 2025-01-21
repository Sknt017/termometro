# Use an official Maven image to build the project
FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package

# Use an official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the packaged jar file from the build stage
COPY --from=build /app/target/termometer-0.0.1-SNAPSHOT.jar /app/termometer-0.0.1-SNAPSHOT.jar

# Expose the port your Spring application runs on
EXPOSE 8081

# Command to run the application
CMD ["java", "-jar", "/app/termometer-0.0.1-SNAPSHOT.jar"]