# P1 desktop voice input — Delivery audit

**Audit time:** 2026-10-18 17:42:21 +08  
**Project audited:** `/Users/wesley/Documents/manus/p1-voice-input` only  
**Product type:** Native Swift/AppKit macOS menu-bar voice-input application.

## Summary verdict

**Non-compliant.** Both scoped delivery requirements fail in the delivered **main** checkout:

- **A — Acceptance note: FAIL.** `main` (`f8e2cfa`) tracks only `.gitignore` and `README.md`; the three-line root README is not a reviewer acceptance guide. The fuller guide and QA material exist only in the separate, unmerged `feat/murmur` worktree, not in the main checkout.
- **B — Published URLs: FAIL.** No public download, public repository/release, landing/demo page, or product URL is documented in `main`, its Git remote list is empty, and the sole product-associated GitHub URL found in the unmerged worktree was not verifiable as a reachable Murmur product.

`git worktree list` showed the main checkout on `main` and `/Users/wesley/Documents/manus/p1-voice-input/.worktrees/murmur` on `feat/murmur`. `feat/murmur` is **not merged into main**.

## Acceptance note

**Status: FAIL**

### Locations checked

| Location | Main-delivery status | What it covers |
|---|---|---|
| `README.md:1-3` | Present in `main`; **not an acceptance note** | Title plus “Work in progress. See PLAN.md for live execution state.” No prerequisites, run instructions, review script, expected results, limitations, or product URL. |
| `.worktrees/murmur/README.md:1-112` | Exists only on unmerged `feat/murmur`; **does not count as main delivery** | Strong install/onboarding/use/privacy/limitations material. It includes build/run commands and what the global shortcut should do. |
| `.worktrees/murmur/QA.md:1-111` | Exists only on unmerged `feat/murmur`; **does not count as main delivery** | Detailed test matrix and manual test ideas, but it is a QA status report rather than a concise reviewer acceptance note. |
| `outputs/README.md`, `outputs/*ACCEPT*`, `docs/**`, `ACCEPTANCE*.md`, `QA.md` in `main` | Absent | No further main-checkout candidate was found. `main` has no `outputs/` directory. |

### Findings, gaps, and static accuracy

1. **No reviewer-followable note exists in main.** The root `README.md` neither explains installation/run nor provides a short review journey with expected outcomes. It also has no known-limitation section or published product URL.
2. **Main README has a concrete broken reference:** `README.md:3` says “See `PLAN.md`,” but `PLAN.md` is not in `main` (the final main tree contains only `.gitignore` and `README.md`).
3. The unmerged feature README would be **partial at best** if it were delivered as-is: it states macOS/Xcode/OpenRouter-key prerequisites (`.worktrees/murmur/README.md:5-11`), build/open commands (`:13-19`), setup permissions (`:21-35`), how to use the shortcut and expected behavior (`:37-60`), and known limitations (`:105-111`). However, it has no concise, end-to-end five-minute reviewer script that names the key checks and pass criteria across apps.
4. The feature README’s clone command is not actionable: `.worktrees/murmur/README.md:16` uses `git clone <this repo>` rather than a real URL. `git remote -v` returned no remote, so there is no public source location to substitute.
5. There is a static documentation inconsistency within the unmerged worktree: README `:92` labels `scripts/test.sh` as “70 unit tests,” while QA `:10` records “Unit 92/92.” The referenced scripts and source/test directories do exist in the feature worktree, but this count should be reconciled before using the guide.
6. No candidate note records a public download/repository/release URL. The guide instructs reviewers to supply their own OpenRouter API key; it provides an OpenRouter key-creation link, not a product link.

## Published URLs

**Status: FAIL.** A native macOS app has a sensible public delivery form: a public source repository with a public GitHub Release (or equivalent) containing a built `.app` archive/DMG/ZIP, optionally supported by a landing page. No such published deliverable was found.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public? |
|---|---|---|---|---|---|
| `https://github.com/murmur-voice-input` | A purported GitHub presence, used as the OpenRouter HTTP `Referer`; not a specific repo/release/download URL | Only in unmerged `feat/murmur`: `Sources/MurmurCore/OpenRouterClient.swift:57` and `SPEC.md:73`; not in `main` README or a reviewer note | `curl -L --max-time 20` returned `000`; local DNS could not resolve `github.com` | Remote `fetch` returned an extraction **error** (“No markdown content extracted”); it did not verify a public Murmur page, repository, release, or app artifact | **No** — unverified and, even if a profile existed, it is not a documented product delivery URL |

Additional URL search results were OpenRouter API/key links and an Apple plist DTD. These are third-party service/documentation URLs, not published locations for Murmur, so they were not treated as product URLs. The `p1` pitch-file search found no P1/Murmur reference under `/Users/wesley/Documents/manus/p7-promo-assets/`; `/Users/wesley/Documents/manus/promo-assets/` was absent.

## Top fixes

1. **Publish the macOS deliverable.** Create a public repository/release for Murmur and attach a built, downloadable `.app` ZIP or DMG (and source, if desired). Confirm the release URL works from a non-local network.
2. **Put the finished work on the delivered branch.** Merge or otherwise deliver the actual app, documentation, and intended package from `feat/murmur` to `main`; the current main checkout contains no product source or artifacts.
3. **Add a concise acceptance note in the delivered checkout** (for example `outputs/ACCEPTANCE.md` or a revised root README). Include: exact prerequisites; install/open steps; Microphone and Accessibility permissions; a five-minute review script (Notes plus another supported text field, shortcut, cancel, copy fallback); expected results; known limitations; the exact public release/repo URL; and the fact that a reviewer needs their own OpenRouter key without exposing any key.
4. **Correct the guide before publishing.** Replace `git clone <this repo>` with the real public repo URL, reconcile the 70-versus-92 test count, and remove/fix the root README’s nonexistent `PLAN.md` reference.

## Other flags

- The main checkout is clean but materially incomplete: `git ls-tree -r main` lists only `.gitignore` and `README.md`. The implementation, full docs, and current `dist/Murmur.app` were observed only in the unmerged worktree. This is a delivery-integrity concern independent of the scoped packaging mechanics.
- No product page was publicly reachable for a content/security inspection. No secret values were read, copied, or printed during this audit. The unmerged guide requires a reviewer-provided OpenRouter API key; any future public instructions should keep that requirement explicit and never include a shared secret.
