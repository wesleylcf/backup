# P5 MCP terminal server — Delivery audit

**Audit time:** 2026-10-18 17:43:22 +08  
**Scope:** Delivery rule points (A) acceptance note and (B) public published URL only. Static inspection plus URL checks; no project files, dependencies, builds, tests, or servers were changed or run.

## Summary verdict

**Non-compliant.** The main checkout has a useful but incomplete acceptance note (**A: partial**). There is **no currently reachable, documented public delivery** of this local MCP/CLI product (**B: fail**). A local npm tarball and source zip exist in `outputs/`, but they are not a public npm package, public release, or public repository. The only real tunnel URL found was a temporary validation tunnel and is gone.

`main` and `feat/termctl` point to the same commit (`145d49c`), so the note described below is in the deliverable main checkout, not only an unmerged worktree. No Git remote and no deployment manifest were configured. `promo-assets/p5/` is absent; the inspected `p7-promo-assets/` contains no P5 delivery URL.

## Acceptance note

### Locations and coverage

| Location | Main checkout? | What it covers |
|---|---:|---|
| `outputs/DELIVERY.md` | Yes | Product description; local tarball installation; stdio and localhost HTTP connection; temporary-tunnel instructions; evidence inventory; test reproduction; security summary; limitations. |
| `README.md` | Yes | Node/macOS/zsh prerequisites; local build/run; MCP client configuration; tool reference; security model; verification and known limitations. |
| `QA.md` | Yes | Detailed test matrix, expected outcomes, and evidence locations. |

`outputs/DELIVERY.md` is clearly intended as the acceptance/delivery note. It links a reviewer to the source README and QA material, covers how to run locally, and accurately identifies the package, source archive, and listed evidence files that are present. The commands `termctl doctor`, `config`, `serve`, `token`, `approve`, and `dashboard` are implemented by the CLI; the package archive contains the CLI and README; and `npm test` is a real package script.

### Gaps and inaccuracies

**Status: partial.** The note is not yet a short, fully followable acceptance path for a fresh reviewer.

- `outputs/DELIVERY.md:20` says `npm install -g ./termctl-0.1.0.tgz`, but from the project root the file is actually `outputs/termctl-0.1.0.tgz`. The command works only if the reviewer first changes to `outputs/`, which is not stated.
- `outputs/DELIVERY.md:49–53` asks a reviewer with an “extracted, built checkout” to run `node examples/demo.mjs`, but the supplied source archive contains TypeScript source and no `dist/` directory. It does not give the required `npm ci && npm run build` preparation for that path.
- `README.md:25`, which is included in `termctl-source.zip`, likewise refers to `./termctl-0.1.0.tgz`. That tarball is not inside the source archive; it is a sibling file in `outputs/` of this checkout.
- `QA.md:45` says the demo script is at `outputs/scripts/demo.mjs`; no `outputs/scripts/` exists. The actual script is `.work/scripts/demo.mjs`, while the source archive supplies `examples/demo.mjs`.
- `QA.md:4` says Q-13/Manus is passing, but the stale line at `QA.md:5` still says “Manus client: PENDING.”
- The delivery note does not state its prerequisites (at least macOS, Node 20+, and zsh), and it has no concise 5-minute reviewer script that tells a reviewer which tool calls to make and what output/state to expect. The extensive README/QA information is useful, but it is not distilled into a reviewer-oriented run-and-review sequence.
- It has no actual published URL. It only gives a `https://<random>.trycloudflare.com/mcp` template and instructs the reviewer to create their own tunnel. That is not a reviewable product URL written in Links/notes.
- The original brief requested an `outputs/README.md` acceptance note. The delivered note is `outputs/DELIVERY.md`; the different name is not fatal to point A, but it increases discoverability risk.

## Published URLs

