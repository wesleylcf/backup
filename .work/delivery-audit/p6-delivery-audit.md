# P6 delivery audit — Veil P2P encrypted chat

**Audit time:** 2026-10-18 17:41:38 +08  
**Scope:** P6 only; static inspection plus URL checks. No project files were changed, and no dependencies, builds, tests, or servers were run.

## Summary verdict

**Compliant.** Both Delivery-rule requirements pass:

- **A — Acceptance note: PASS.** The delivered `outputs/README.md` is a reviewer-followable acceptance note in the main checkout, with a public URL, local run prerequisites/commands, a five-minute two-person review script, server-observation instructions, limitations, and a link to the detailed threat model.
- **B — Published URLs: PASS.** The documented Veil app is reachable from an external fetch service and returns Veil-specific chat/security text. Its documented health endpoint is also externally reachable and healthy. The local machine’s DNS resolver could not resolve the host at audit time; the independent remote check establishes public reachability.

`git worktree list` shows the delivered main checkout at `/Users/wesley/Documents/manus/p6-p2p-chat` on `main`, plus an unmerged/alternate `.worktrees/veil` worktree on `feat/veil`. The acceptance note and the delivered `app/`, `outputs/`, and `docs/` artifacts are present in the **main checkout**, not only in the alternate worktree.

## Acceptance note

### Locations

- `outputs/README.md` — **primary delivered acceptance note**.
- `README.md` — identical duplicate at the main-checkout root (`cmp` confirmed identity).
- Supporting reviewer material: `outputs/THREAT_MODEL.md` and `outputs/proof/PROOF.md`; `docs/QA.md` is a more detailed QA matrix, not the primary acceptance note.

### What it covers

`outputs/README.md` provides all of the practical review content required for a short reviewer guide:

- **How to access/run:** the live URL, plus Node.js 24+/npm prerequisites and valid commands: `cd app`, `npm ci`, `npm run build`, and `npm start`.
- **How to review:** a timed two-person, five-minute flow: create/join with an invite link, exchange messages, compare the 60-digit safety number, simulate/reset an identity key, and inspect **What the server sees**.
- **How to inspect the security boundary:** WebSocket DevTools guidance for `/api/ws`, with the expected opaque `join`, `signal`, and `relay` frames.
- **Known limitations:** code-delivery trust, bearer invite links, per-device removal, peer-dependent catch-up, metadata/IP visibility, six-member/Chrome-tested scope.
- **Published URL/use instructions:** the first line supplies the live URL; the script explains how the first person creates/copies an invite link and the second person joins.

Static accuracy checks passed for the stated commands and key paths: `app/package.json` defines `build`, `start`, `test`, and `e2e`; `app/vite.config.ts` outputs to `dist/public`; `app/server/index.ts` serves that directory and implements `GET /api/health`; `app/tests/e2e/run.mjs` supports `E2E_BASE` and `E2E_VIDEO`; and `outputs/veil-source.zip`, `outputs/THREAT_MODEL.md`, and `outputs/proof/PROOF.md` exist.

### Gaps and inaccuracies

- **Root-copy relative-path mismatch:** because `README.md` is an identical copy of the output note, its `veil-source.zip` reference (line 9) and `proof/PROOF.md` link (line 67) do **not** resolve from the repository root. The corresponding delivered paths do resolve from `outputs/README.md`: `outputs/veil-source.zip` and `outputs/proof/PROOF.md`. This does not block review through the intended output note, but the duplicate root note is misleading.
- **Public-internet WebRTC disclosure could be clearer in the acceptance note:** the note explains direct WebRTC and encrypted relay fallback, but does not explicitly say that direct cross-network connectivity uses STUN, has no TURN service, and may fall back to the relay on restrictive NATs. The linked `outputs/THREAT_MODEL.md` does disclose Google STUN, peer/STUN IP exposure, the 10-second encrypted-relay fallback, and the Hide-my-IP option (`§§2, 5.1–5.2, 6`).

## Published URLs

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? |
|---|---|---|---|---|---|
| `https://veilchat-n3gjdzux.manus.space` | Veil browser chat application | `README.md:3`; `outputs/README.md:3`; `outputs/proof/PROOF.md:7`; `/Users/wesley/Documents/manus/p7-promo-assets/p6/pitch.md:5` | `000 https://veilchat-n3gjdzux.manus.space/` — local `curl` could not resolve the hostname | **Success.** External fetch returned Veil-specific text: “Messages are end-to-end encrypted…” and the passphrase/local-history explanation. | **Yes** |
| `https://veilchat-n3gjdzux.manus.space/api/health` | Documented server health check for the signaling/relay service | `README.md:83` and `outputs/README.md:83` document `GET /api/health`; route confirmed in `app/server/index.ts:78` | `000 https://veilchat-n3gjdzux.manus.space/api/health` — local `curl` could not resolve the hostname | **Success.** External fetch returned `{"ok":true,"bootId":"…","startedAt":"2026-10-18T08:52:22.109Z"}`. | **Yes** |

No additional P6 product deployment URL was found in the scoped README/notes/outputs/docs/configuration scan or the P6 promo folder. The repository has no configured Git remote. Localhost/127.0.0.1 URLs in proof/test material are explicitly local test targets, not published deliverables. Third-party documentation and host-injected analytics URLs were excluded as non-product links.

## Top fixes

1. **Repair or remove the duplicate root `README.md` paths:** change its archive/proof references to `outputs/veil-source.zip` and `outputs/proof/PROOF.md`, or maintain only the delivered `outputs/README.md` copy.
2. **Add one concise NAT/ICE sentence to `outputs/README.md`:** e.g., “Direct WebRTC uses Google STUN (which can reveal your IP to STUN/peers); no TURN is configured, so restrictive NATs use Veil’s encrypted server-relay fallback; use Hide my IP to force that relay.”
3. **Investigate the local DNS discrepancy** for `veilchat-n3gjdzux.manus.space`; public fetch succeeds, but local `curl` returned resolver error 6 for both the app and health URLs during this audit.

## Other flags

- The public page does not expose a credential or invite secret in the inspected documentation/fetch response. The health endpoint exposes only an `ok` flag, boot identifier, and startup time.
- `GET /api/observe/:roomId` is unauthenticated in `app/server/index.ts:79–80`; `Hub.observe()` returns member count and in-memory entries to any holder/guesser of the 128-bit opaque room ID (`app/server/hub.ts:61–65`). It is intentionally used by the “What the server sees” reviewer feature and does not return plaintext by design, but it is a public metadata-observation surface worth an explicit security review.
- `outputs/THREAT_MODEL.md:108–121` records that the hosting gateway injects analytics/editor scripts. The project claims a runtime CSP lock blocks their network egress, but the threat model correctly retains malicious code delivery/host control as a limitation. This is a product-security caveat, not a Delivery-rule failure.
