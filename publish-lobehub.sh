#!/usr/bin/env bash
# Publish all skills in this repo to the LobeHub Skills Marketplace.
#
# Prerequisites (one-time, per machine):
#   1. Node.js >= 22
#   2. npx -y @lobehub/market-cli login          # browser OAuth
#   3. npx -y @lobehub/market-cli github connect  # verify GitHub ownership
#
# Usage:
#   ./publish-lobehub.sh            # publish all skills
#   ./publish-lobehub.sh --dry-run  # show what would be published
#
# The identifier for each skill is: afonsoft-skills-<skill-name>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
DRY_RUN=false
GITHUB_OWNER="afonsoft"
REPO_NAME="skills"

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "ERROR: skills/ directory not found at $SKILLS_DIR" >&2
  exit 1
fi

if ! $DRY_RUN; then
  echo "=== Checking LobeHub CLI auth ==="
  if ! npx -y @lobehub/market-cli auth status --output json 2>/dev/null | grep -q '"status": "authenticated"'; then
    echo "ERROR: Not authenticated. Run:"
    echo "  npx -y @lobehub/market-cli login"
    echo "  npx -y @lobehub/market-cli github connect"
    exit 1
  fi
  echo "Authenticated. Proceeding..."
  echo
fi

SUCCESS=0
FAIL=0
SKILL_ID_PREFIX="${GITHUB_OWNER}-${REPO_NAME}"

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "SKIP  $skill_name (no SKILL.md)"
    continue
  fi

  identifier="${SKILL_ID_PREFIX}-${skill_name}"

  if $DRY_RUN; then
    echo "DRY  $skill_name -> identifier: $identifier"
    SUCCESS=$((SUCCESS + 1))
    continue
  fi

  echo "PUBLISH  $skill_name (identifier: $identifier) ..."
  if npx -y @lobehub/market-cli skill publish \
    --dir "$skill_dir" \
    --identifier "$identifier" 2>&1; then
    echo "  OK   $identifier"
    SUCCESS=$((SUCCESS + 1))
  else
    echo "  FAIL $skill_name"
    FAIL=$((FAIL + 1))
  fi
  echo
done

echo "=== Done: $SUCCESS published, $FAIL failed ==="
if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
