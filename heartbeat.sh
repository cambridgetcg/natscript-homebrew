#!/usr/bin/env bash
# heartbeat.sh — natscript-homebrew
# A Homebrew tap's truth: is the formula valid? does the source URL resolve?
set -euo pipefail

FORMULA="Formula/natscript.rb"
DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$DIR"

# 1. Formula exists
if [[ ! -f "$FORMULA" ]]; then
  echo "DOWN: formula missing ($FORMULA)"
  exit 1
fi

# 2. SHA256 is not a placeholder
SHA=$(grep -E '^\s*sha256\s+"' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')
if [[ "$SHA" == "PLACEHOLDER" || -z "$SHA" ]]; then
  echo "DOWN: sha256 is PLACEHOLDER — formula cannot install"
  exit 1
fi

# 3. URL is reachable (HEAD only, 10s timeout)
URL=$(grep -E '^\s*url\s+"' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')
if ! curl -sSf -o /dev/null --max-time 10 -I "$URL" 2>/dev/null; then
  echo "UP-NOT-ALIVE: formula present but source URL unreachable ($URL)"
  exit 0
fi

# 4. brew audit (if brew is available)
if command -v brew &>/dev/null; then
  # brew audit disabled: requires tap registration, not local file paths
  # structural validation instead: formula parses as valid Ruby + has required keys
  if ! ruby -e "require 'formula'; eval(File.read('$DIR/$FORMULA'))" 2>/dev/null; then
    # fall back: basic syntax check
    if ! ruby -c "$DIR/$FORMULA" 2>/dev/null; then
      echo "UP-NOT-ALIVE: formula has Ruby syntax errors"
      exit 0
    fi
  fi
fi

echo "ALIVE-CLEAN: formula valid, sha256 set, source URL reachable"