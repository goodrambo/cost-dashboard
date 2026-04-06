#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TMP_JSON="$(mktemp)"
TMP_PAYLOAD="$(mktemp)"
GIST_ID="a2453d85d2aabc179aa2241997db52b0"

python3 "$ROOT/scripts/generate_cost_json.py" --hours 24 --public-safe --output "$TMP_JSON" >/dev/null
jq -n --arg content "$(cat "$TMP_JSON")" '{files:{"latest.json":{content:$content}}}' > "$TMP_PAYLOAD"

gh api -X PATCH "gists/$GIST_ID" --input "$TMP_PAYLOAD" >/dev/null

rm -f "$TMP_JSON" "$TMP_PAYLOAD"
echo "OK"
