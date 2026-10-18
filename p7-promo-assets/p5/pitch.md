# P5 MCP Terminal Controller (termctl): promo notes

**One-line pitch:** termctl is an MCP server that gives any agent real, persistent terminal sessions on your machine, and leaves you in control of anything risky.

**Three key points**

1. **A real terminal, not a one-shot command.** Sessions are real PTYs that remember their working directory and environment. Long-running processes such as dev servers keep going, and the agent reads their output incrementally with cursors instead of blocking. Agents can type into interactive programs like a Python REPL, send keys such as ctrl+c, check running state and exit codes, and kill sessions. Ten MCP tools are designed to combine cleanly.
2. **You stay in control.** Destructive commands are blocked outright. Risky ones, such as recursive deletes, pause with `APPROVAL_REQUIRED` until you approve them once with `termctl approve` or one click in the local dashboard. Each approval is single-use, bound to that command and folder, and expires after 10 minutes. Agents cannot approve themselves (`POLICY_DENIED self-approve`). Secret environment variables are filtered, secrets in output are redacted, and every action is written to an audit log.
3. **Works with real MCP clients.** termctl speaks standard MCP over stdio or Streamable HTTP with a bearer token. It was validated end to end with **Manus**: a cloud task drove zsh and python3 sessions on a Mac through a temporary HTTPS tunnel, and its recursive delete was held for approval and then ran. 83 automated tests cover unit logic, real PTYs and MCP end to end.

**Assets in this folder**

- `promo.mp4`: the finished 59.2 s launch video (1920×1080 H.264, AAC, narration, music, burned-in captions), with `promo.srt` captions and `promo-poster.png`. Every terminal frame comes from a real recorded termctl run (`terminal-real-session-capture.txt`), and the approval scenes are real dashboard screenshots. Brief, storyboard and build sources: `p5-mcp-terminal/docs/promo/BRIEF.md` and `p5-mcp-terminal/promo/`.
- `01-live-output-two-sessions.png`: an agent starts a dev server in one session, curls it from another, and reads the server's new log line with a cursor.
- `02-interactive-python-and-ctrl-c.png`: the agent types `2**100` into a Python REPL, then stops the dev server with ctrl+c (exit 0).
- `03-dashboard-approval-pending.png`: real screenshot of a held `rm -rf ./build` waiting in the local dashboard.
- `04-dashboard-approved-once.png`: the same request after one click on **Approve once**; the audit log shows `via: dashboard`.
- `05-tested-end-to-end-with-manus.png`: what the Manus validation run did through termctl's tools.
- `terminal-real-session-capture.txt`: the 16 real MCP tool calls behind the video, with their structured results.
- `terminal-e2e-acceptance.txt`: the final `npm test` run, 83/83 passing.
- `manus-task-driving-termctl.md`: the Manus validation run, from termctl's audit log and Manus's own report. There is no screen recording of the Manus UI; this transcript is the record of that run.

Suggested 30–45 s recording flow: an agent runs `cd` then `pwd` in one session → starts a dev server and reads its live output → types into Python and presses ctrl+c → `rm -rf ./build` returns APPROVAL_REQUIRED → approve in the dashboard → the retry succeeds.

**Public URLs** (signed download links, valid until 18 Oct 2027; no hosted live instance, because termctl is a shell by design)

- Acceptance note (how to run and review): [ACCEPTANCE.md](https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/WfRlPFOOrsGsmrzy.md?Expires=1823853927&Signature=sow9V4Qq4QiB0VPhJBe1pyvOD0yvC8VmfaJvBGZtrUbw5EPath1C0~6-J~-CG1t5jI7cstv4pCFh1Z7-aljFjuhckmX2RSiRms0TrP8kLdWL6ODi63VNpZ0PKFWKp64GvmNOYCUHAHGhdDtIv~PLqbP2gb3BUxYHF1IpbyZTeIcyjjVEBBIV6wAOFfcLeooAGMGcKDIW81q8C-OV21p6E0wdXZL7g~UoOcME8iMYPwrEqRmeSah1OSl2dVun7ZZ4ppRp38WTAcLIAKxbQMQDp48gVnz~O4ZWc8WwMI~mI4Rij951Olr2~mlGAFhKIbkAOTGKYyB8EP-92kcWbFIl0Q__&Key-Pair-Id=K2HSFNDJXOU9YS)
- Video: [promo.mp4](https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/xgdojwjmHuWyoIen.mp4?Expires=1823853684&Signature=dvWqQztvxXfAushW3MrIp7j0EWdaDPuCS60tDvtOofqLb4Z33MwSz~~qKR6-OAIEhO0WoXfx6HEGYAeKn8tgQ0Pn0-1HvtpW~8qSMudlFovdVAEngeYtUlMMXKWoIHIWFGK8iegCzR7J1EawpWfhXCI7140k15lE89QpxdQNfCX~i1nRMJ-xKYPny3PyxXrQBiimdyDyHf7AYeMfmC1FEABcS88wyG5-CFjebDHBc4sNOYukOCl42~2Gt3QirscgiiTJG3gj3m9TBmAZNC5~YNn8kcL4I92GvOmVgrao5Ola1lFtgtqHMCgcp~CN6mrFQK43r2rTNR8~tsKU9N26bQ__&Key-Pair-Id=K2HSFNDJXOU9YS)
- Installable package (`npm install -g <URL>`): [termctl-0.1.0.tgz](https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/pDTkWkDsNMOWyeBp.tgz?Expires=1823853692&Signature=MIHOpYt33oB9cxNjs4JBCywfa7O8taf7Z2X7r79Hza83wQNezPSAc5mJGmilaOkTNcqN8~Nc0DGDzF-hdomqlPyek1YOilrVTI9XiuNKu7ff~i6ClnRX4sFJD~peOQLQgqtcqkBzv7Xc8SRldRS3vLNWuuONTlw8SORev1udwwS6Lj~X-tDlJQ66X0ncnPATRWPFxg1AIQ7dPeigVv38ufUlvbIhe2KBE9rUKIZKVk~pwmQkvOrB0qTNLQVbflNE1zrIPuLrCND-j7ok0t8fMuNPh~Pw7gfZaicV71Tt0G1LCAvXMyUtLFqFQtNW2IsdvmN50LE5TBzjiwD9z1J1Rw__&Key-Pair-Id=K2HSFNDJXOU9YS)
- Source: [termctl-source.zip](https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/cUzokTxXXoqiiujH.zip?Expires=1823853692&Signature=R87RUAKPywlb7v4JruF0BS5fOCp40s5EgdxdtsOVBos1C2cbUksp3JDHQ0gGJ0yxcgNmX~0~9wHC5-GgidZ2HNz~eXRCKZxY2ABfrxuDw68h3io9xBSiDV5BSuZPcWvHtFW5nNo9cLkjE6eVUQqQ1BVnD99WfFZJfgTYdKpREjf~y-DzAcqcq8PdqPpV~Fu3csHrZzodyCOvNk4-w7u3NDkIjGmkxGXz~-B0LuTswQfJ86D5o0MuNLVkhZMQnf24~z-WUTzSjjWv54yyvvs9-x~k6xe6PQBQo1pG1WWkjO0n-p3~eYVgXIa7dA1fCMQYkaZBOpkWy7uKKA0ZceHvtw__&Key-Pair-Id=K2HSFNDJXOU9YS)
