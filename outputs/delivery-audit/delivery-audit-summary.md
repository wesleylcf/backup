# Delivery compliance audit: acceptance note and published URLs

**Audit time:** 2026-10-18, 17:40–17:45 (+08). Other tasks were still working in these folders, so this is a snapshot.
**Scope:** p1 to p7 under `/Users/wesley/Documents/manus`. Upload mechanics were ignored. The audit was read-only: nothing was installed, built or started, and no project files were changed.

## What was checked

**(A) Acceptance note.** Is there a short note in the delivered checkout (the main branch, not an unmerged worktree) that tells a reviewer the prerequisites, how to run the product, how to review it and what result to expect? Are its commands and paths real?

**(B) Published URL.** Is the product deployed or published somewhere the public internet can reach, and is that URL written down so it can go into "Links and notes"? Each URL was fetched from a remote server, which is the real public test. A local `curl` was also run, but this Mac's sandboxed shell couldn't resolve external DNS, so the local results don't count either way. Localhost, LAN addresses, expired tunnels and private repos count as not public.

## Scoreboard

| Project | Acceptance note | Published URL | Overall |
|---|---|---|---|
| p1 voice input (Murmur, macOS app) | **Fail** | **Fail** | Non-compliant |
| p2 multiplayer game (SHOVE OFF) | Pass | **Fail** | Non-compliant |
| p3 plugin harness | Partial | **Fail** | Non-compliant |
| p4 Chrome agent (Pilot) | Partial | **Fail** | Non-compliant |
| p5 MCP terminal (termctl) | Partial | **Fail** | Non-compliant |
| p6 P2P chat (Veil) | Pass | **Pass** | **Compliant** |
| p7 promo video | **Fail** | **Fail** | Non-compliant |

## Main findings

1. **Only p6 is published.** `https://veilchat-n3gjdzux.manus.space` and its `/api/health` endpoint both load from the public internet and are written in `p6-p2p-chat/outputs/README.md`. No other project has a working public URL, and none of the six repos has a git remote.
2. **Two "public" URLs have expired.** p2 and p5 were each tested over a temporary Cloudflare tunnel (`*.trycloudflare.com`). Both hostnames no longer resolve, so neither project has anything a reviewer can open now.
3. **p1's main branch is effectively empty.** `main` (commit `f8e2cfa`) holds only `.gitignore` and a three-line `README.md`, which points to a `PLAN.md` that doesn't exist. The app source, the full README, QA.md and the built `dist/Murmur.app` are all on the unmerged `feat/murmur` branch in `.worktrees/murmur`.
4. **p7 has no project folder.** `p7-promo-video/` doesn't exist, so there is no `outputs/`, no README and no published video. There is a 1080p, 72-second video at `p7-promo-assets/p6/veil-promo.mp4`, but it isn't delivered or published as p7.
5. **The partial notes share the same problems.** They are long developer READMEs rather than short reviewer notes, they have no public URL, and their test counts are stale: p1 says 70 tests vs 92/92 in QA; p3 says 59/59 vs 72/72 in QA vs 75/75 in the evidence; p4 says 53 vs 57/57. Some paths are also wrong:
   - p4's root README points to `pilot-extension.zip`, which is under `outputs/`.
   - p5's `DELIVERY.md` uses `./termctl-0.1.0.tgz` and a demo that needs a build step it doesn't mention.
   - p5's QA names a nonexistent `outputs/scripts/demo.mjs`.
   - p6's root README links root-relative paths that only work from `outputs/`.

## Fixes, by project

**p1 voice input.** Merge `feat/murmur` into `main`, or deliver from that branch. Publish a public GitHub repo with a Release that has `Murmur.app` zipped or as a DMG. Add `outputs/ACCEPTANCE.md` covering: install and open, granting mic and Accessibility permissions, the reviewer's own OpenRouter key, a 5-minute review script with expected results, limitations, and the release URL. Replace `git clone <this repo>` with the real URL and fix the test count and the `PLAN.md` reference.

**p2 multiplayer game.** Deploy the Node/WebSocket server to a lasting public host that keeps WebSockets open. The plan intended Manus hosting; Fly or Render would also work. Check `/` and `/healthz` from outside. Add a short `outputs/README.md` with the public URL and the two-device invite, join, play and rematch steps. The current README is already good enough to base it on.

**p3 plugin harness.** Publish a public repo or Release with the source zip. Add a short `outputs/ACCEPTANCE.md`, or a top section in `outputs/README.md`, with run and review steps and the URL. Make the test counts agree. Make clear that the `127.0.0.1:3030` dashboard link is local only.

**p4 Chrome agent.** Publish `outputs/pilot-extension.zip` in a public GitHub Release. A Chrome Web Store listing is unlikely to be approved in time. Add `outputs/ACCEPTANCE.md` with the URL, the unzip and Load unpacked steps, the API-key setup, and a 5-minute review taken from QA.md. Fix the zip path, the 53 vs 57 test count and the release commit hash (QA says `7d43297`, HEAD is `b5a6a58`). Either remove the unverified `github.com/pilot-chrome-agent` referrer or make it the real repo.

**p5 MCP terminal.** Publish to npm and/or a public repo with a Release. Rename or extend `outputs/DELIVERY.md` into an acceptance note (the brief asked for `outputs/README.md`). It needs prerequisites, correct tarball paths, exact MCP calls with expected results, and the public URL. Don't use an unprotected or temporary tunnel as the public URL: anyone holding the token could run terminal commands.

**p6 P2P chat.** It meets the rule. Optional fixes: correct the root README's relative links, and add one line to the acceptance note explaining that there is STUN but no TURN, that restrictive networks fall back to the encrypted relay, and that "Hide my IP" forces the relay. Note that `/api/observe/:roomId` shows room metadata, without needing a login, to anyone who has the room ID. This is intentional for the reviewer view.

**p7 promo video.** Create `p7-promo-video/outputs/` containing the final MP4 and a short README listing the products featured and how the video was made. Upload the video to a public, no-sign-in host such as an unlisted YouTube video, Vimeo, or a publicly hosted MP4, and put the link in the README and in "Links and notes". Don't show the invite link fragment from the p6 transcript in any public video material.

## Publishing safety check

`p1-voice-input/.env` and `p3-plugin-harness/.env` are both covered by their `.gitignore`, so pushing those repos to a public remote won't publish the OpenRouter key. Check any release zips separately before uploading them.

## Per-project reports

- [p1 voice input](projects/p1-delivery-audit.md)
- [p2 multiplayer game](projects/p2-delivery-audit.md)
- [p3 plugin harness](projects/p3-delivery-audit.md)
- [p4 Chrome agent](projects/p4-delivery-audit.md)
- [p5 MCP terminal](projects/p5-delivery-audit.md)
- [p6 P2P chat](projects/p6-delivery-audit.md)
- [p7 promo video](projects/p7-delivery-audit.md)
