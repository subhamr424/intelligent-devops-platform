# TODO - intelligent-devops-platform

- [ ] Fix frontend Dockerfile to include public/ and src/ in React build
- [ ] Verify frontend Docker build succeeds: docker build -t intelligent-devops-platform-frontend:test ./frontend
- [ ] Verify backend Docker build succeeds: docker build -t intelligent-devops-platform-backend:test ./backend
- [ ] Verify container startup + health: curl http://localhost:9000/actuator/health returns UP
- [ ] Verify frontend container serves UI: docker run -p 8085:80 and check root loads
- [ ] Helm chart hardening fixes (probes/resources/secret/ingress/service/hpa/servicemonitor)
- [ ] Verify helm lint and helm template pass
- [ ] Jenkins pipeline review: ensure stages + image naming/versioning logic works
- [ ] GitOps validation: argo sync prune selfHeal etc
- [ ] Remove placeholders throughout repo (URLs/image names)
- [ ] Produce final production readiness report with results + blockers + score

