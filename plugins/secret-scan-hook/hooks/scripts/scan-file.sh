#!/bin/bash
set -uo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

# Skip if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Skip if file does not exist
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Fail open if gitleaks not installed
if ! command -v gitleaks &>/dev/null; then
  jq -n '{"systemMessage": "secret-scan-hook: gitleaks not found. Install it (`brew install gitleaks`) to enable secret scanning."}'
  exit 0
fi

# Change to CWD so .gitleaks.toml is discovered
if [ -n "$CWD" ] && [ -d "$CWD" ]; then
  cd "$CWD"
fi

# Scan the file — exit 1 = secrets found, exit 0 = clean
REPORT=$(mktemp)
trap 'rm -f "$REPORT"' EXIT
SCAN_EXIT=0
gitleaks detect --no-git --source "$FILE_PATH" --report-format json --report-path "$REPORT" --no-banner 2>/dev/null || SCAN_EXIT=$?

if [ "$SCAN_EXIT" -ne 0 ] && [ "$SCAN_EXIT" -ne 1 ]; then
  jq -n --arg code "$SCAN_EXIT" '{"systemMessage": ("secret-scan-hook: gitleaks exited with unexpected code " + $code + ". Check your .gitleaks.toml.")}'
  exit 0
fi

if [ "$SCAN_EXIT" -eq 1 ] && [ -f "$REPORT" ]; then
  FINDINGS=$(jq -r '.[] | "  \(.RuleID) at line \(.StartLine): \(.Description)"' "$REPORT" 2>/dev/null)
  if [ -z "$FINDINGS" ]; then
    FINDINGS="  (no details available)"
  fi
  MESSAGE="secret-scan-hook: potential secret(s) detected in $(basename "$FILE_PATH"):
$FINDINGS

Remove or rotate the secret before committing."
  jq -n --arg msg "$MESSAGE" '{"systemMessage": $msg}'
fi
