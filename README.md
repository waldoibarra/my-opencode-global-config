# OpenCode Global Config

Backup of my OpenCode global configuration.

## Setup

```sh
cd ~/.config/
git clone git@github.com:waldoibarra/my-opencode-global-config.git opencode
cd opencode/
```

## What's Included

### Agents

- **gentleman** — Primary agent: Senior Architect mentor (helpful first, challenging when it counts)
- **dangerous-gentleman** — Full permissions variant for unrestricted work
- **sdd-\*** — SDD workflow subagents (init, explore, propose, spec, design, tasks, apply, verify, archive)
- **sdd-orchestrator** — Coordinates SDD subagents

### Skills

SDD phase implementations and skill registry:

- `sdd-init`, `sdd-explore`, `sdd-propose`, `sdd-spec`, `sdd-design`
- `sdd-tasks`, `sdd-apply`, `sdd-verify`, `sdd-archive`
- `skill-registry`

### MCP Servers

- Context7 (code intelligence)
- Engram (persistent memory)
- Notion
- Jira

## Origin

This setup is based on the [gentleman-programming](https://github.com/gentleman-programming) ecosystem, which provides the SDD (Spec-Driven Development) workflow and agent orchestration patterns. Engram is the persistence layer used for artifact storage.
