---
name: bob-plan
description: Switch to opus and enter planning mode for any non-trivial task. Produces a saved plan ready for /bob-code execution.
---

# /bob-plan — Opus-Powered Planning

Execute:

1. Check current model. If not opus, tell user: "Run `/model claude-opus-4-7` first for best planning."
2. Invoke `superpowers:writing-plans` skill.
3. Save plan to `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`.
4. After plan saved, output:
   ```
   Plan saved. Next:
   1. /model claude-haiku-4-5-20251001
   2. /bob-code <path-to-plan>
   ```
