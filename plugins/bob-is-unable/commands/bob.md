---
name: bob
description: Context health check. Shows token usage and recommends action to prevent exhaustion. Run anytime, but especially before starting a big task.
argument-hint: "[--handoff to generate handoff template]"
---

# /bob — Context Health Check

Run `/context` to get current token usage, then assess and recommend based on percentage used.

## What to do

1. Run `/context` in your head (you cannot literally run slash commands, but check the token counter shown in the UI)
2. Based on context %, output the following assessment:

**If < 40% used:**
```
Context: [X]% — HEALTHY
Keep working. Next check at 40%.
```

**If 40–50% used:**
```
Context: [X]% — CAUTION
Recommend:
1. Compress CLAUDE.md (run /caveman:compress ~/.claude/CLAUDE.md if available)
2. Avoid re-reading already-read files
3. Keep tool outputs terse
```

**If 50–60% used:**
```
Context: [X]% — WARNING
Act now:
1. Fill out handoff template → ~/.claude/session-handoff.md
2. Plan to /compact within next 2-3 exchanges
3. Stop reading new files unless critical
```

**If 60–70% used:**
```
Context: [X]% — DANGER
Stop. Do this now:
1. Write handoff: ~/.claude/session-handoff.md (use template in bob-is-unable skill)
2. Run: /compact Keep: [your current goal and key files]
3. Start fresh session with: "Read ~/.claude/session-handoff.md and resume"
```

**If > 70% used:**
```
Context: [X]% — CRITICAL
Emergency compact:
/compact Keep: [paste goal here]
Then restore from ~/.claude/session-handoff.md in new session.
Quality will degrade if you continue. Stop now.
```

## If called with --handoff flag

Output the handoff template (from `bob-is-unable/handoff-template.md`) pre-filled with what you know about the current session state. User saves this to `~/.claude/session-handoff.md`.
