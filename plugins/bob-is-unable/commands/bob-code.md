---
name: bob-code
description: Switch to haiku and mechanically execute a saved plan. Cheap, fast, sufficient for implementation.
argument-hint: "[path to plan file]"
---

# /bob-code — Haiku-Powered Execution

Execute:

1. Verify current model is haiku. If not: "Run `/model claude-haiku-4-5-20251001` first."
2. Read plan file from $ARGUMENTS (or find most recent `docs/superpowers/plans/*.md`).
3. Invoke `superpowers:executing-plans` skill.
4. Execute tasks in order. Check boxes as you complete. Commit after each task.
5. If blocked on a task: output "Task N blocked — switch to opus: `/model claude-opus-4-7`, re-plan this task, then switch back."
