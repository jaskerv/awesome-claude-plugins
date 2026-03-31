#!/bin/bash
set -uo pipefail

# Read hook input from stdin
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

# Skip silently if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only run on JS/TS files
if [[ ! "$FILE_PATH" =~ \.(js|jsx|ts|tsx|mjs|cjs)$ ]]; then
  exit 0
fi

# Detect oxlint: prefer local devDependency over global
OXLINT=""
if [ -n "$CWD" ] && [ -f "$CWD/node_modules/.bin/oxlint" ]; then
  OXLINT="$CWD/node_modules/.bin/oxlint"
elif command -v oxlint &>/dev/null; then
  OXLINT="$(command -v oxlint)"
else
  jq -n '{"systemMessage": "oxlint-hook: oxlint not found. Install it (`npm install -g oxlint`) or add to devDependencies."}'
  exit 0
fi

# Change to project root so .oxlintrc.json is discovered correctly
if [ -n "$CWD" ]; then
  cd "$CWD"
fi

# Auto-fix fixable violations in place
# || true: oxlint --fix exits non-zero when it finds violations (even ones it fixed), so we ignore the exit code here
"$OXLINT" --fix "$FILE_PATH" >/dev/null 2>&1 || true

# Run again to capture any remaining violations
LINT_EXIT=0
RESULT=$("$OXLINT" "$FILE_PATH" 2>&1) || LINT_EXIT=$?

# Report remaining violations to Claude
if [ "$LINT_EXIT" -ne 0 ] && [ -n "$RESULT" ]; then
  MESSAGE="oxlint found issues in $(basename "$FILE_PATH"):"$'\n'"$RESULT"
  jq -n --arg msg "$MESSAGE" '{"systemMessage": $msg}'
fi
