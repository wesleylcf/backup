# Delivery Audit — P2 multiplayer web game

**Audit time:** 2026-10-18 17:41:17 +08  
**Project audited:** `/Users/wesley/Documents/manus/p2-multiplayer-web-game` only  
**Product:** **SHOVE OFF — sumo on ice**, a server-authoritative Node/WebSocket browser game for 2–4 players.

## Summary verdict

**Overall: NON-COMPLIANT.** The acceptance note requirement **passes**, but Published URLs **fail**: the only concrete public URL is a historical Cloudflare quick-tunnel address that no longer resolves, and no durable deployment URL is written down. This is a hosted-type, real-time multiplayer product, so a source repository or local/LAN instructions cannot substitute for a reachable public game.

Git check: the main checkout is on `main`; `feat/game` is an additional worktree at the same commit (`90056b7`), so the acceptance material below is present in the main checkout, not solely on an unmerged branch. Neither checkout has an `outputs/` directory.

## Acceptance note

**Status: PASS** — `README.md` is lengthy rather than a short standalone acceptance file, but its reviewer-facing sections are accurate and followable.

### Locations and coverage

| Location | What it covers |
| --- | --- |
| `README.md` | **Quick start** at lines 9–16 gives Node >=20, `npm install`, and `npm start`; lines 18–35 give a concrete two-window/two-player review flow and LAN/tunnel/deployment guidance; lines 49–60 describe controls and expected match flow; lines 75–96 document authority/sync/lifecycle; lines 98–118 give test/review commands; lines 132–137 list known limitations. |
| `docs/QA.md` | Supporting QA evidence and a detailed test matrix, including historical LAN and public-tunnel results. It is useful evidence, but not a concise acceptance note. |

### Accuracy and gaps

- **No static command/path mismatch found** in the primary local review flow: `npm start`, `npm test`, `npm run e2e`, `npm run e2e:lag`, `npm run lag-proxy`, and `npm run demo:record` exist in `package.json`; their referenced server/test/script paths exist. The Node >=20 prerequisite matches `package.json` (`engines.node: >=20`). The E2E script does support the documented `--url` form.
- The README gives a clear expected review outcome: create/join by invite, warm-up, ready/start, complete a match, and rematch. It also explains what to try for lifecycle, latency, duplicate/out-of-order handling, and server authority.
- **Published-URL gap:** `README.md` has only localhost/LAN examples, an `https://…` placeholder, and `https://game.example.com` as a reverse-proxy example. It does not state a current, pasteable production URL or a current health URL. The sole concrete public URL appears only as historical QA evidence (`docs/QA.md:67`).
- **Brief-packaging gap:** the original brief requires `outputs/` to contain the published URL and a README acceptance note, yet `outputs/` is absent in both the main checkout and `.worktrees/game/`. Therefore there is no output-folder acceptance note, URL record, or other required output packaging to hand to a reviewer.
- The exact LAN address in `README.md:104` / `docs/QA.md:65` (`192.168.0.13:4317`) is a non-portable prior test environment, not a usable public endpoint. It did not answer at audit time; the command is only conditionally valid when that host has a running server.

## Published URLs

**Status: FAIL** — no publicly reachable deployment of the actual game was found. There is no Git remote and no deployment configuration beyond a Dockerfile. A P2-related file found under `p7-promo-assets` was only `p2/audio/music.mp3`; `/Users/wesley/Documents/manus/promo-assets/` is absent, so neither location supplies a pitch/public URL.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? |
| --- | --- | --- | --- | --- | --- |
| `https://columbus-developers-beings-subtle.trycloudflare.com` | Historical Cloudflare HTTPS/WSS quick-tunnel game URL | `docs/QA.md:67,84`; `docs/evidence/e2e-internet-summary.json:4,10` | `HTTP 000`; `curl: (6) Could not resolve host` | Remote fetch could not resolve hostname to public IPs | **No** — expired/closed ephemeral tunnel |
| `https://columbus-developers-beings-subtle.trycloudflare.com/healthz` | Public form of the documented health route | Tunnel base in `docs/QA.md:67`; health path in `Dockerfile:12` and `server/http.js:55` | `HTTP 000`; DNS resolution failed | Remote fetch could not resolve hostname to public IPs | **No** — the base tunnel is gone |
| `http://localhost:4317` | Local game server | `README.md:13,20,26` | `HTTP 000`; could not connect | Remote fetch rejected it as a local/private host | **No** — loopback only |
| `http://192.168.0.13:4317` | Prior LAN game/test server | `README.md:104`; `docs/QA.md:65` | `HTTP 000`; could not connect | Remote fetch rejected it as a blocked/private IP | **No** — private LAN address |
| `http://127.0.0.1:4317/healthz` | Container-local health check | `Dockerfile:12` | `HTTP 000`; could not connect | Remote fetch rejected it as a blocked/private IP | **No** — loopback only |

The remote checks found no page content to validate as SHOVE OFF because the only public candidate is no longer resolvable. Static identity evidence is present locally (`public/index.html:6` title: `SHOVE OFF — sumo on ice`), but it does not establish public availability.

## Top fixes

1. **Deploy the Node/WebSocket server to a durable public host** that supports persistent WebSocket connections, then verify the root page and `/healthz` from an external network. Do not rely on an expiring `trycloudflare.com` quick tunnel for delivery.
2. **Create `outputs/README.md` as a short acceptance note** and put the exact public game URL and health URL at the top. Include Node prerequisite/local commands, a 5-minute two-device script (create room, copy invite, join, ready/start, play to results, rematch), expected results, and known limitations.
3. **Put the same exact public URL in the project’s Links/notes/pitch material** and preserve the requested `outputs/` deliverables (including the source archive without dependencies/secrets), so the reviewer can paste the URL without searching QA history.

## Other flags

- `docs/QA.md:11` explicitly records **“No permanent hosting (D-012)”**; that aligns with the failed external reachability checks.
- The historical Cloudflare quick tunnel is inherently fragile even when live, and is now unavailable by both local curl and remote fetch.
- The audit did not start servers, install dependencies, build, or run tests. No secret values were inspected or printed. No publicly served secret exposure or unauthenticated dangerous public capability could be assessed because no live public service was reachable.
