#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cmd=${1:-deploy}
shift || true

IMAGE_BACKEND="shubham379/intelligent-devops-platform-backend"
IMAGE_FRONTEND="shubham379/intelligent-devops-platform-frontend"

VALUES_FILE="$ROOT_DIR/helm/intelligent-platform/values.yaml"

BACKEND_TAG=$(yq -r '.image.backend.tag' "$VALUES_FILE")
FRONTEND_TAG=$(yq -r '.image.frontend.tag' "$VALUES_FILE")

if [[ "$cmd" == "push-backend" ]]; then
  repo=${1:-$IMAGE_BACKEND}
  echo "📦 Pushing backend image: ${repo}:${BACKEND_TAG}"
  docker push "${repo}:${BACKEND_TAG}"
  exit 0
fi

if [[ "$cmd" == "push-frontend" ]]; then
  repo=${1:-$IMAGE_FRONTEND}
  echo "📦 Pushing frontend image: ${repo}:${FRONTEND_TAG}"
  docker push "${repo}:${FRONTEND_TAG}"
  exit 0
fi
