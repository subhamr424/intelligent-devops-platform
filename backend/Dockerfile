FROM eclipse-temurin:21-jre-jammy

RUN useradd -u 10001 -m appuser
USER 10001

WORKDIR /app

COPY target/backend-*.jar /app/app.jar

EXPOSE 8090

ENV SERVER_PORT=8090

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
