# Q-13 / AC-13 — Manus as the MCP client (tunnel validation, 2026-10-18)

**Result: PASS.** A regular Manus cloud task, connected to termctl as a custom MCP server, created and controlled terminal sessions on the user's Mac through termctl's tools only (10 tools listed; `terminal_info`, `terminal_exec`, `terminal_create`, `terminal_write`, `terminal_status`, `terminal_list`, `terminal_kill` used), including the human-approval flow for a recursive delete.

## Setup (D-020)

- `termctl serve` on the Mac with `TERMCTL_PUBLIC_HOSTS=.trycloudflare.com`, `TERMCTL_ALLOWED_DIRS=<project>:/tmp`, fresh token.
- cloudflared quick tunnel (`cloudflared tunnel --url http://127.0.0.1:3051`), temporary.
- Manus custom MCP server (Streamable HTTP): URL `https://<random>.trycloudflare.com/mcp`, header `Authorization: Bearer <token>` entered by the human.
- Test task: https://manus.im/app/TiwcMXSs7gXdXaj5igYyfg (private). Instructions: use only termctl tools, no fallback to the sandbox shell, never approve anything itself.
- Afterwards: tunnel and server stopped, token rotated (the token stored in Manus is now invalid), public URL returns HTTP 530.

## What went wrong on the way (all diagnosed from termctl's own logs)

1. **Attempt 1 (16:42)** — termctl was never reached: Manus cannot attach a local stdio MCP server (custom MCP servers are cloud connectors reached by HTTPS URL). Fixed by the tunnel route.
2. **17:07 / 17:11** — Manus sent **no Authorization header** (`http_rejected … auth.problem="no Authorization header"`): the header value had been left blank when the connector was created. Manus's client reported this as "OAuth authentication failed … authorization required". The human pasted the header; the next request authenticated.
3. **17:23** — the agent's background shells were closed by a permission-mode change; termctl received SIGINT, ended its session cleanly (`sessions_shutdown`, `server_stopped`) and the pending approval `apr-f189fc` was lost. Server and tunnel restarted (new tunnel URL).
4. **17:25** — updating only the connector URL made Manus send the literal mask `__ENCRYPTED__` as the header (`auth.problem="malformed header", scheme="__ENCRYPTED__", length=13`). The human re-pasted the header.

## termctl audit log during the run (excerpt, generated)

