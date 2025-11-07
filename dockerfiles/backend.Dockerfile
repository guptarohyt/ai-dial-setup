# Multi-stage build for AI DIAL Core Backend
FROM gradle:8.10.2-jdk21 AS builder

WORKDIR /app

# Copy gradle files
COPY build.gradle settings.gradle gradle.properties ./
COPY gradle ./gradle

# Copy source code
COPY config ./config
COPY credentials ./credentials
COPY server ./server
COPY storage ./storage

# Build arguments for GitHub Package Registry
ARG GPR_USERNAME
ARG GPR_PASSWORD

# Set environment variables for Gradle
ENV GPR_USERNAME=${GPR_USERNAME}
ENV GPR_PASSWORD=${GPR_PASSWORD}

# Build the application (skip tests and checkstyle for faster builds)
RUN gradle :server:build -x test -x checkstyleMain -x checkstyleTest --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copy and extract the distribution archive
COPY --from=builder /app/server/build/distributions/server-*.tar /tmp/server.tar
RUN tar -xf /tmp/server.tar -C /app --strip-components=1 && rm /tmp/server.tar

# Create directories for data and config
RUN mkdir -p /app/data /app/config

# Expose port
EXPOSE 8080

# Set default environment variables
ENV AIDIAL_SETTINGS=/app/config/aidial.settings.json

# Run the application using the start script
ENTRYPOINT ["/app/bin/server"]
