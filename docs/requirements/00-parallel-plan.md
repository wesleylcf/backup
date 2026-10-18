# Parallel plan for the seven problems

## Verdict

Problems 1 to 6 have no hard dependencies on each other. None of them needs another one's output, code, data or running service, so all six can start at the same time in separate Manus tasks. Problem 7 (promo video) is the only one with a real dependency: its final edit needs the other products to exist. Its script, narration, music and title cards can be prepared in parallel, but the final cut comes last.

The overlaps between problems are conceptual, not code worth sharing. Building a shared foundation first would make every task wait on it, and that coordination costs more than duplicating a few dozen lines. The real constraints are not technical. They are your attention as the only human reviewer and tester, the shared OpenRouter key, the folders and ports on one Mac, and the 4-hour clock.

## Dependency and overlap matrix

| # | Problem | Hard dependency | Overlap with | Shared resources | Where to run | Your hands needed | Effort / risk |
|---|---|---|---|---|---|---|---|
| 1 | Desktop voice input | None | 3, 4 (OpenRouter call for text cleanup) | Mic, Accessibility permission, whichever app is in front, OpenRouter key | Local Mac (required) | High: grant permissions, speak, test in real apps | High |
| 2 | Multiplayer web game | None | 6 (rooms, invite links, reconnect over WebSocket) | Hosting, ports | Local + Manus hosting for a public URL | Medium: play a match on two devices | Medium |
| 3 | Plugin harness | None | 4 (agent loop), 5 (child-process supervision, permissions, audit) | OpenRouter key, ports | Local | Low | Medium |
| 4 | Chrome Side Panel agent | None | 3 (agent loop) | Chrome, OpenRouter key | Local Mac (real Chrome) | Medium-high: load the unpacked extension, test on real sites | Medium-high |
| 5 | MCP terminal server | None | 3 (process lifecycle) | Ports, Manus MCP settings | Local Mac (to connect it to Manus) | Low: add the server to Manus once | Low-medium |
| 6 | P2P encrypted chat | None | 2 (rooms, signaling) | Hosting, STUN/TURN | Local + Manus hosting for a public URL | Medium: two browsers or devices | Medium-high (security claims get scrutinized) |
| 7 | Promo video | Whichever of 1 to 6 it features | All (consumes their demo assets) | Demo assets from every task | Local (ffmpeg 8.1.1 installed) | Medium: screen recordings | Low-medium |

## Why not share code

- **OpenRouter client (1, 3, 4):** about 50 lines, but in three different runtimes (a Swift app, Node, a Chrome MV3 extension). Copy it in each.
- **Agent loop (3, 4):** the same plan, act, observe, recover pattern, but different tools, user interface (UI) and safety rules. Coupling them makes one task wait on the other.
- **Real-time rooms (2, 6):** opposite trust models. The game server should be authoritative and see the full state. The chat server should be blind to message content. A shared server would weaken problem 6's threat-model story.
- **Process supervision (3, 5):** both handle child processes, timeouts, killing process trees, permissions and audit logs. Share the ideas, not the code.

## Optional integrations, only after both sides work

- **5 into 3:** load the MCP terminal server as a third plugin of the harness, through an MCP-bridge plugin. This shows the plugin protocol extending the host with something built independently. Try it in the last hour only if both are already done. Problem 3 must not depend on it.
- **All into 7:** the promo video uses every finished product.

## Shared resources to allocate up front

- **Folders:** one per problem under `/Users/wesley/Documents/manus/`: `p1-voice-input`, `p2-multiplayer-game`, `p3-plugin-harness`, `p4-chrome-agent`, `p5-mcp-terminal`, `p6-p2p-chat`, `p7-promo-video`. Each task works only in its own folder.
- **Ports:** problem N uses 30N0 to 30N9 (p2 uses 3020-3029, p3 3030-3039, p5 3050-3059, p6 3060-3069). No collisions between dev servers.
- **OpenRouter key (used by 1, 3, 4 only):** keep it in an untracked env file and read it from `OPENROUTER_API_KEY`. The Chrome extension takes it from its options page. Never put it in source, zips, logs or screenshots. Cap agent loops with a maximum step count so a runaway loop can't drain the $1,000 limit. The rules allow the key only inside the products, not for development.
- **Promo assets:** each task saves 3 to 5 screenshots, an optional 30 to 60 second screen recording, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/pN/`. Published products also provide their public URL.
- **Your attention:** this is the real bottleneck. Problems 5, 3, 2 and 6 can mostly build and verify themselves. Problems 1 and 4 need you to grant permissions and test by hand.

## Run plan

T is the moment answering started. If that was around 14:30, T+4:00 is about 18:30. Confirm it on the site's countdown, which is the official clock.

| When | What |
|---|---|
| T+0:00 to 0:15 | Start the tasks with the briefs in this folder. Start 5, 3, 2 and 6 first, since they run mostly on their own, then 4 and 1. Keep 7 for later. |
| T+0:15 to 1:30 | Each task builds a working end-to-end version. Use the waiting time for the hands-on steps: permissions for 1, loading the unpacked extension for 4, adding the MCP server to Manus for 5. |
| T+1:30 | Checkpoint: upload whatever works now, since the latest upload is what gets graded. Start task 7's prep: script, narration, music, title cards. |
| T+2:30 | Feature freeze for 1 to 6. Each task writes its acceptance note, packages its zip and saves its promo assets. |
| T+2:45 | Final assembly of 7. Optional 5-into-3 integration if both are done. |
| T+3:30 | Final upload of everything, with published URLs in "Links and notes". |
| T+3:45 | Buffer. Uploads close at T+4:00. |

## If your attention gets stretched

Cut problem 1 first. It needs the most manual testing, carries the most risk from native macOS permissions, and the agent can't verify it end to end because it can't speak into the mic. Cut problem 6 next, since its security write-up will be read closely and it needs care to get right. Keep 7 in any case: it's cheap and reuses everything else.

## Environment check (14:33)

macOS 15.3.1 on Apple Silicon, Xcode 16.4 with Swift 6.1.2, Node 24.3.0, npm 11.4.2, pnpm 7.26.2, Python 3.14.5, ffmpeg 8.1.1, git 2.39.5 and Google Chrome are installed. Nothing has to be installed before starting. Two things to watch:

- **Node 24:** native modules such as `node-pty` may need a source build.
- **Python 3.14:** very new, so some packages may not have wheels yet.
