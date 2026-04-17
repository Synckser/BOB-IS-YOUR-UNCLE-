#!/bin/bash
# PreToolUse hook — warns when context crosses thresholds
PCT="${CLAUDE_CONTEXT_PERCENT:-0}"
if [ "$PCT" -ge 70 ]; then
  echo "[BOB] CRITICAL: context ${PCT}% — run /bob-handoff then /compact NOW" >&2
elif [ "$PCT" -ge 60 ]; then
  echo "[BOB] DANGER: context ${PCT}% — write handoff, compact soon" >&2
elif [ "$PCT" -ge 50 ]; then
  echo "[BOB] WARNING: context ${PCT}% — plan compact" >&2
fi
exit 0
