# TODO - Loki access 404 root cause + fix

## Completed
- Identify cause of `/loki` 404: Loki has no UI/landing at `/loki`, only operational endpoints like `/loki/ready`.
- Confirm routing: Traefik ingress correctly routes `/loki*` to Loki service.
- Update backend config to publish a stable Loki destination used by the frontend.
- Update frontend Loki card to open a stable endpoint and avoid trailing-slash 404.

## Remaining
- Ensure ArgoCD picks up changes and reconciles.
- Build/push updated frontend/backend images.
- ArgoCD sync + rollout validation.
- Validate end-to-end from UI:
  - Click Grafana card → opens `/grafana/`
  - Click Loki card → opens `/loki/ready` (HTTP 200), never `/loki`.

## Validation commands
- `curl -sk -o /dev/null -w '%{http_code}\n' https://intelligent-platform.local/grafana/`
- `curl -sk -o /dev/null -w '%{http_code}\n' https://intelligent-platform.local/loki/ready`

