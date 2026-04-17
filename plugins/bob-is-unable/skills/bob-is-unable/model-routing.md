# Model Routing — Plan Smart, Code Cheap

## Rule

| Task type | Model | Why |
|-----------|-------|-----|
| Architecture, spec design | `claude-opus-4-7` | Reasoning quality matters |
| Planning (superpowers:writing-plans) | `claude-opus-4-7` | Deep thinking upfront |
| Implementation (following a plan) | `claude-haiku-4-5-20251001` | Fast, cheap, sufficient |
| Debugging — root cause analysis | `claude-opus-4-7` | Needs deep reasoning |
| Debugging — applying known fix | `claude-haiku-4-5-20251001` | Pattern match |
| Code review | `claude-sonnet-4-6` | Balanced |
| Docs, commits, boilerplate | `claude-haiku-4-5-20251001` | Template-heavy |

## Switching

```
/model claude-opus-4-7                  # planning
/model claude-haiku-4-5-20251001        # coding
/model claude-sonnet-4-6                # review
```

## Protocol

1. Start in opus. Use superpowers:writing-plans. Save plan.
2. Switch to haiku. Use superpowers:executing-plans — follow tasks mechanically.
3. Stuck? Switch to opus for that task only. Switch back after.

## Cost Math

Typical session: 80% implementation, 20% planning.

- All-opus: 100% baseline cost
- Routed (opus 20% + haiku 80%): ~35% of baseline
- **Savings: ~65% dollar cost**

Token count equivalent at ~3x fewer effective tokens billed for same work.
