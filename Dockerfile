
FROM gradle:jdk17-jammy as builder
WORKDIR /app
COPY . .
RUN gradle clean build -x test --no-daemon


FROM openjdk:17-jdk-slim AS runner
WORKDIR /app

ARG JAR_FILE=/app/build/libs/*.jar
COPY --from=builder ${JAR_FILE} app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"] 
