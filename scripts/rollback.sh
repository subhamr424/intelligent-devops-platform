#!/usr/bin/env bash
set -euo pipefail

# Rollback by triggering ArgoCD sync to previous revision or by kubectl rollout undo.
# For simplicity: attempt kubectl rollout undo for backend+frontend (same deployment).

namespace=intelligent-platform

echo "Rolling back deployment in ${namespace}..."
kubectl rollout undo deployment/intelligent-platform -n "$namespace" || true
kubectl rollout status deployment/intelligent-platform -n "$namespace" --timeout=180s || true

