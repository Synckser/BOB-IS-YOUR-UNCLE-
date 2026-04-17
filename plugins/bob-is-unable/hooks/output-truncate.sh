#!/bin/bash
# PostToolUse hook — warns when tool output is large (saves future context)
SIZE=$(wc -c)
if [ "$SIZE" -gt 5120 ]; then
  echo "[BOB] Large output: ${SIZE} bytes — next time use grep/head/offset to narrow" >&2
fi
exit 0
