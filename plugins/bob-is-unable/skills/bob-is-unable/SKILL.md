---
name: bob-is-unable
description: >
  Prevent token exhaustion in Claude Code sessions. Use proactively when starting long tasks,
  when context feels heavy, or when the user says "running out of tokens" / "context full" /
  "bob is unable". Combines proactive compaction, CLAUDE.md compression, session handoff,
  and restoration into one workflow.
---

# Bob Is Unable — Token Exhaustion Prevention

> "Bob is unable to continue due to context limits" = you failed. This skill prevents that.

## Iron Law

```
NEVER let context exceed 60%. Act at 50%. Panic at 70%.
```

---

## V2 Two-Model Protocol

1. **Plan phase** — `/model claude-opus-4-7` → `/bob-plan` → save plan
2. **Execute phase** — `/model claude-haiku-4-5-20251001` → `/bob-code <plan>` → mechanical execution
3. **Handoff phase** — `/bob-handoff` at 50% context → `/compact` with handoff summary
4. **Restore phase** — new session → "Read ~/.claude/session-handoff.md and resume"

Hooks auto-warn at 50/60/70% thresholds. Trust hooks.

See `model-routing.md` for which model per task type.

---

## Context Thresholds

| Context Used | Status | Action |
|-------------|--------|--------|
| < 40% | Safe | Keep working |
| 40–50% | Caution | Compress CLAUDE.md, trim tool outputs |
| 50–60% | Warning | Write handoff NOW, plan compact |
| 60–70% | Danger | Run `/compact` with handoff summary |
| > 70% | Critical | Compact immediately, accept quality loss |

Check with `/context` command. The percentage shown is your enemy.

---

## The 5 Phases

### Phase 1: Monitor (start of every session)

Run `/context` at session start. Note the % used. If above 30% before doing anything, you're already behind — go to Phase 2.

**What burns tokens fast:**
- Long tool outputs (file reads, bash output)
- Repeated file reads of the same file
- Loaded but unused skills
- Verbose error messages kept in context

### Phase 2: Compress (40%+ threshold)

Compress `CLAUDE.md` and memory files to save input tokens each turn.

**Compression rules (apply to natural language, NOT code):**
- Drop articles: a, an, the
- Drop filler: just, really, basically, actually, simply
- Drop pleasantries: sure, certainly, of course
- Drop hedging: might be, could potentially, seems like
- Fragments OK. Short synonyms (big not extensive, fix not "implement a solution for")
- PRESERVE EXACTLY: code blocks, inline code, URLs, file paths, commands, version numbers

Example:
```
Before: "The authentication module is basically just responsible for handling the user's login and logout functionality."
After: "Auth module handles login/logout."
```

Run the caveman:compress skill on CLAUDE.md if available:
```
/caveman:compress ~/.claude/CLAUDE.md
```

Or manually edit CLAUDE.md to remove filler, cap at 200 lines.

### Phase 3: Handoff Prep (50%+ threshold)

Write a structured handoff note BEFORE compacting. This is the seed for the next session.

Use the template in `handoff-template.md`. Fill it out completely. Save to a file:
```
~/.claude/session-handoff.md
```

**Critical: do this BEFORE running /compact.** After compact, you may lose the context needed to write it.

### Phase 4: Compact (60%+ threshold)

Run compact with your handoff summary as the preservation instruction:

```
/compact Keep: [paste first 3 lines of handoff summary here]
```

The summary text tells Claude what to preserve during compaction. Without it, random context gets dropped.

**What to always preserve in the compact instruction:**
- Current task goal
- Files being modified
- Key architectural decisions made this session
- Any bugs/blockers discovered
- Immediate next steps

### Phase 5: Restore (new session)

Start every new session after a compact or fresh start with:

```
Read ~/.claude/session-handoff.md and resume from where we left off.
```

Then immediately run `/context` again to confirm you're starting clean.

---

## Common Rationalizations (and why they're wrong)

| Rationalization | Reality |
|----------------|---------|
| "I'll compact when I see the warning" | Warning appears at 95%. Too late. |
| "This file read is the last one" | It never is. |
| "The session is almost done anyway" | Last 10% of work burns 40% of tokens. |
| "Compact will lose important context" | That's why Phase 3 exists. Write the handoff first. |
| "I'll remember to do this next time" | You won't. Use the /bob command. |

---

## Quick Reference

```
/context          → check token usage
/compact [hint]   → compress with preservation hint
/bob              → automated check + recommendation
```

**Handoff file location:** `~/.claude/session-handoff.md`

**Rule of thumb:** If you're thinking "I should probably compact soon" — you should have compacted 10 minutes ago.

---

## Sources

Techniques combined from:
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices) — official docs
- [Compaction docs](https://platform.claude.com/docs/en/build-with-claude/compaction) — official
- Community consensus: compact at 60%, not 95%
- Caveman plugin — compression rules for natural language
- `clauditor`, `claude-mem`, `handoff` GitHub projects — session continuity patterns
