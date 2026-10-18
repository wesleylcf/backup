# Murmur promo — creative brief and storyboard (P7)

**Product:** Murmur, a macOS menu-bar voice input. Tap right ⌥ in any app, talk, tap again; cleaned-up text is typed where the cursor is.
**Line:** "Talk anywhere you can type."
**Audience:** people who write all day in Mail, Notes, Slack-like tools and docs, and think faster than they type.
**Length / format:** about 50 s, 1920×1080, H.264 MP4, 30 fps, AAC stereo.
**Look:** deep navy with a violet glow, the pill's recording red as the accent, SF Pro type (rendered natively by `promo/cards.swift`).

## Truthfulness rules
- Every demo shot is real footage of Murmur, recorded by `Murmur --selftest promo` (`Sources/Murmur/PromoRun.swift`) through the real shortcut, microphone, cloud recognition and insertion. The "user" voice clips are played through the speakers into the microphone, and **the same clips** are laid under the footage at the logged times. Nothing typed by Murmur is edited.
- Set-up text that the harness types itself (the note title "Launch plan", "Hi Sam,") is never presented as dictated: there is no pill when it appears.
- Privacy claims come from README "Privacy": the pill is on screen whenever the mic is on; audio is held in memory, sent once to transcribe, never saved; history is text-only, kept 7 days by default, can be off. Recognition is cloud-based (OpenRouter → ElevenLabs Scribe), so the video never says "on-device".
- No latency number is claimed; real-time footage shows the real wait.

## Storyboard
| # | Time (approx.) | Picture | Sound |
|---|---|---|---|
| 1 Hook | 0–5.4 s | "You think in full sentences." / "Your typing can't keep up." on navy | N1 (Autonoe): "You think in full sentences... but your typing can't keep up." Music intro |
| 2 Solution | 5.4–12.2 s | Murmur mark + wordmark, tagline, right-⌥ keycap "Tap to talk. Tap again and it's typed." | N2: "Meet Murmur. Tap one key, just talk, and your words land right where you're typing." |
| 3 Demo: self-correction | ~12 s | Real Notes note "Launch plan": pill listening → transcribing → "So I think we should ship the beta on Wednesday." Chip: "Fillers and self-corrections, cleaned up". Subtitle of what was said | User voice (Achird) d1 |
| 4 Demo: mixed language | ~8 s | Same note, next line: 明天的 standup 改到三点，记得 update 一下 Jira。 Chip: "中文 + English in one breath" | d2 |
| 5 Demo: another app | ~7 s | TextEdit reply under "Hi Sam,". Chip: "Works in the app you're already in" | d3 |
| 6 Demo: control | ~6 s | Dictation started, then Esc: pill says Cancelled, nothing typed. Chip: "Changed your mind? Esc cancels" | d4 |
| 7 Trust | 5 s | "Private by design." three rows | N3: "You always see when it's listening. And Murmur never saves your audio." |
| 8 Close | 4.5 s | Mark + "Murmur" + "Talk anywhere you can type." + "For macOS · Tap right ⌥ and start talking" | N4: "Murmur. Talk anywhere you can type." Music resolves |

## Assets (`source/`)
- `audio/d1-correction.wav` … `d4-cancel.wav`: user voice, studio voice Achird (generated speech).
- `audio/n1-hook.wav` … `n4-close.wav`: narrator, studio voice Autonoe, style "warm and confident".
- `audio/music.mp3`: 55 s original instrumental bed, 100 BPM, A major, minimal electronic (generated music; prompt in DECISIONS D-025).
- `cards/*.png`: title cards, chips, subtitles, privacy and closing cards.
- Raw screen recording and event log stay in the project's untracked `.work/promo/` (they show the whole display).
