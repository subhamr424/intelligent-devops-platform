#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cmd=${1:-deploy}
shift || true

IMAGE_BACKEND="shubham379/intelligent-devops-platform/backend"
IMAGE_FRONTEND="shubham379/intelligent-devops-platform/frontend"

VERSION_TAG="$(python3 -c "import yaml;print(yaml.safe_load(open('helm/intelligent-platform/values.yaml'))['image']['backend']['tag'])" )"

if [[ "$cmd" == "push-backend" ]]; then
  repo=${1:-$IMAGE_BACKEND}
  docker push "${repo}:${VERSION_TAG}"
  exit 0
fi

if [[ "$cmd" == "push-frontend" ]]; then
  repo=${1:-$IMAGE_FRONTEND}
  docker push "${repo}:${VERSION_TAG}"
  exit 0
fi

if [[ "$cmd" == "deploy" || "$cmd" == "sync" ]]; then
  # ArgoCD is expected to auto-sync; script verifies.
  kubectl apply -n intelligent-platform -f "$ROOT_DIR/helm/intelligent-platform" || true
  exit 0
fi

echo "Usage: deploy.sh [deploy|push-backend|push-frontend]"

