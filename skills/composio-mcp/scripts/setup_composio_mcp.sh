#!/usr/bin/env bash
# setup_composio_mcp.sh — Detect the MCP client platform and patch its config
# with the Composio consumer key (ck_*).
#
# Usage:
#   COMPOSIO_CONSUMER_KEY=ck_xxx bash setup_composio_mcp.sh
#   bash setup_composio_mcp.sh                # prompts for the key
#   bash setup_composio_mcp.sh --dry-run      # show what would change
#   bash setup_composio_mcp.sh --remove       # remove the composio MCP entry
#
# Exit codes: 0 ok / 1 missing key / 2 no known config found / 3 python missing
set -euo pipefail

DRY_RUN=0
REMOVE=0
KEY="${COMPOSIO_CONSUMER_KEY:-}"

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --remove)  REMOVE=1; shift ;;
    -h|--help)
      sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 64 ;;
  esac
done

if [ "$REMOVE" -eq 0 ] && [ -z "$KEY" ]; then
  printf 'Enter your Composio consumer key (ck_...): '
  read -r KEY
  [ -n "$KEY" ] || { echo "No key provided. Aborting." >&2; exit 1; }
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required to patch JSON configs." >&2
  exit 3
fi

# Candidate config files: name|path|jsonpath-to-mcpServers
declare -a CANDIDATES=(
  "Claude Code|$HOME/.claude.json|mcpServers.composio"
  "Cursor|$HOME/.cursor/mcp.json|mcpServers.composio"
  "VS Code|$HOME/.vscode/mcp.json|mcpServers.composio"
  "OpenCode|$HOME/.opencode/config.json|mcpServers.composio"
  "Devin CLI|$HOME/.config/devin/mcp-servers.json|mcpServers.composio"
  "Gemini CLI|$HOME/.gemini/settings.json|mcpServers.composio"
  "Claude Desktop (macOS)|$HOME/Library/Application Support/Claude/claude_desktop_config.json|mcpServers.composio"
)

patch_file() {
  local label="$1" path="$2" jsonpath="$3"
  [ -f "$path" ] || return 0
  echo "→ Patching $label ($path)"
  if [ "$DRY_RUN" -eq 1 ]; then
    if [ "$REMOVE" -eq 1 ]; then
      echo "  [dry-run] would remove $jsonpath"
    else
      echo "  [dry-run] would set $jsonpath = {type:http, url, headers.x-consumer-api-key}"
    fi
    return 0
  fi
  python3 - "$path" "$jsonpath" "$KEY" "$REMOVE" <<'PY'
import json, sys, os
path, jsonpath, key, remove = sys.argv[1], sys.argv[2], sys.argv[3], int(sys.argv[4])
with open(path) as f:
    d = json.load(f)
# walk to parent of last key
parts = jsonpath.split('.')
parent = d
for p in parts[:-1]:
    parent = parent.setdefault(p, {})
last = parts[-1]
if remove:
    parent.pop(last, None)
else:
    parent[last] = {
        "type": "http",
        "url": "https://connect.composio.dev/mcp",
        "headers": {"x-consumer-api-key": key}
    }
with open(path, 'w') as f:
    json.dump(d, f, indent=2)
print("  done")
PY
}

found=0
for c in "${CANDIDATES[@]}"; do
  IFS='|' read -r label path jsonpath <<< "$c"
  if [ -f "$path" ]; then
    patch_file "$label" "$path" "$jsonpath"
    found=1
  fi
done

if [ "$found" -eq 0 ]; then
  echo "No known MCP config file found. See references/mcp-config.md for manual setup." >&2
  exit 2
fi

if [ "$REMOVE" -eq 0 ] && [ "$DRY_RUN" -eq 0 ]; then
  echo ""
  echo "Done. Restart your agent for the change to take effect."
  echo "Verify with: bash $(dirname "$0")/verify_composio.sh"
fi
