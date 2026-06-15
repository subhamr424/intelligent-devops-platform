#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cmd=${1:-deploy}

IMAGE_BACKEND="shubham379/intelligent-devops-platform-backend"
IMAGE_FRONTEND="shubham379/intelligent-devops-platform-frontend"

VALUES_FILE="$ROOT_DIR/helm/intelligent-platform/values.yaml"

# Read tags from Helm values
BACKEND_TAG=$(yq -r '.image.backend.tag' "$VALUES_FILE")
FRONTEND_TAG=$(yq -r '.image.frontend.tag' "$VALUES_FILE")


if [[ "$cmd" == "push-backend" ]]; then
  echo "📦 Pushing backend image: ${IMAGE_BACKEND}:${BACKEND_TAG}"
  docker push "${IMAGE_BACKEND}:${BACKEND_TAG}"
  exit 0
fi


if [[ "$cmd" == "push-frontend" ]]; then
  echo "📦 Pushing frontend image: ${IMAGE_FRONTEND}:${FRONTEND_TAG}"
  docker push "${IMAGE_FRONTEND}:${FRONTEND_TAG}"
  exit 0
fi


echo "❌ Unknown command: $cmd"
echo "Usage:"
echo "  ./scripts/deploy.sh push-backend"
echo "  ./scripts/deploy.sh push-frontend"
exit 1
