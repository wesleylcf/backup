# P7 promo video — Delivery audit

## Summary verdict

**Non-compliant.** Audit time: **2026-10-18 17:42:19 +08**. Both delivery-rule checks fail for the P7 product. `/Users/wesley/Documents/manus/p7-promo-video/` does not exist at audit time, so its required `outputs/` directory, reviewer note, and delivered project checkout are absent. A public Veil chat URL is documented in source assets, but it is the underlying P6 application, not a public playback/download URL for the P7 promo video.

The brief permits a video about one product. There is a plausible final asset at `p7-promo-assets/p6/veil-promo.mp4`: 1920×1080, H.264/AAC, 30 fps, 72.45 seconds. The P6 asset pitch describes it as the finished 72-second promo. It is nevertheless only staged in the asset folder, not delivered in the specified P7 `outputs/` folder or publicly hosted as the video.

## Acceptance note

**Status: fail.**

**Main-checkout locations:** none. The P7 project directory and therefore `p7-promo-video/outputs/README.md` are absent. The bounded search found no P7 README, QA, or `ACCEPTANCE*.md` candidate.

`p7-promo-assets/p6/pitch.md:1–31` is a supplemental source-asset pitch, not a P7 acceptance note. It identifies the P6 product, describes the local `veil-promo.mp4` asset and its production, and points to the live P6 app. It does **not** give a reviewer a P7 delivery location, a command or public video URL to open, a review checklist for the final video, expected observations, or known limitations.

Because the P7 checkout is missing, no P7 `package.json`, scripts, paths, ports, or claimed output filenames exist to validate. The main Manus root is not a Git repository, so `git worktree list` and `git branch -a` there both returned “not a git repository”; no P7-named worktree was found in the bounded worktree-path check. Thus there is no unmerged-branch or `.worktrees/` acceptance note to credit to the main checkout.

**Inaccuracies/mismatches:** the brief requires `p7-promo-video/outputs/` with the final 1080p MP4 and a short `README.md`; both the project/output location and that README are absent. The available finished-looking MP4 is instead at `p7-promo-assets/p6/veil-promo.mp4`.

## Published URLs

**Status: fail.** No public URL that delivers the P7 promotional video was found or documented. The one product URL below is publicly reachable but serves the P6 Veil web app, not a video page, video file, or P7 deliverable.

| URL | Purpose | Where documented | Local result | Remote fetch result | Public yes/no | Notes |
|---|---|---|---|---|---|---|
| https://veilchat-n3gjdzux.manus.space/ | Live P6 Veil encrypted-chat application | `p7-promo-assets/p6/pitch.md:5`; also a local acceptance transcript contains an invite URL with its fragment redacted | **Not verifiable locally:** `curl -L` exited 6 / HTTP 000 because local-execution policy blocked DNS/outbound network access | **Success:** remote fetch returned the Veil chat page’s encryption/security-boundary text; it was neither a login/error page nor a video page | **Yes, for P6 app** | This confirms a public underlying-product site only. It is not in a P7 acceptance note and does not expose the 72-second promo as a public video. |

The asset URL scan also found an OpenRouter API endpoint and analytics/CDN references in test transcripts. Those are third-party/service URLs, not product publication locations, so they do not satisfy the rule and were not treated as candidate P7 delivery URLs.

## Top fixes

1. **Create `p7-promo-video/outputs/README.md` (or `ACCEPTANCE.md`)** with a short reviewer path: the public video URL, how to play it without credentials, products featured, runtime/format, a concise scene-by-scene review checklist, expected result, and any limitations.
2. **Publish the actual 1080p MP4** to a stable public video host or a direct public MP4 URL that plays without sign-in. Put the exact URL in the reviewer note and in Links and notes. The P6 app URL alone is not sufficient for the P7 video.
3. **Place the final video and note in the specified P7 output path.** If `p7-promo-assets/p6/veil-promo.mp4` is the intended final, deliver it as `p7-promo-video/outputs/<final-name>.mp4` and make the note identify it explicitly.

## Other flags

- The brief-required P7 project folder is still missing at the final recheck. The only P7-related directory is `p7-promo-assets/`, which is an input/staging location rather than the required delivery location.
- A local P6 acceptance transcript includes an invite-link fragment. Its value was treated as sensitive and is not reproduced here. Do not carry such invite material into a public video description, public note, or public artifact.
- The remote public-internet check is positive for the P6 app. The local curl result is a policy/DNS block, not evidence that the public app is down.
