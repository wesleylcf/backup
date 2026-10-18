# Reviewer guide

This folder holds seven independent projects. Each one has its own short acceptance note, `ACCEPTANCE.md`, that explains how to run it and how to review it, with published URLs under **Links and notes**. Start here to pick a project, then open its note.

## The projects

| # | Product | What it is | Try it without installing | Acceptance note | Review time |
|---|---|---|---|---|---|
| p1 | **Murmur** | macOS menu-bar voice input: tap Right ⌥, speak, and clean text appears at the cursor in any app. | Download the app from https://murmur-cb4tw5gd.manus.space | [p1-voice-input/.worktrees/murmur/ACCEPTANCE.md](p1-voice-input/.worktrees/murmur/ACCEPTANCE.md) ¹ | 5 min |
| p2 | **SHOVE OFF** | Real-time multiplayer sumo-on-ice browser game for 2–4 players, with a server-authoritative sync model. | Play at https://shoveoff-3yxcry8k.manus.space | [p2-multiplayer-web-game/ACCEPTANCE.md](p2-multiplayer-web-game/ACCEPTANCE.md) | 3 min |
| p3 | **Plugin Harness** | Local AI agent host with no built-in model or tools: every capability is a sandboxed plugin with revocable permissions. | Local by design (CLI and local dashboard) | [p3-plugin-harness/ACCEPTANCE.md](p3-plugin-harness/ACCEPTANCE.md) | 5 min |
| p4 | **Pilot** | Chrome Side Panel agent that works through tasks on the current page and asks before anything risky. | Load the published extension zip unpacked | [p4-chrome-agent/ACCEPTANCE.md](p4-chrome-agent/ACCEPTANCE.md) | 10 min |
| p5 | **termctl** | MCP server that gives agents real, persistent terminal sessions, with approvals for risky commands. | Local by design (install the published package) | [p5-mcp-terminal/ACCEPTANCE.md](p5-mcp-terminal/ACCEPTANCE.md) | 10 min |
| p6 | **Veil** | Peer-to-peer, end-to-end encrypted chat rooms where the server relays only ciphertext. | Chat at https://veilchat-n3gjdzux.manus.space | [p6-p2p-chat/ACCEPTANCE.md](p6-p2p-chat/ACCEPTANCE.md) | 5 min, two people |
| p7 | **Promo videos** | One launch video of about a minute per product, made from real footage. | Links in its note | [p7-promo-assets/ACCEPTANCE.md](p7-promo-assets/ACCEPTANCE.md) | 6 min |

¹ p1's app source and note are on the `feat/murmur` branch, checked out at `p1-voice-input/.worktrees/murmur`. The same note is inside the published source zip and on the published page.

## What you need

| Need | For |
|---|---|
| A browser, ideally Chrome; two windows (one private) or two devices | p2 and p6, published versions; p7 videos |
| macOS 14+ (Apple silicon for the prebuilt app), Microphone and Accessibility permissions | p1 |
| Node.js 24 (covers every project; minimums range from 20 to 24) | Running p2–p6 locally, p3 and p5 in particular |
| Google Chrome 116+ | p4, and the browser end-to-end tests of p2, p4 and p6 |
| An [OpenRouter API key](https://openrouter.ai/keys), at a cost of cents | p1, p4, and p3's live LLM run |
| Deno 2 (recommended, `brew install deno`) | p3's enforced plugin sandbox |

A suggested order: the hosted products first (p6, p2, then the p7 videos), then the local ones from least to most setup (p5, p3, p4, p1).

## Document conventions

Every project follows the same names, so the same file answers the same question everywhere.

- **`ACCEPTANCE.md`** is the acceptance note, at the root of each project folder. Projects that deliver from an `outputs/` folder keep a copy there, identical except that it may add the public link to the package that contains the note itself (p4 does this). It is short and has these parts, in order: a one-paragraph description, how to run, how to review (steps with what to expect), and a section named exactly **Links and notes** with the published URLs first, then hosting notes and known limitations.
- **`README.md`** is the full product and developer documentation: architecture, every command, testing details.
- **Design records** use the same upper-case names: `PRD.md` (product requirements), `TRD.md` (technical design), `SPEC.md` (exact behavior and contracts), `PLAN.md` (milestones and status), `QA.md` (test matrix and results) and `DECISIONS.md` (decision log). p2 and p6 keep them in `docs/`; the other projects keep them at the root.
- **Delivery folders** hold what was published: `outputs/` (p3, p4, p5, p6), `release/` (p2) and `website/site/downloads/` (p1).
- `docs/requirements/`, `docs/audits/` and `outputs/delivery-audit/` in this top folder are internal planning and audit notes, not part of any product.
# manus
