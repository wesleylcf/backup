# P3 Plugin Harness — Delivery Audit

**Audit time:** 2026-10-18 17:40:16 +08  
**Scope:** Delivery rule only — acceptance note and published public URL(s). Static inspection plus the required network checks; no project files were modified and no app/test was run.

## Summary verdict

**Non-compliant.** The main checkout includes a substantial, reviewer-followable acceptance note, but it is **partial** because its test-count claims are stale/internally inconsistent. **No product publication exists:** the only product address written down is a loopback-only, tokenized local-dashboard example, and there is no Git remote, release/repository link, hosted docs/landing page, or deployment configuration. Per the rule, a failed published-URL requirement with nothing published makes the overall verdict non-compliant.

| Requirement | Status | Basis |
|---|---|---|
| A. Acceptance note | **Partial** | `README.md` and the delivered `outputs/README.md` are byte-identical and give prerequisites, exact commands, expected outcomes, protocol guidance, and limitations. However, the 264-line developer README is not short, and its `npm test` 59/59 assertions conflict with `outputs/evidence/npm-test.txt` (75 passing) and `QA.md` (72/72). |
| B. Published URLs | **Fail** | No public product/repo/release/docs URL was found. The only product URL is loopback-only and was not reachable locally at audit time; remote fetch correctly rejected it as a private IP. |

## Acceptance note

### Locations and checkout status

- `README.md` — main checkout acceptance/reviewer guide.
- `outputs/README.md` — delivered acceptance note; byte-identical to `README.md`.
- `QA.md` — supporting QA/test matrix, not a concise acceptance note.
- `outputs/evidence/` — referenced proof artifacts, including screenshots, transcripts, and the independent review.

`git worktree list --porcelain` reported only `/Users/wesley/Documents/manus/p3-plugin-harness` on `refs/heads/main`; `git branch -a` reported only `main`. There is no note confined to an unmerged branch or a separate `.worktrees/` checkout.

### What the note covers

The note is unusually comprehensive and reviewer-focused in its relevant portions:

- **Prerequisites and run:** Node >=22.13, optional Deno >=2, optional OpenRouter key, `npm link`/`node bin/harness.js`, and state/workspace details (`README.md:17-27`).
- **Review:** `npm test`, `bash scripts/e2e.sh`, optional live LLM check, then a copy/paste CLI walkthrough with stated expected outcomes for no-provider behavior, install/inspect/enable, grants, audit denial, crash containment, timeout, permission denial, revocation, and the dashboard (`README.md:29-71`).
- **Key brief requirements:** explicit plugin protocol and first-plugin workflow (`README.md:97-166`), process isolation/failure behavior, permissions, and the local dashboard flow.
- **Known limitations:** a dedicated limitations section, including weaker Node fallback isolation, unsandboxed `exec` plugins, no remote registry, CPU limits, and platform caveats (`README.md:217-227`).
- **Static command/path check:** `package.json:7-10` defines `test`, `e2e`, and `serve`; referenced `bin/harness.js`, `scripts/e2e.sh`, `SPEC.md`, `examples/plugins/py-text-stats/main.py`, `test/`, and `src/web/server.js` exist. Static CLI dispatch confirms the documented `doctor`, `catalog`, `install`, `inspect`, `enable`, `config`, `permissions`, `call`, `cmd`, `run`, `validate`, `create`, `dev`, and `serve` commands.

### Gaps and inaccuracies

1. **Stale/inconsistent test totals (all found mismatches):**
   - `README.md:13` and `README.md:263` (and therefore `outputs/README.md:13,263`) claim `npm test` **59/59**.
   - The delivered transcript `outputs/evidence/npm-test.txt:81-83` instead records **75 tests / 75 pass**.
   - `QA.md:9` and `QA.md:55` instead claim **72/72**. The acceptance note should cite a single current result or omit the hard count.
2. **Not a short note:** the delivered note is 264 lines and combines reviewer instructions with extensive product design, architecture, security, and independent-review material. Its review section is good, but a short reviewer entry point would be clearer.
3. **No publication information:** both note copies give only `http://127.0.0.1:3030/?token=...` (`README.md:68`; `outputs/README.md:68`). It is a per-session local URL, not a documented public deliverable. There are no hosted-review instructions or public URL(s) to paste into Links and notes.

No other run-command, referenced-path, port, or output-artifact mismatch was found by static inspection.

## Published URLs

Project URL discovery covered README/QA/docs/outputs/configuration material, Git remotes, and the allowed P3 pitch material in `/Users/wesley/Documents/manus/p7-promo-assets/p3/`. The only non-product links found were third-party Node/security sources, OpenRouter API calls in evidence, and GitHub npm release notes; they are not publication locations for this product and are omitted from the table. `git remote -v` returned no remote, and no Docker/Fly/Render/Vercel/Netlify/Wrangler/Procfile/Manus deployment configuration was present.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? | Notes |
|---|---|---|---|---|---|---|
| `http://127.0.0.1:3030/?token=...` | Example per-session local Plugin Harness dashboard | `README.md:68`; `outputs/README.md:68` | `curl -sS -L --max-time 20` -> `HTTP 000`; connection refused; effective URL unchanged | Remote `fetch` rejected the target: resolves to a blocked/private IP | **No** | `src/web/server.js:1,114-115` intentionally binds only to `127.0.0.1`; the token is generated per session. It cannot be used as a public review/deployment URL. |

### Findings

- This is inherently a **local Node CLI/harness with an optional local UI**. A sensible public deliverable would be a public GitHub/GitLab repository or public release/source archive with the reviewer guide, and optionally public docs/landing page or a demo explaining the local workflow. None exists.
- The local source zip at `outputs/plugin-harness-src.zip` is an on-disk artifact, not a public release URL.
- No public URL is written in the acceptance note, pitch (`/Users/wesley/Documents/manus/p7-promo-assets/p3/pitch.md`), Git remotes, or deployment configs.
- Since there is nothing publicly hosted, no public page could be content-verified as the Plugin Harness product.

## Top fixes

1. **Publish the deliverable:** create a public repository or public release/download page for the source ZIP (appropriate for this local CLI/harness), or publish public docs/landing page that links to it. Record the stable public URL in the submission Links and notes.
2. **Add a short `outputs/ACCEPTANCE.md` (or make `outputs/README.md` concise at the top):** state prerequisites, exact install/run commands, a 5-minute review script with expected results, limitations, and the public repo/release/docs URL. Keep the longer technical README as supporting documentation.
3. **Reconcile verification claims:** update both README copies and `QA.md` to a single evidenced `npm test` count (the current delivered transcript says 75/75), or replace fragile totals with a dated command/result reference.
4. **State the local-vs-public distinction explicitly:** retain the 127.0.0.1 dashboard instructions for runtime review, but do not present its per-session token URL as the publication link.

## Other flags

- No exposed secret value was printed or found in the audited note/pitch material. The README uses a placeholder API-key string, not a live credential.
- No public product page exists to assess for publicly exposed secrets or unauthenticated dangerous capabilities.
- The local dashboard is deliberately loopback-bound and token-protected (`src/web/server.js`); this supports its local-security design but confirms it is not a deployment.
