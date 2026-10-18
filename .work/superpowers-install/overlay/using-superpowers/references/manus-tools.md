# Manus Tool Mapping

Skills speak in actions ("invoke a skill", "dispatch a subagent", "create a todo"). On Manus (Desktop, Cloud Computer, or Sandbox) these resolve to the tools below. Trust the tools actually available in the session over this table when they disagree.

## Precedence

Manus platform instructions and your human partner's instructions (including any `AGENTS.md` in the workspace) take precedence over every Superpowers skill. If a skill conflicts with them, for example on how to ask questions, when to end a turn, or Git attribution, follow the Manus/user rule and keep the rest of the skill's discipline.

## Tools

| Action skills request | Manus equivalent |
|---|---|
| Invoke a skill (`Skill` tool, `superpowers:<name>`) | `read` the `SKILL.md` path listed for `<name>` in the session's skill list (installed copies live in `~/.manus/user-skills/<name>/SKILL.md`) |
| Read a file | `read` |
| Create / overwrite a file | `write` |
| Edit a file (targeted patch) | `edit` (V4A patch) |
| Run a shell command, search file contents, find files | `exec` (`rg`/`grep`/`find`) |
| Search the web / fetch a page | `search` / `fetch` |
| Ask your human partner a question | Plain reply that ends the turn, or `ask` (blocking) when work cannot continue without the answer. Ask one question at a time, as brainstorming requires |
| Task tracking (`TodoWrite`, "create a todo") | No todo tool: keep checkboxes in the plan file, or a `TODO.md` under the task's `.work/` directory |
| Dispatch a subagent (`Task`/`Agent`, "Subagent (general-purpose):") | See below |
| Instructions file (`CLAUDE.md`, "your instructions file") | `AGENTS.md` in the workspace root or nearest parent directory |

## Invoking a skill

`superpowers:brainstorming` means the skill named `brainstorming`. Resolve bundled files (`scripts/`, prompt templates, references) relative to the directory containing that skill's `SKILL.md`, and run scripts with absolute paths, e.g. `bash ~/.manus/user-skills/subagent-driven-development/scripts/task-brief PLAN_FILE 1`.

## Subagents

Manus does not expose a single-subagent dispatch tool directly. When the `workflow` MCP server is available, subagent fan-out goes through it: read the `workflow-composer` skill first, then compose the dispatch with `workflow/run`, giving each unit the self-contained prompt the Superpowers skill specifies (implementer brief, reviewer package path, and so on). If workflow fan-out is unavailable or a poor fit for the plan, do not fabricate `Task` calls. Use `superpowers:executing-plans` to implement inline, with one fresh review of the whole branch at the end.

## Git and worktrees

Follow the Manus execution-environment rules for worktrees. A system-prepared worktree may start with detached HEAD, so create a meaningful branch before committing. Detect the environment read-only first:

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

`GIT_DIR != GIT_COMMON` means you are already in a linked worktree, so skip creation. Add the Manus commit attribution trailer to commits you create.

## Diagnosing sessions

Manus session transcripts are not available as local files. When `diagnosing-superpowers` asks for a transcript, analyze the current conversation, or ask your human partner to paste or export the relevant session.