The product is inherently local: a suitable public delivery would be a public npm package, public source repository/release, or (less preferably for terminal control) a protected remote MCP endpoint. None was documented as a live deliverable.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? |
|---|---|---|---|---|---:|
| `http://127.0.0.1:3051/mcp` | Local Streamable HTTP MCP endpoint | `outputs/DELIVERY.md:31`; `README.md:19,50` | `000`; curl error 7, could not connect | Fetch executor rejected loopback as a blocked/private IP | No — loopback, and no listener was running during audit |
| `https://<random>.trycloudflare.com/mcp` | Illustrative temporary Cloudflare tunnel endpoint | `outputs/DELIVERY.md:33`; `README.md:58,62`; `outputs/evidence/manus-validation.md:9` | Not runnable: placeholder, not a hostname | Not runnable: placeholder, not a hostname | No — a template, not a published URL |
| `https://printing-inside-florist-ebony.trycloudflare.com/mcp` | Historical Cloudflare quick-tunnel hostname | `.work/tunnel.log:5` (validation log); the evidence note says the tunnel was stopped | `000`; curl error 6, hostname no longer resolves | Fetch could not resolve the hostname to public IPs | No — expired/stopped ephemeral tunnel |
| `https://manus.im/app/TiwcMXSs7gXdXaj5igYyfg` | Manus validation task, not the product | `outputs/evidence/manus-validation.md:10` labels it private | `000`; local device could not resolve external DNS during this check | Page says “No access to collaborate”; it is an access wall, not termctl delivery | No — private evidence record |
| `https://www.npmjs.com/package/termctl/v/0.1.0` | Public npm publication check derived from `package.json` name/version; not written in project notes | Not documented; `package.json:2–3` declares `termctl` `0.1.0` | `000`; local device could not resolve external DNS during this check | No extractable package content; public-web search found no matching `termctl` 0.1.0 publication associated with this project | No confirmed public package or product URL |

The local device had external-DNS failures for non-loopback URLs, so the independent remote-fetch outcomes are the public-internet checks. The remote results confirmed that the private Manus record cannot be reviewed publicly and the historical tunnel hostname no longer resolves. The evidence note itself states that the tunnel and server were stopped, the token rotated, and the former public URL returned an error.

**Published URL status: fail.** There is no live hosted endpoint, public package, public release, or public repository URL documented for this project. The local tarball at `outputs/termctl-0.1.0.tgz` is an artifact, not an Internet-reachable publication.

## Top fixes

1. **Publish a stable public form suitable for a local MCP/CLI server.** Publish `termctl@0.1.0` (or a corrected version) to npm, or create a public GitHub/GitLab repository with a release containing the tarball/source. Put the exact package, repository, or release URL in the acceptance note and Links/notes.
2. **Add `outputs/ACCEPTANCE.md` (or replace/rename `DELIVERY.md`) with a five-minute reviewer flow.** State macOS/Node 20+/zsh prerequisites; use the correct archive-relative path (`cd outputs` then install, or `npm install -g ./outputs/termctl-0.1.0.tgz`); give a real MCP client configuration; list 3–5 exact calls to try and expected results; then state limitations and the public delivery URL.
3. **Correct the static documentation mismatches.** Fix the two tarball paths, either include the demo where QA claims it is or update QA to its actual location, replace the stale Q-13 “PENDING” line, and give explicit build steps before any source-archive demo command.
4. **If exposing a remote MCP endpoint instead of only publishing a package, make it deliberately protected.** Keep bearer authentication mandatory, do not publish its token, restrict allowed directories, retain the local-only approval surface, and document safe reviewer access. Do not rely on an unprotected or ephemeral tunnel as the sole delivery.

## Other flags

- **Security:** This product controls terminal sessions. The reviewed implementation and documentation describe bearer-token authentication for public hosts, localhost-only dashboard/approval routes, and token rotation after tunnel use. No live public endpoint was found, and no secret value was copied into this audit. A valid public endpoint plus its bearer token would allow terminal command execution, so publishing one without durable access controls would be high risk.
- **Temporary validation is not delivery:** `outputs/evidence/manus-validation.md` records a successful past tunnel test, but explicitly says the tunnel was stopped and the token invalidated afterward. That is useful evidence, not a product URL reviewers can use.
- **No public release plumbing found:** `git remote -v` produced no remote; there are no Docker/Fly/Render/Vercel/Netlify/Wrangler/Procfile deployment manifests in the main checkout. This supports the conclusion that no public delivery location is configured or written down.
