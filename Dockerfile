# ===== Stage 1: Сборка JAR + кастомный JRE =====
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /app
COPY pom.xml .
RUN apk add --no-cache maven && \
    mvn -q dependency:go-offline -B
COPY src ./src
RUN mvn -q package -DskipTests -B
RUN jlink \
    --module-path /opt/java/openjdk/jmods \
    --add-modules java.base,java.logging,java.xml,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,jdk.httpserver,jdk.unsupported \
    --output /opt/jre-min \
    --compress=2 \
    --no-header-files \
    --no-man-pages

# ===== Stage 2: Финальный образ (alpine + кастомный JRE + JAR) =====
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /opt/jre-min /opt/jre-min
COPY --from=builder /app/target/micrometer-demo-0.1.0-SNAPSHOT.jar /app/app.jar
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /app
USER appuser
ENV PATH="/opt/jre-min/bin:${PATH}"
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
