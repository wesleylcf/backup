# P6 Veil: promo notes

**One-line pitch:** Encrypted chat rooms where the server introduces people and relays only ciphertext it cannot read. Every security claim comes with a check you can run yourself.

**Live:** https://veilchat-n3gjdzux.manus.space

**Watch:** `veil-promo.mp4` (52 s). It is the only video in this folder.

**Three key points**
1. **The server is blind, and you can watch it be blind.** Messages, display names, identity keys, the invite secret and connection details are end-to-end encrypted with the standard Noise protocol, verified byte for byte against official test vectors. The *What the server sees* view shows the server's live record for your room: random IDs, sizes and opaque ciphertext only. The test suite audits every raw server frame for plaintext.
2. **You know who you're talking to.** Everyone starts out *Unverified*. Two people compare a 60-digit safety number by voice and mark each other *Verified*. If someone's key changes (a new device, or an impostor), Veil pauses that conversation and asks you to decide.
3. **Honest about what's left.** Veil hides content, but metadata such as timing, IP and size buckets is listed plainly, along with a *Hide my IP* relay switch, guest mode that saves nothing, and a passphrase-encrypted vault with auto-lock. While going live, Veil also caught its host injecting analytics scripts and rewriting the security policy. Veil's first line of code now locks those scripts out of the network, because any third-party script in an encrypted chat could read the messages.

**Assets in this folder**
- `01-room-verified-and-unverified.png`: a three-person room. Bob is verified, Carol is not; each member shows the connection path ("Direct peer-to-peer · end-to-end encrypted") and per-message delivery receipts.
- `02-key-change-paused.png`: Bob's identity key changed. A red banner pauses the conversation, with *Compare new safety number / Accept new key / Remove*.
- `03-safety-number-verify.png`: the 60-digit safety number dialog ("compare by voice or in person").
- `04-what-the-server-sees.png`: the server's own in-memory record for the room, with *can see / cannot see* panels and opaque payloads.
- `05-catch-up-signed.png`: Erin was offline; Frank's message reaches her via Gina, with the author's signature checked.
- `terminal-e2e-acceptance.txt`: 18/18 end-to-end checks in real Chrome **against the live site**, including the frame audit (no plaintext, names, invite secret or IP candidates in 277 frames exchanged with the production server) and 0 successful third-party data requests.
- The 37-second side-by-side recording of Alice and Bob from that live run is kept with the test evidence: `p6-p2p-chat/outputs/proof/veil-live-e2e-alice-bob.mp4`.

**Suggested 45-second recording flow:** Alice creates a guest room → Bob opens the invite link (the `#k=` part disappears from the address bar) → both show *Unverified* → chat with "Delivered to 1 of 1" → compare safety numbers → *Verified* → Bob presses *Reset my identity here* → Alice gets the red key-change banner → open *What the server sees*: only ciphertext.
- `veil-promo.mp4`: **the promo video** (52 s, 1920x1080, 30 fps, H.264 + AAC, −16.7 LUFS), cut from real motion recordings of the live site. See *Promo video* below. `veil-promo-poster.png` is its poster frame (matching safety numbers on Alice's and Bob's screens).
- `stills-2x/`: 15 sharp 2880x1800 screenshots from a fresh scripted run on the live site with natural messages (no test strings), used in the promo. `a*` = Alice, `b*` = Bob, `c*` = Carol, `e*` = Erin.
- Raw recordings (per-user browser recordings of the live end-to-end run and the promo screencasts) and the superseded 72-second cut are working files in `p6-p2p-chat/.work/promo/superseded/`, kept out of this folder so there is one video to watch.

## Promo video (`veil-promo.mp4`)

**Story (52 s):** *Hook:* "Every private chat still passes through someone else's server", over a wall of the real frames the live server relayed. *Solution:* Veil's welcome screen, then a split screen with the conversation Alice reads beside the scrambled frames the server sees. *Product:* create a room → Bob joins from the link, no account → he shows up *Unverified* → the same 60-digit safety number on both screens → *Verified* → Bob's key changes and Veil pauses the conversation → Carol turns on *Hide my IP* → Erin unlocks and catches up on a message, signed by its author → guest mode saves nothing → the in-app *Security boundaries* panel. *Close:* "Veil. Don't trust us. Check." with the live URL and a one-line credit (built and tested with an AI agent in one afternoon; 18/18 live checks).

**How it was made:** all product footage is real. A Playwright script drove six users in Chrome against the live site and recorded four of them as motion video through Chrome's screencast. The 2560x1440 viewport is zoomed 2x, so the normal layout records at twice the pixels. It also captured every WebSocket frame: 268 frames, none containing plaintext. Shots are cut from those recordings by named time marks. Crops and gentle push-ins keep the interface legible, and teal boxes mark each real click just before it happens. Short captions name each moment. HTML overlays (split screen, verify layout, end card) frame the footage and the real frame data. The narration is AI-generated (studio voice Erinome) and the music is an AI-generated 60-second score, ducked under the voice and loudness-normalised. The final file passed a 12-point QA (`p6-p2p-chat/docs/QA.md`, *PROMO VIDEO QA*), including a speech-to-text check against the script. Scripts: `p6-p2p-chat/.work/promo/scripts/` (`capture2.mjs`, `prep.py`, `render2.mjs`, `build2.py`).
