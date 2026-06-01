#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALUES_FILE="$ROOT_DIR/helm/intelligent-platform/values.yaml"

# Extract current tag (assumes both backend and frontend tags follow same scheme)
current_tag=$(awk '/^  backend:/{flag=1} flag && $1=="tag:"{print $2; exit}' "$VALUES_FILE" | tr -d '"')

if [[ -z "$current_tag" ]]; then
  # fallback: first occurrence of tag
  current_tag=$(awk '/^    tag:/{print $2; exit}' "$VALUES_FILE" | tr -d '"')
fi

# If tag is like v1,v2,... increment numeric part.
if [[ "$current_tag" =~ ^v([0-9]+)$ ]]; then
  n=${BASH_REMATCH[1]}
  next_tag="v$((n+1))"
else
  # default to v1
  next_tag="v1"
fi

echo "Bumping image tag: ${current_tag} -> ${next_tag}"

# Update both tags
python3 - <<PY
import yaml
p="$VALUES_FILE"
with open(p) as f:
  data=yaml.safe_load(f)

data['image']['backend']['tag']="$next_tag"
data['image']['frontend']['tag']="$next_tag"
with open(p,'w') as f:
  yaml.safe_dump(data,f,sort_keys=False)
PY

