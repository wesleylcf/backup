# P2 SHOVE OFF: promo notes

**One-line pitch:** Sumo on ice for 2–4 friends, right in the browser. Send one link; friends pick a name and they're in, and every shove lands on everyone's screen at the same moment.

**Video:** `promo.mp4`, 54.7 s, 1920×1080, H.264 + AAC, original music. A copy is in `p2-multiplayer-web-game/release/shove-off-promo.mp4`.

**Three key points**
1. **One link, no sign-up.** The host creates a match and copies the link. A friend opens it, picks a name (a fun one is suggested) and is in the waiting room. There are no accounts, installs or friend requests. Joining closes once the match starts, so nobody barges in mid-game.
2. **Really real-time, really together.** The server owns the game. Both screens show the same shoves, KOs, taunts and result, and they agree on who won. It played the full journey on a real server over the LAN and over the public internet through a Cloudflare tunnel. Your own blob moves on the very next frame, without waiting for the server (measured over the internet: first rendered frame after the key).
3. **Built for real life.** If someone's Wi-Fi drops, the match pauses for everyone and waits up to 20 s for them to come back. Refresh, leave and rematch all behave predictably. It also works on a phone with touch controls.

**How the footage was made (honesty note)**
Every product shot is real footage of the shipped build. The real server ran with normal timers, and two separate Chrome browsers were connected over WebSocket and captured at 1080p. The keys and clicks were pressed by a script, not by people. Each move was chosen by the game's own autopilot logic, but the autopilot mode was off, so the screens look exactly as they do for a human. The Wi-Fi drop is a real disconnect and reconnect. The phone screenshot comes from Chrome's phone emulation with touch enabled, not a physical phone. A white cursor dot was added to show where clicks happen. Nothing in the video was mocked up.

**Assets in this folder**
- `promo.mp4`: the launch video. Hook ("Game night. Miles apart.") → logo → create and copy the link → friend picks a name → warm-up shoves and taunts → countdown → live play on both screens → Wi-Fi drop pauses the match → winner crowned and rematch → closing card.
- `stills/01-logo.png` … `stills/09-closing.png`: full-resolution frames from the video, one per beat.
- `audio/music.mp3`: the original instrumental bed (AI-generated for this video, 124 BPM).
- Brief and storyboard: `p2-multiplayer-web-game/docs/PROMO.md`. Production scripts: `p2-multiplayer-web-game/promo/`. Verification: QA-V1..V11 in `p2-multiplayer-web-game/docs/QA.md`.