| time (UTC) | event | detail |
|---|---|---|
| 09:07:59.108 | http_rejected | reason="missing or invalid token", status=401 |
| 09:10:40.188 | client_disconnected |  |
| 09:10:40.190 | server_stopped | reason="SIGINT" |
| 09:10:57.424 | server_started |  |
| 09:11:37.591 | http_rejected | auth={"problem": "no Authorization header", "scheme": null, "length": 0}, reason="missing or invalid token", status=401 |
| 09:17:12.523 | client_connected | client={"name": "Manus", "version": "dev"} |
| 09:17:39.356 | tool_call | terminal_info |
| 09:17:47.906 | session_created | command="/bin/zsh (user profile)", session_id="t-63d745" |
| 09:17:48.768 | exec_started | command="cd ~/Documents && ls \| head -5", session_id="t-63d745" |
| 09:17:49.095 | exec_finished | session_id="t-63d745", exit_code=0 |
| 09:17:49.095 | tool_call | terminal_exec |
| 09:17:57.471 | exec_started | command="pwd", session_id="t-63d745" |
| 09:17:57.487 | exec_finished | session_id="t-63d745", exit_code=0 |
| 09:17:57.488 | tool_call | terminal_exec |
| 09:18:07.746 | session_created | command="python3", session_id="t-980ef8" |
| 09:18:08.134 | tool_call | terminal_create |
| 09:18:17.953 | input_written | session_id="t-980ef8" |
| 09:18:17.959 | tool_call | terminal_write |
| 09:18:25.695 | input_written | session_id="t-980ef8" |
| 09:18:25.717 | session_ended | session_id="t-980ef8", exit_code=0 |
| 09:18:25.725 | tool_call | terminal_write |
| 09:18:33.993 | exec_started | command="sleep 60", session_id="t-63d745" |
| 09:18:35.996 | exec_finished | session_id="t-63d745" |
| 09:18:35.996 | tool_call | terminal_exec |
| 09:18:42.284 | input_written | session_id="t-63d745", keys=["ctrl+c"] |
| 09:18:42.477 | tool_call | terminal_write |
| 09:18:50.293 | tool_call | terminal_status |
| 09:18:58.134 | policy_decision | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", rule="rm-recursive", decision="ask" |
| 09:18:58.148 | approval_pending | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", approval_id="apr-f189fc", rule="rm-recursive" |
| 09:18:58.149 | tool_call | tool="terminal_exec", code="APPROVAL_REQUIRED" |
| 09:23:32.212 | session_ended | session_id="t-63d745", exit_code=1 |
| 09:23:32.216 | sessions_shutdown | reason="SIGINT" |
| 09:23:32.216 | client_disconnected |  |
| 09:23:32.216 | server_stopped | reason="SIGINT" |
| 09:24:15.592 | server_started |  |
| 09:25:04.589 | http_rejected | auth={"problem": "malformed header", "scheme": "__ENCRYPTED__", "length": 13}, reason="missing or invalid token", status=401 |
| 09:27:50.178 | client_connected | client={"name": "Manus", "version": "dev"} |
| 09:27:59.034 | tool_call | terminal_list |
| 09:28:08.941 | policy_decision | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", rule="rm-recursive", decision="ask" |
| 09:28:08.943 | approval_pending | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", approval_id="apr-4672a8", rule="rm-recursive" |
| 09:28:08.943 | tool_call | tool="terminal_exec", code="APPROVAL_REQUIRED" |
| 09:28:27.771 | approval_approved | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", approval_id="apr-4672a8", rule="rm-recursive", via="cli" |
| 09:28:41.491 | policy_decision | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", rule="rm-recursive", decision="ask" |
| 09:28:41.495 | approval_used | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", approval_id="apr-4672a8", rule="rm-recursive", via="cli" |
| 09:28:41.495 | approval_used | tool="terminal_exec", command="rm -rf /tmp/termctl-demo", approval_id="apr-4672a8" |
| 09:28:41.523 | session_created | command="/bin/zsh (user profile)", session_id="t-5213fb" |
| 09:28:42.336 | exec_started | command="rm -rf /tmp/termctl-demo", session_id="t-5213fb" |
| 09:28:42.595 | exec_finished | session_id="t-5213fb", exit_code=0 |
| 09:28:42.595 | tool_call | terminal_exec |
| 09:28:51.383 | exec_started | command="ls /tmp/termctl-demo", session_id="t-5213fb" |
| 09:28:51.420 | exec_finished | session_id="t-5213fb", exit_code=1 |
| 09:28:51.420 | tool_call | terminal_exec |
| 09:28:58.256 | tool_call | terminal_list |
| 09:29:04.853 | session_ended | session_id="t-5213fb", exit_code=1 |
| 09:29:04.854 | session_killed | session_id="t-5213fb" |
| 09:29:04.854 | tool_call | terminal_kill |
| 09:29:11.123 | tool_call | terminal_list |

## Manus's own final report (verbatim, directory listing redacted)

The termctl test passed for steps 1 to 6. The one exception was connecting: it failed whenever the saved Authorization header was missing or wrong. Once the user approved `apr-4672a8`, the retried `rm -rf /tmp/termctl-demo` ran with exit code 0. `ls /tmp/termctl-demo` then returned `No such file or directory`, so the folder is gone. At the end no sessions were running. I used only termctl tools throughout, never started an OAuth login and never approved anything myself.

