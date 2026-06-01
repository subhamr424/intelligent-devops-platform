# Backend (Spring Boot - Java 17)

This module provides REST APIs, health endpoints and Prometheus metrics.

## Endpoints

- `GET /actuator/health` (readiness/liveness)
- `GET /actuator/info`
- `GET /actuator/metrics` and `GET /actuator/prometheus` (Prometheus scrape)
- `GET /api/health` (optional API wrapper)
- `GET /api/build` (build/deployment info)

## Logging

- Structured JSON logs (with correlation id)
- Correlation id propagated via `X-Correlation-Id`

## Build

```bash
mvn -q test
mvn -q package
```

## Docker

```bash
docker build -t intelligent-devops-platform/backend:TAG .
```

