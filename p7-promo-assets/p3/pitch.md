# P3 Plugin Harness: promo notes

**One-line pitch:** A local AI agent host with no built-in model and no built-in tools. Every capability is a sandboxed plugin you install, grant permissions to, and can revoke at any time.

**Three key points**

1. **Plugins really are the product.** The LLM provider, the file tools, the audit log and its guard, the dashboard panel and the commands are all plugins speaking one JSON-RPC protocol. Uninstall them and the host can do nothing. A Python plugin with no SDK works too.
2. **One bad plugin can't take the host down.** Each plugin runs in its own process. Crashes, hangs and garbage output become clear errors (`PLUGIN_CRASHED`, `TIMEOUT`) with the plugin's last log lines, while the agent run and every other plugin keep going. A circuit breaker stops crash loops.
3. **Permissions you can see and revoke.** Plugins declare files, hosts, secrets and processes up front. You grant them in a dialog with risk levels, and Deno's sandbox and the host's broker enforce them: `PERMISSION_DENIED fs.read:/etc/hosts`. Guards can veto a real LLM's tool calls live.

**Assets in this folder**

- `promo.mp4`: the finished 59.6 s launch video (1920×1080 H.264, AAC). It's built only from the real captures and verbatim CLI output listed here, with narration and music. Brief, storyboard and build script: `p3-plugin-harness/docs/promo/`.
- `01-agent-run-live-llm-guard-denied.png`: a real OpenRouter model lists and reads files through the fs-tools plugin; the audit-trail guard blocks its write.
- `02-audit-trail-plugin-panel.png`: a dashboard panel contributed by a plugin (rendered from data, not plugin HTML).
- `03-crash-contained-in-run.png`: a plugin kills itself mid-call; the run completes and reports `PLUGIN_CRASHED`.
- `04-crashed-plugin-last-error.png`: what the user sees afterwards: status, error code, hint, timestamp.
- `terminal-live-llm-run.txt`: CLI transcript of the same core journey.
- `terminal-e2e-acceptance.txt`: 45/45 acceptance checks (crash, hang, incompatible version, permission denials, revoke, guards, update re-approval, first-plugin loop, Python plugin, live LLM).

Suggested 45-second recording flow: `harness run` fails with NO_PROVIDER → install and enable plugins in the dashboard (grant dialog) → agent console run with the guard denial → crashy crash → audit panel.
