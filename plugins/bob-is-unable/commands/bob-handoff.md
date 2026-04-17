---
name: bob-handoff
description: Auto-generate session handoff from current context. Run before /compact to preserve state.
---

# /bob-handoff — Auto Session Handoff

Read the template at `${CLAUDE_PLUGIN_ROOT}/skills/bob-is-unable/handoff-template.md`.

Fill in from current session state:
- **Current Goal** — user's last stated task
- **Task Status** — from active TodoList or recent tool uses
- **Key Files** — from recent Read/Write/Edit tool calls
- **Architectural Decisions** — from recent reasoning
- **Active Bugs** — from recent errors or user reports
- **Next Steps** — from unchecked TODOs or pending plan tasks
- **Context to Preserve** — anything non-obvious from session

Write to `~/.claude/session-handoff.md`.

Then output:
```
Handoff saved. Run:
/compact Keep: [current goal + top 3 next steps]
```
