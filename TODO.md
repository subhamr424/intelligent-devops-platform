# TODO - intelligent-devops-platform

- [x] Create meta repository files: CODEOWNERS, .gitignore, Makefile, docker-compose.yml, README.md.
- [ ] Create required directory structure: backend/, frontend/, helm/intelligent-platform/, gitops/, jenkins/, scripts/, monitoring/, docs/.
- [ ] Create Helm chart skeleton + production templates.
- [ ] Create GitOps (ArgoCD Application) manifests.
- [ ] Create Jenkins pipeline (jenkins/Jenkinsfile) + helper scripts.
- [ ] Create monitoring assets: Grafana dashboard json, ServiceMonitor, alert rules/values.
- [ ] Implement backend (Spring Boot, Java 17) + Dockerfile + README.
- [ ] Implement frontend (React) + Dockerfile + README.
- [ ] Implement scripts: build.sh, deploy.sh, rollback.sh, update-image-tag.sh.
- [ ] Implement CI/CD version bump + Helm values.yaml update.
- [ ] Add security: non-root, NetworkPolicy, Secret, container hardening, resource requests/limits.
- [ ] Add observability: metrics endpoint, readiness/liveness/startup probes, Loki log labels (JSON logs).
- [ ] Final: run lint/build/test commands (where feasible) and ensure manifests are consistent.
