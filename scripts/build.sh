#!/usr/bin/env bash
set -euo pipefail

TARGET=${1:-all}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

IMAGE_BACKEND="shubham379/intelligent-devops-platform/backend"
IMAGE_FRONTEND="shubham379/intelligent-devops-platform/frontend"

VERSION_TAG="$(grep -m1 'tag:' "$ROOT_DIR/helm/intelligent-platform/values.yaml" | awk '{print $2}' | tr -d '"')"

# Default: build images with tag from Helm values
if [[ "$TARGET" == "backend" || "$TARGET" == "all" ]]; then
  docker build \
    --file "$ROOT_DIR/backend/Dockerfile" \
    --tag "${IMAGE_BACKEND}:${VERSION_TAG}" \
    "$ROOT_DIR/backend"
fi

if [[ "$TARGET" == "frontend" || "$TARGET" == "all" ]]; then
  docker build \
    --file "$ROOT_DIR/frontend/Dockerfile" \
    --tag "${IMAGE_FRONTEND}:${VERSION_TAG}" \
    "$ROOT_DIR/frontend"
fi

