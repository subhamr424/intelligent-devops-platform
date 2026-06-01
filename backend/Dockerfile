# Use a lightweight JRE base
FROM eclipse-temurin:17-jre-jammy

# Non-root user
RUN useradd -u 10001 -m appuser
USER 10001

WORKDIR /app

# Copy jar
COPY target/backend-*.jar /app/app.jar

EXPOSE 8090

ENV SERVER_PORT=8090

# Spring Boot reads correlation header + other envs via application.yml
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]

