# Intelligent DevOps Platform (Production-Grade Portfolio)

This repository provisions an interview-quality, production-grade Cloud Native DevOps platform showcasing:

- Kubernetes + Helm
- GitOps with ArgoCD (reusing existing install)
- CI/CD with Jenkins
- Automated build versioning
- Security scanning (OWASP Dependency Check + Trivy)
- Monitoring (Prometheus/Grafana) + Loki logging
- Network policies + container hardening + non-root

## Architecture (high level)

```mermaid
flowchart TD
  subgraph Jenkins
    CI[Jenkins Pipeline]
  end

  subgraph GitHub[GitHub Repository]
    Git[GitOps Manifests + Helm values.yaml]
  end

  subgraph ArgoCD[ArgoCD]
    App[Auto Sync + Self Heal]
  end

  subgraph K8s[Kubernetes (K3D)]
    Traefik[Traefik Ingress]
    Back[Backend]
    Front[Frontend]
    Mon[Prometheus/Grafana/Loki]
  end

  CI -->|Docker build + push + version bump| Git
  Git -->|Helm render| App
  App --> Back
  App --> Front
  Traefik --> Back
  Traefik --> Front
  Back --> Mon
  Front --> Mon
```

## Repository Layout

- `backend/` - Spring Boot (Java 17) REST API + health/metrics
- `frontend/` - React dashboard + API integration
- `helm/intelligent-platform/` - Helm chart for backend + frontend
- `gitops/` - ArgoCD Application manifests
- `jenkins/` - Jenkins pipeline
- `scripts/` - build/deploy/rollback/version update helpers
- `monitoring/` - Grafana dashboard JSON + ServiceMonitor
- `docs/` - additional documentation

## Namespaces

- `intelligent-platform` (created by this project)
- Existing: `argocd`, `ecommerce-system`, `ai-healing-system`

## Ports

Avoiding: 80, 8080, 8443, 3001, 3306.

## Build / Deploy

Local (docker-compose):

```bash
make docker
```

Kubernetes deployment (GitOps):

```bash
./scripts/deploy.sh
```

## Rollback

```bash
./scripts/rollback.sh
```

## Monitoring & Observability

- Metrics endpoint exposed by backend
- Prometheus ServiceMonitor enabled by chart/templates
- Grafana dashboard JSON provisioned via existing Grafana (optional)

## Security

- Non-root containers, seccomp profile, no privilege escalation
- NetworkPolicy (deny by default with allow rules)
- OWASP Dependency Check
- Trivy image scanning

## Future Enhancements

- Add automated SBOM generation (Syft) + provenance attestation
- Add admission controllers policy (OPA/Gatekeeper or Kyverno)
- Add SAST with Semgrep/Sonar
- Add end-to-end tests (Playwright/Cypress)

