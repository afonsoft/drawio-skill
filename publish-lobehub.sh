#!/usr/bin/env bash
# Publish all skills in this repo to the LobeHub Skills Marketplace.
#
# LobeHub auto-scrapes GitHub repos for SKILL.md files. Once a skill is
# indexed, it appears as an unclaimed entry. This script:
#   1. Claims ownership of each skill (if not already owned)
#   2. Publishes a new version
#
# Prerequisites (one-time, per machine):
#   1. Node.js >= 22
#   2. npx -y @lobehub/market-cli login          # browser OAuth
#   3. npx -y @lobehub/market-cli github connect  # verify GitHub ownership
#
# Usage:
#   ./publish-lobehub.sh            # claim + publish all skills
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
CLAIMED=0
ALREADY_OWNED=0
NOT_INDEXED=0
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

  echo "--- $skill_name (identifier: $identifier) ---"

  # Step 1: Check if we already own this skill
  OWNED=$(npx -y @lobehub/market-cli skill list --output json 2>/dev/null \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(any(s.get('identifier')=='$identifier' for s in d.get('data',[])))" 2>/dev/null || echo "False")

  if [[ "$OWNED" == "True" ]]; then
    echo "  Already owned."
    ALREADY_OWNED=$((ALREADY_OWNED + 1))
  else
    # Step 2: Try to claim it (works if LobeHub scraper has indexed it)
    echo "  Claiming..."
    if npx -y @lobehub/market-cli skill claim "$identifier" 2>&1 | grep -q "Claimed"; then
      echo "  Claimed OK."
      CLAIMED=$((CLAIMED + 1))
    else
      echo "  NOT INDEXED yet — LobeHub scraper hasn't discovered this skill."
      echo "  Skills are auto-scraped from GitHub. Ensure the repo has topics like"
      echo "  'claude-code', 'ai-agent', 'skill-md'. Re-run later."
      NOT_INDEXED=$((NOT_INDEXED + 1))
      FAIL=$((FAIL + 1))
      echo
      continue
    fi
  fi

  # Step 3: Publish new version
  echo "  Publishing..."
  if npx -y @lobehub/market-cli skill publish \
    --dir "$skill_dir" \
    --identifier "$identifier" 2>&1 | grep -q "Published"; then
    echo "  Published OK."
    SUCCESS=$((SUCCESS + 1))
  else
    echo "  Publish FAILED."
    FAIL=$((FAIL + 1))
  fi
  echo
done

echo "=== Summary ==="
echo "  Published:       $SUCCESS"
echo "  Claimed this run: $CLAIMED"
echo "  Already owned:   $ALREADY_OWNED"
echo "  Not indexed yet: $NOT_INDEXED"
echo "  Failed:          $FAIL"
if [[ $FAIL -gt 0 ]] && [[ $NOT_INDEXED -gt 0 ]]; then
  echo ""
  echo "NOTE: $NOT_INDEXED skill(s) not yet indexed by LobeHub scraper."
  echo "The scraper runs periodically. Re-run this script later."
  # Don't fail the workflow if the only issue is not-indexed skills
  if [[ $((FAIL - NOT_INDEXED)) -eq 0 ]]; then
    exit 0
  fi
fi
if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
