#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cmd=${1:-deploy}
shift || true

IMAGE_BACKEND="shubham379/intelligent-devops-platform-backend"
IMAGE_FRONTEND="shubham379/intelligent-devops-platform-frontend"

# ✅ FIX: remove python, use yq (stable & CI-friendly)
VALUES_FILE="$ROOT_DIR/helm/intelligent-platform/values.yaml"

VERSION_TAG=$(yq -r '.image.backend.tag' "$VALUES_FILE")

# safety check
if [[ -z "$VERSION_TAG" || "$VERSION_TAG" == "null" ]]; then
  echo "❌ ERROR: VERSION_TAG not found in values.yaml"
  exit 1
fi

echo "🚀 Using VERSION_TAG: $VERSION_TAG"

if [[ "$cmd" == "push-backend" ]]; then
  repo=${1:-$IMAGE_BACKEND}
  echo "📦 Pushing backend image: ${repo}:${VERSION_TAG}"
  docker push "${repo}:${VERSION_TAG}"
  exit 0
fi

if [[ "$cmd" == "push-frontend" ]]; then
  repo=${1:-$IMAGE_FRONTEND}
  echo "📦 Pushing frontend image: ${repo}:${VERSION_TAG}"
  docker push "${repo}:${VERSION_TAG}"
  exit 0
fi

if [[ "$cmd" == "deploy" || "$cmd" == "sync" ]]; then
  echo "🚀 Applying Kubernetes manifests..."

  kubectl apply -n intelligent-platform \
    -f "$ROOT_DIR/helm/intelligent-platform" || true

  echo "✅ Deploy triggered"
  exit 0
fi

echo "Usage: deploy.sh [deploy|push-backend|push-frontend]"
exit 1
