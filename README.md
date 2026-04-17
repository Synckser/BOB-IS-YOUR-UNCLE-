# bob-is-unable

> "Bob is unable to continue due to context limits" — never again.

A Claude Code plugin that prevents token exhaustion through proactive context management, CLAUDE.md compression, session handoff, and restoration.

## What It Does

| Problem | Solution |
|---------|----------|
| Context fills up silently | `/bob` command: instant health check + action recommendation |
| Compact loses important context | Structured handoff template written *before* compacting |
| Fresh sessions lack context | Restoration protocol: inject handoff into new session |
| CLAUDE.md bloated | Compression rules that preserve technical content, drop filler |

## Iron Law

```
Never let context exceed 60%. Act at 50%. Panic at 70%.
```

## Install

Add to `~/.claude/settings.json`:

```json
"extraKnownMarketplaces": {
  "bob-is-unable": {
    "source": { "source": "github", "repo": "YOUR_GITHUB_USERNAME/bob-is-unable" }
  }
}
```

Then install:
```
cc plugin install bob-is-unable@bob-is-unable
```

Or test locally:
```
cc --plugin-dir /path/to/bob-is-unable
```

## Usage

```
/bob                → context health check + recommendation
/bob --handoff      → generate pre-filled handoff template
```

Or invoke the skill directly by telling Claude:
> "Check context health" / "bob is unable" / "running out of tokens"

## The 5-Phase Protocol

1. **Monitor** — `/context` at session start
2. **Compress** — compress CLAUDE.md at 40%+
3. **Handoff** — write `~/.claude/session-handoff.md` at 50%+
4. **Compact** — `/compact [handoff summary]` at 60%+
5. **Restore** — `Read ~/.claude/session-handoff.md and resume` in new session

## Techniques Combined From

- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [Compaction docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
- [caveman plugin](https://github.com/juliusbrussee/caveman) — compression rules
- Community consensus: compact at 60%, not 95%
- `clauditor`, `claude-mem`, `handoff` projects — session continuity patterns

## License

MIT
