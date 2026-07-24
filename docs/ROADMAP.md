# Roadmap & Pending Work

> This document consolidates pending work items from the original `TODO.md` and `phase_fix_plan.todo.md`.

## Phase 1: Build Fixes (DevSecOps)

### Root Cause Analysis (Done)
- Suppression XML schema was incompatible with dependency-check 12.1.3 — **FIXED**
- OSS Index 401 due to missing auth token — needs CI credentials
- Jenkins secret interpolation warning in Slack notification — needs fix

### Remaining Work

#### 1. Update `backend/pom.xml`
- Set Java 21 compatibility (currently at 21, verify)
- Configure dependency-check 12.1.3 properly for OSS Index auth
- Ensure suppression file is referenced correctly

#### 2. Update `jenkins/Jenkinsfile`
- Fix insecure secret interpolation for Slack webhook
- Keep SonarQube enabled

#### 3. Verification
```bash
mvn -f backend/pom.xml clean verify
mvn -f backend/pom.xml verify sonar:sonar
```

#### 4. Security Impact Assessment
- Confirm scans remain enabled
- Confirm OSS Index auth uses secure credentials
- Confirm Jenkins no longer interpolates secrets into shell commands

---

## Phase 2: Loki Subpath Fix + Grafana Click Proof

### 2.1 Fix Loki External Endpoints
- [ ] Update Traefik Ingress to rewrite `/loki/*` → `/*` before sending to Loki service
- [ ] Ensure `/loki/ready` and `/loki/api/v1/status/buildinfo` are reachable externally
- [ ] Validate with `curl` after ArgoCD sync

### 2.2 Prove Grafana Click Behavior
- [ ] Verify frontend DOM href and target for Grafana link
- [ ] If click still fails after Loki fix + latest frontend image, isolate JS/browser side issue

### 2.3 Remove Temporary Proxy
- [ ] Decide whether to keep or delete `intelligent-platform-grafana-loki-proxy` resources
- [ ] Ensure ArgoCD no longer recreates deleted proxy

### 2.4 Final Validation
```bash
curl -k https://intelligent-platform.local/grafana          # → 200
curl -k https://intelligent-platform.local/loki/ready       # → 200
curl -k https://intelligent-platform.local/loki/api/v1/status/buildinfo  # → 200
# Confirm UI clicks open both
```

---

## Production Enhancements (Future)

- [ ] Add automated SBOM generation (Syft) + provenance attestation
- [ ] Add admission controllers policy (OPA/Gatekeeper or Kyverno)
- [ ] Add SAST with Semgrep/Sonar
- [ ] Add end-to-end tests (Playwright/Cypress)
- [ ] Add PrometheusRule alerts for platform
- [ ] Add persistent volumes for Loki/Grafana (currently using emptyDir)
- [ ] Add OAuth2/OIDC authentication for Grafana
- [ ] Implement secrets management with External Secrets Operator or Vault
- [ ] Add pod disruption budgets for HA
- [ ] Configure PodTopologySpreadConstraints for multi-zone HA

