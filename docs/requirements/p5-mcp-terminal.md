# Brief: Problem 5, MCP server terminal controller

Paste this file into a new Manus task in local mode on this Mac. Local mode is needed so the server can be connected to Manus as a local MCP server.

## Problem (verbatim)

Build an MCP server that lets MCP clients or agents create and control local terminal sessions. A client should be able to start commands, keep reading output, write to interactive processes, know the running state, and terminate a session when needed.

It should feel like a terminal capability that an agent can use reliably, not just a single shell command wrapped as an MCP tool.

You can also consider a more direct usage and validation scenario: can this MCP server be connected to any MCP client (for example Manus) so that the client creates and controls terminal sessions through it?

Things worth thinking about:

- MCP interface design: which tools to provide, how to design parameters and return structures, and how to make it easy for an agent to understand them and combine calls correctly;
- Terminal session model: how to manage session IDs, PTYs, working directory, environment variables, stdout, stderr, exit status and interactive input;
- Long-running tasks and incremental output: how to keep reading without blocking, how to paginate or use cursors, and how to bound memory and handle timeouts and cancellation;
- Concurrency and lifecycle: how multiple sessions are isolated, and how to clean up and recover after a client disconnects, a process exits, zombie processes appear or the server restarts;
- Security boundaries: how to handle the scope of command execution, working directories, sensitive environment variables, dangerous commands, user approval and audit records.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p5-mcp-terminal/`. Don't read or change other `p*` folders. Use ports 3050 to 3059, for example for an HTTP transport or an audit viewer.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do, such as adding the server to Manus as a local MCP server. Otherwise proceed on reasonable assumptions.
- **No AI key:** this product doesn't need the OpenRouter key.
- **Deliverables:** put them in `p5-mcp-terminal/outputs/`. Include a source zip without `node_modules`, build caches or secrets, and a `README.md` acceptance note. The note covers install, run, and connecting to an MCP client (Manus and one other), a tool reference with example call sequences, a 5-minute review script, the security model, and known limitations.
- **Promo assets:** save 3 to 5 screenshots, an optional 30 to 60 second recording of a Manus task driving a terminal session through this server, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p5/`.

## Environment and risk notes

- **Suggested stack (not required):** the TypeScript MCP SDK with stdio transport (Streamable HTTP is optional), plus `node-pty` for PTYs. Node is 24.3.0, and `node-pty` is a native module, so confirm in the first 10 minutes that it builds. If it doesn't, switch to Python with `pty` or `ptyprocess` and the Python MCP SDK. Note that Python is 3.14.5, so check package wheels.
- **Example tool set:** create a session (cwd, env, shell or command), write input (text and special keys), read output from a cursor with pagination and an optional wait timeout, get status (running, exit code, signal), list sessions, and kill a session (process-group kill). Keep output in a bounded ring buffer and reap child processes.
- **Verification:** run a scripted MCP client test covering an interactive process (a Python REPL), a long-running process (a sleep or print loop read incrementally), a kill, concurrent sessions and an exited process. Then ask me to add the server to Manus as a local MCP server, and show a Manus task creating and controlling a session through it.
- **Security:** allowed working-directory roots, filtering or redaction of environment variables, a policy for dangerous commands with an approval path, and a JSONL audit log.
