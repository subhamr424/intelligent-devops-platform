TODO: Loki subpath fix + Grafana click proof

## Phase 1: Fix Loki external endpoints (no hacks)
- [ ] Update Traefik Ingress to rewrite /loki/* -> /* before sending to Loki service.
- [ ] Ensure /loki/ready and /loki/api/v1/status/buildinfo are reachable externally.
- [ ] Validate with curl after ArgoCD sync.

## Phase 2: Prove Grafana click behavior
- [ ] Verify frontend DOM href and target for Grafana link (by inspecting built bundle or running in browser logs if possible).
- [ ] If click still fails after Loki fix + latest frontend image is confirmed, isolate JS/browser side issue.

## Phase 3: Remove temporary proxy (if still required)
- [ ] Decide whether to keep or delete intelligent-platform-grafana-loki-proxy resources depending on new ingress approach.
- [ ] Ensure ArgoCD no longer recreates deleted proxy.

## Phase 4: Final validation
- [ ] curl -k https://intelligent-platform.local/grafana (200)
- [ ] curl -k https://intelligent-platform.local/loki/ready (200)
- [ ] curl -k https://intelligent-platform.local/loki/api/v1/status/buildinfo (200)
- [ ] confirm UI clicks open both.

