# P4 Chrome Side Panel agent — Delivery audit

**Audit time:** 2026-10-18 17:40:18 +08  
**Scope:** Delivery rule points (A) acceptance note and (B) published URLs only. Static inspection and network checks only; no project code, builds, tests, services, or project files were changed.

## Summary verdict

**Overall: non-compliant.** The project has substantial reviewer documentation, so the acceptance-note requirement is **partial**, but it has **no verified public product delivery URL**. An MV3 extension has a sensible public-delivery form—a Chrome Web Store listing, public release/download of the unpacked extension, or public source repository—but none was found or verified. Under the rule, B therefore fails and makes the overall result non-compliant.

The audited product is **Pilot**, an MV3 Chrome Side Panel page-assistant extension. It accepts natural-language browser tasks, displays plans/progress, requests confirmation for externally consequential actions, and uses runtime per-site permissions.

## Acceptance note

**Status: partial.**

### Locations and coverage

| Location | Status in main checkout | What it covers |
|---|---|---|
| `outputs/README.md` | Present; byte-identical to root `README.md` | Installation/unpacked-extension loading, build command, API-key prerequisite, permission model, safety behavior, product behavior, known limits, and development commands. This is the only reviewer note placed directly with the output artifacts. |
| `README.md` | Present | Same content as `outputs/README.md`; source-level install/run guidance and a feature/safety description. |
| `QA.md` | Present and included in `outputs/pilot-source.zip` | Detailed manual review section at lines 84–100: setup, seven concrete checks (Wikipedia lookup, local form submission/decline, settings, tab switch), expected outcomes, and limitations. |

`git worktree list` shows the delivery checkout is `main` at `b5a6a58`, and the only other worktree (`feat/agent`) points at the same commit. The documents above are in the **main checkout**, not only on an unmerged branch or inside `.worktrees/`.

### Gaps

- The deliverable-side `outputs/README.md` is a long product/developer README rather than a short, reviewer-focused acceptance note. It does **not itself provide a concise 5-minute review script** with ordered tasks and expected results.
- The concrete review script is instead in the separate `QA.md` (estimated **about 10 minutes**), which is included in the source zip but is not directly supplied beside the prebuilt extension zip. `outputs/README.md` merely lists `QA.md` among project documents; it does not tell a prebuilt-zip reviewer to open the source zip for it.
- The README gives install/build directions and `QA.md` gives review steps, but no single output-side document joins prerequisites, exact install, review checks, expected results, known limitations, and any publication URL.
- Neither note records a public product URL. The only URL intended for manual form review is `localhost`, which is explicitly local and not a publication location.

### Static accuracy checks and mismatches

- `README.md:102–111` commands match real scripts/files: `build`, `typecheck`, `test`, `test:e2e`, and `fixtures` exist in `package.json`; the cited `scripts/*.mjs` and fixture server exist. `QA.md:25–35` similarly cites existing scripts, test sources, and screenshot directory. Both README and QA are present in the source zip.
- The unpacked extension archive is structurally loadable: `outputs/pilot-extension.zip` contains `manifest.json` at archive root plus the compiled extension files. `outputs/pilot-source.zip` includes `README.md`, `QA.md`, `package.json`, `scripts/build.mjs`, and `tests/fixtures/server.mjs`.
- **Path ambiguity:** root `README.md:11` says to unzip `pilot-extension.zip`, but that file exists at `outputs/pilot-extension.zip`, not project root. The identical `outputs/README.md` is adjacent to the file and is therefore correct when read from the outputs folder; the root copy should use the `outputs/` path or say that it is the output-folder copy.
- **Stale internal documentation:** `README.md:95` says “53 tests,” while `QA.md:11` and `QA.md:64` report 57/57 unit tests. `QA.md:3` calls `7d43297` the release commit, whereas the delivered main checkout HEAD is `b5a6a58` (a later documentation commit). These discrepancies reduce reviewer confidence, even though they do not invalidate the existing commands.
- `dist/` and `dist-test/` are absent at audit time. This is not a command mismatch: the note says the build command generates `dist/`; no build was run because this audit is static-only.

## Published URLs

**Status: fail.** No Chrome Web Store listing, public release/download, public repository remote, hosted landing/demo, or deployment configuration was documented or verified. `git remote -v` returned no remotes. No Docker, Fly, Render, Vercel, Netlify, Wrangler, Procfile, Manus, or WebDev deployment config was present. The permitted promo search found no P4 pitch files: `/Users/wesley/Documents/manus/promo-assets/` is absent and `/Users/wesley/Documents/manus/p7-promo-assets/` contains only P6 files.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? |
|---|---|---|---|---|---|
| `http://localhost:3040` | Local fixture server for manual tries | `README.md:109` | `000 http://localhost:3040/` — connection refused; no service was started by this audit | Fetch rejected it as a local/private host | No |
| `http://localhost:3040/form` | Local fixture form for QA | `QA.md:89` | `000 http://localhost:3040/form` — connection refused; no service was started by this audit | Fetch rejected it as a local/private host | No |
| `https://github.com/pilot-chrome-agent` | HTTP `referer` value sent to the model provider; the only project-branded non-local URL found in source | `src/agent/llm.ts:80`; not in a reviewer note | `000 https://github.com/pilot-chrome-agent` — local DNS resolution failed | Remote fetch returned “no markdown content extracted”; a follow-up fetch of GitHub’s public-user endpoint returned the same error. Public web discovery found no matching Pilot project, only unrelated products. | No verified public product |

The remaining HTTP(S) URLs are third-party resources or test destinations—not Pilot publication links—and were excluded from the table: OpenRouter, Wikipedia, prior-art GitHub projects, HN, Playwright documentation, and a runtime-host-permission article. Source URLs also include OpenRouter’s API endpoint and test localhost URLs, none of which delivers Pilot.

For this inherently local browser extension, a sensible passing public deliverable would be one of: a Chrome Web Store listing; a public GitHub/GitLab repository with `outputs/pilot-extension.zip` or a public release asset; or a stable public download/landing page that clearly provides the extension and install instructions. The local `outputs/pilot-extension.zip` is not reachable from the public internet.

## Top fixes

1. **Publish the extension now:** upload `outputs/pilot-extension.zip` to a public GitHub Release (or publish a Chrome Web Store listing) and verify the public URL without login. A public repository with the output artifact/release is an appropriate delivery form for this extension.
2. **Add `outputs/ACCEPTANCE.md`:** make it a short reviewer guide containing the permanent public URL, Chrome/version and OpenRouter-key prerequisite, exact unzip/Load unpacked steps, a 5-minute review script with expected results, safety/permission checks, and known limitations. Put the same URL in the submission Links and notes.
3. **Make the documentation self-consistent:** update the root README’s prebuilt path, reconcile the 53-versus-57 test count and release commit, and either embed the manual review script in the output-side acceptance note or explicitly point the reviewer to the source zip’s `QA.md`.
4. **Replace or remove the unverified GitHub referrer** at `src/agent/llm.ts:80` unless that account/repository is actually created and published; if it is the canonical project page, use its complete public repository URL and document it in the acceptance note.

## Other flags

- No public page or download was available to inspect for secret exposure or unauthenticated dangerous capability. The checked notes use an `OPENROUTER_API_KEY=…` placeholder rather than a literal key, and the project’s potential-secret filename check returned no files; no secret exposure was observed in this scope.
- The two local URLs are deliberately local test fixtures and were not running during the audit. They cannot satisfy publication even if running.
- The GitHub-branded URL is embedded only as an OpenRouter HTTP referrer, not as a documented delivery link, and could not be verified as a live public Pilot project.
