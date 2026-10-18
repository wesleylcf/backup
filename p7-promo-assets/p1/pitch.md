# Murmur: promo assets (p1)

**One-line pitch:** Murmur turns speech into clean written text wherever your Mac's cursor is. Tap Right ⌥, talk, tap again.

**Video:** [murmur-promo.mp4](murmur-promo.mp4) (1920×1080, H.264/AAC, 58.5 s, about −16 LUFS). It is also published at https://murmur-cb4tw5gd.manus.space/media/murmur-promo.mp4.

**Storyboard:** hook ("You think in full sentences. Your typing can't keep up.") → product and key → four real dictations → privacy card → close ("Talk anywhere you can type.").

| Still | Shows |
|---|---|
| `stills/01.png` | Hook card |
| `stills/02.png` | Product card: Right ⌥ "Tap to talk" |
| `stills/03.png` | Notes: self-correction dictation being tidied |
| `stills/04.png` | Notes: both results, including mixed Chinese–English |
| `stills/05.png` | TextEdit: the reply typed under "Hi Sam," |
| `stills/06.png` | Listening pill (red dot, level meter, timer, Cloud badge) before the Esc cancel |
| `stills/07.png` | Privacy card |
| `stills/08.png` | Closing card |

**How it was made:** every product shot is real footage, with no mock-ups. `Murmur --selftest promo` recorded the screen while the real shortcut, microphone, cloud recognition and insertion ran, and `promo/edit.py` cut it in real time with captions. The first take misrecognised "beta" as "bait"; this was left unedited. macOS's volume indicator also flashes briefly during the second dictation. Voices (user: Achird, narrator: Autonoe) and the 100 BPM instrumental bed are AI-generated. The full creative brief is in [BRIEF.md](BRIEF.md), and sources are in `source/` (narration, dictation clips, music, cards).

## Links and notes

- Published product page: https://murmur-cb4tw5gd.manus.space
- App download: https://murmur-cb4tw5gd.manus.space/downloads/Murmur-macOS-arm64.zip
- Source download: https://murmur-cb4tw5gd.manus.space/downloads/murmur-source.zip
- Acceptance note: `p1-voice-input` repo, `ACCEPTANCE.md` (branch `feat/murmur`)
