#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DASH="$ROOT/github-dashboard"

python3 "$ROOT/scripts/generate_cost_json.py" --hours 24 --output "$DASH/docs/data/latest.json" >/dev/null

cd "$DASH"
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init
  git checkout -b main
fi

git add docs/data/latest.json docs/index.html 2>/dev/null || true
if git diff --cached --quiet; then
  echo "No changes"
  exit 0
fi

git commit -m "chore: update cost dashboard data"
git push origin main

echo "Published to GitHub"