| Step | termctl tools used | Result | Errors / surprises |
|---|---|---|---|
| 0a. First connect (run 1) | none (tool listing failed) | Failed | `OAuth authentication failed: failed to initialize client: transport error: authorization required`. Auth status: unauthenticated, no saved token |
| 0b. Single retry (run 2) | none (tool listing failed) | Failed | Same error word for word |
| 0c. Connect after token saved | tool listing | 10 tools listed | Worked |
| 1 | `terminal_info` | Name `termctl`, version `0.1.0`, policy mode `enforce` | Allowed folders: `/Users/wesley/Documents/manus/p5-mcp-terminal` and `/tmp` |
| 2 | `terminal_exec` ×2 | `ls \| head -5` printed 5 entries [names omitted for privacy]. `pwd` in the same session printed `/Users/wesley/Documents` | The `cd` carried over between calls. Surprise: `~/Documents` is outside the allowed folders but wasn't blocked |
| 3 | `terminal_create`, `terminal_write` ×2 | `2**100` = `1267650600228229401496703205376`. Python 3.14.5 then exited with code 0 | Worked well |
| 4 | `terminal_exec`, `terminal_write` (ctrl+c), `terminal_status` | Timed out after 2 s (`timed_out: true`). Exit code after ctrl+c: **130** (SIGINT) | The ctrl+c reply showed `exit_code: null`. The 130 only appeared as `last_exit_code` in `terminal_status` |
| 5, first try | `terminal_exec` | `APPROVAL_REQUIRED` (rule `rm-recursive`), id `apr-f189fc` | The approval worked as designed but was lost in the restart before it could be used |
| Server restart (your side) | `terminal_list` (failed) | Old sessions and approval cleared. The first call after the restart failed | Your team had overwritten the token, but the error still read `OAuth authentication failed ... authorization required` |
| Token re-saved | tool listing, `terminal_list` | Tools listed; `terminal_list` returned `count: 0` | Sessions don't survive a restart |
| 5, redo | `terminal_exec` ×3 | First call: `APPROVAL_REQUIRED`, id `apr-4672a8`. After approval: exit code 0 in new session `t-5213fb`. `ls /tmp/termctl-demo`: exit code 1, `No such file or directory` | See the folder mismatch below. Also, `rm -rf` succeeds even if the folder doesn't exist, so it's unclear whether it existed beforehand |
| 6 | `terminal_list` ×2, `terminal_kill` | One session still running (`t-5213fb`). Killed with SIGTERM (`escalated: false`). The final list showed 0 running | The killed session reported `exit_code: 1` and `signal: null`. That 1 came from the earlier `ls`, not from the kill |

**Things worth fixing in termctl:**

- **Misleading auth error:** termctl uses a static bearer token, but a missing or wrong token always produces an "OAuth authentication failed" message. That points debugging in the wrong direction.
- **Folder scope:** being outside `allowed_dirs` didn't block moving into or listing `~/Documents`. The folder list seems to affect only defaults and rules, not access in general.
- **Approval folder mismatch:** for `apr-4672a8`, termctl said the command would run "in `~`". The new session actually started in `/Users/wesley/Documents/manus/p5-mcp-terminal`, and the approval was still accepted. That's worth checking, since `terminal_info` says approvals are bound to the exact command and folder.
- **Nothing survives a restart:** sessions and pending approvals are lost when the server restarts.
- **Exit codes:** after ctrl+c or a kill, the useful exit code appears only as `last_exit_code` in `terminal_status`, not in the `terminal_write` or `terminal_kill` replies.

## termctl findings from this run

| Finding | Status |
|---|---|
| Approval showed `in ~` while the session started in the first allowed folder (F10) | **Fixed** — approvals now record the resolved absolute directory; disallowed folders fail before an approval is requested; e2e test "approvals under a folder scope" |
| Duplicate `approval_used` audit event | **Fixed** (same commit) |
| Exit code after ctrl+c appears only as `last_exit_code` in `terminal_status`, not in the `terminal_write` reply | Follow-up (backlog) |
| Sessions and pending approvals do not survive a server restart | By design for 0.1 (documented limitation) |
| Folder scope limits where sessions start, not where the shell may `cd` | By design (D-013, documented) |
| Missing/wrong token is shown by Manus as an OAuth error | Manus client behaviour; termctl now logs the exact header problem |
