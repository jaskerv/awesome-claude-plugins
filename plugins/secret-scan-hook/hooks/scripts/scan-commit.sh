#!/bin/bash
set -uo pipefail

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

# Skip if not a git commit command
if [[ ! "$COMMAND" =~ ^git[[:space:]]+commit ]]; then
  exit 0
fi

# Fail open if gitleaks not installed
if ! command -v gitleaks &>/dev/null; then
  exit 0
fi

# Change to project root so gitleaks has git context and discovers .gitleaks.toml
if [ -n "$CWD" ] && [ -d "$CWD" ]; then
  cd "$CWD"
fi

# Skip if no staged files
STAGED=$(git diff --cached --name-only 2>/dev/null)
if [ -z "$STAGED" ]; then
  exit 0
fi

# Scan the staging area via pipe — exit 1 = secrets found, exit 0 = clean
# --staged flag was removed in gitleaks v8.x; pipe the diff instead
REPORT=$(mktemp)
trap 'rm -f "$REPORT"' EXIT
SCAN_EXIT=0
git diff --cached | gitleaks detect --pipe --no-banner -f json -r "$REPORT" 2>/dev/null || SCAN_EXIT=$?

if [ "$SCAN_EXIT" -ne 0 ] && [ "$SCAN_EXIT" -ne 1 ]; then
  exit 0
fi

if [ "$SCAN_EXIT" -eq 1 ]; then
  FINDINGS=""
  if [ -s "$REPORT" ]; then
    FINDINGS=$(jq -r '.[] | "\(.File) line \(.StartLine): \(.RuleID) — \(.Description)"' "$REPORT" 2>/dev/null)
  fi
  if [ -z "$FINDINGS" ]; then
    FINDINGS="  (no details available)"
  fi
  REASON="secret-scan-hook blocked commit: secret(s) detected in staged files:
$FINDINGS

Remove or rotate the secret(s) and re-stage before committing."
  jq -n --arg reason "$REASON" '{"decision": "deny", "reason": $reason}'
  exit 1
fi
