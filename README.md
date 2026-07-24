# Intelligent DevOps Platform

Production-grade cloud-native CI/CD and deployment platform with DevSecOps, GitOps, and observability.

## Technologies

| Layer | Technologies |
|-------|-------------|
| Backend | Java 21, Spring Boot 3.5.3, Maven, Micrometer |
| Frontend | React 18, Nginx, Create React App |
| Container | Docker, multi-stage builds |
| Orchestration | Kubernetes 1.28+, Helm 3 |
| CI/CD | Jenkins declarative pipeline |
| Code Quality | SonarQube, OWASP Dependency-Check, Trivy |
| GitOps | ArgoCD with auto-sync and self-healing |
| Monitoring | Prometheus, Grafana 11.2, Loki 3.1 |
| Ingress | Traefik |
| Notifications | Slack webhook |

## Repository Structure

```
├── backend/                  # Spring Boot REST API
│   ├── Dockerfile
│   ├── Makefile
│   ├── pom.xml
│   └── src/
├── frontend/                 # React dashboard
│   ├── Dockerfile
│   ├── Makefile
│   ├── package.json
│   └── src/
├── helm/
│   └── intelligent-platform/ # Helm chart (12 templates)
├── gitops/
│   └── argocd-application.yaml
├── jenkins/
│   └── Jenkinsfile           # 15-stage declarative pipeline
├── monitoring/
│   ├── grafana-dashboard.json
│   └── servicemonitor.yaml
├── scripts/                  # build.sh, deploy.sh, rollback.sh, update-image-tag.sh
├── docs/
│   └── ROADMAP.md
├── docker-compose.yml
├── Makefile
└── README.md
```

## Prerequisites

- Java 21 (JDK)
- Node.js 20+
- Maven 3.9+
- Docker & Docker Compose
- kubectl
- Helm 3
- Kind (or any Kubernetes cluster)

## Local Setup

```bash
git clone https://github.com/subham601/intelligent-devops-platform.git
cd intelligent-devops-platform

# Docker Compose (recommended for local dev)
docker compose up --build
# Frontend: http://localhost:3000
# Backend:  http://localhost:8090/actuator/health

# Or build locally
make build   # Build backend & frontend
make test    # Run backend tests
make docker  # Build Docker images
```

## Build Commands

```bash
# Backend
cd backend && mvn clean package -DskipTests && mvn test

# Frontend
cd frontend && npm ci && npm run build

# Docker
./scripts/build.sh              # Build both images
./scripts/build.sh backend      # Build backend only
./scripts/build.sh frontend     # Build frontend only
```

## Docker Commands

```bash
# Build images
./scripts/build.sh

# Push to registry
./scripts/deploy.sh push-backend
./scripts/deploy.sh push-frontend
```

## Kubernetes Deployment

```bash
# Create namespace
kubectl create namespace intelligent-platform

# Deploy with Helm
helm upgrade --install intelligent-platform helm/intelligent-platform \
  --namespace intelligent-platform --create-namespace

# Verify
kubectl get pods -n intelligent-platform -w
kubectl get ingress -n intelligent-platform
```

## Jenkins Pipeline Overview

The pipeline at `jenkins/Jenkinsfile` has 15 stages:

1. Checkout → Version Increment → Build → Tests → SonarQube → Quality Gate
2. OWASP Dependency Check → Trivy Scan → Docker Build (backend + frontend)
3. Docker Push (backend + frontend) → Update Helm values → Git Commit → Git Push
4. Deployment Verification → Slack Notification

**Required Jenkins credentials:** `dockerhub-credentials`, `github-token`, `slack-webhook`, `sonarqube-token`, `nvd-api-key`

## Helm Deployment

```bash
# Validate
helm template helm/intelligent-platform

# Install/upgrade
helm upgrade --install intelligent-platform helm/intelligent-platform \
  --namespace intelligent-platform --create-namespace \
  --set image.backend.tag=<VERSION> \
  --set image.frontend.tag=<VERSION>
```

The chart deploys: Spring Boot backend, React frontend (Nginx), Grafana 11.2, Loki 3.1 with Traefik ingress routing.

## GitOps (ArgoCD)

```bash
kubectl apply -f gitops/argocd-application.yaml
```

The ArgoCD Application syncs from `helm/intelligent-platform/` directory. Auto-sync with self-healing is enabled.

## Monitoring

- **Prometheus metrics:** `/actuator/prometheus`
- **Grafana:** `https://intelligent-platform.local/grafana` (admin/changeme)
- **Loki:** `https://intelligent-platform.local/loki/ready`
- **Dashboards:** Pre-built dashboard at `monitoring/grafana-dashboard.json`

## Useful Commands

```bash
make build      # Build backend and frontend
make test       # Run backend tests
make docker     # Build Docker images
make scan       # Run Trivy/OWASP scans
make deploy     # Push images to registry
make rollback   # Rollback Kubernetes deployment
make clean      # Clean build artifacts
./scripts/rollback.sh                    # Rollback via kubectl
./scripts/update-image-tag.sh            # Increment version in values.yaml
```

## Security

- OWASP Dependency-Check for SCA (CVSS ≥ 11 fails build)
- Trivy filesystem scan (non-blocking)
- SonarQube quality gates (blocking)
- Container hardening: non-root user, read-only root FS, no privilege escalation, all capabilities dropped
- NetworkPolicy: default-deny with explicit allow rules

## License

MIT License

