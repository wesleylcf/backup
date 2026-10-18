# Promo videos: acceptance note

Each product has its own launch video of about one minute, 1920×1080 H.264 with AAC audio. All product footage is real: it was captured from the shipped builds or the live sites, not mocked. This folder holds the final videos, stills and a note per product (`pN/pitch.md`) with the one-line pitch, the key points and how that video was made.

## How to run

Nothing to install. Open the published links under "Links and notes", or play the local files below in any video player (QuickTime on macOS). Re-rendering is optional; it needs ffmpeg 8 and Google Chrome, and each product's build scripts are named in its `pitch.md`.

## How to review (about 6 minutes)

| Product | Local file | Length | What is real, and how it was edited |
|---|---|---|---|
| p1 Murmur | `p1/murmur-promo.mp4` | 58.5 s | Every product shot is a real dictation. The first take misrecognised "beta" as "bait", and it was left unedited. |
| p2 SHOVE OFF | `p2/promo.mp4` | 54.7 s | Two real Chrome windows play over WebSocket on the real server. Keys were pressed by a script following the game's autopilot logic, with autopilot mode off. |
| p3 Plugin Harness | `p3/promo.mp4` | 59.6 s | Built only from real dashboard captures and verbatim CLI output. |
| p4 Pilot | `p4/promo.mp4` | 56.5 s | Real footage of the extension with the real model. Waiting time is sped up behind an on-screen "▶▶ N× speed" badge, and the Chrome window frame is drawn around the captured page and panel. |
| p5 termctl | `p5/promo.mp4` | 59.2 s | Every terminal frame comes from a real recorded run; the approval scenes are real dashboard screenshots. Captions: `p5/promo.srt`. |
| p6 Veil | `p6/veil-promo.mp4` | 51.9 s | Cut from real motion recordings of the live site, driven by a Playwright script; the captured WebSocket frames contain no plaintext. |

What to look for: each video states one clear pitch, shows the core journey end to end, and makes no claim that the product's acceptance note doesn't back up.

## Links and notes

- **p1 Murmur:** https://murmur-cb4tw5gd.manus.space/media/murmur-promo.mp4 (also embedded on https://murmur-cb4tw5gd.manus.space)
- **p2 SHOVE OFF:** no separate public video link yet. Local copies: `p2/promo.mp4` and `p2-multiplayer-web-game/release/shove-off-promo.mp4`.
- **p3 Plugin Harness:** https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/EEtZhIkgvrDImBmq.mp4?Expires=1823853228&Signature=stZsIJpmeJHXyNaFwNMKOYzEGMPq0Z3BN2~2IaJ2y7WZAMaKXkqMgvJnyzaXsJAde3eQ64k0k-AFeLbCh2Dn31vHQwHlcyM7POdKvPet5EIqOCJs~crUyuZk46gFmE34uLqZyYkJogWetKM-EJCnSWONIYbmSAqKfHmzw0URFEhwAvvdKeVaGJR2OSwH~5hGtFdHB2xjf3q4woMD4vc3dm73mditB5If~1p3uymHgFMxlGWvwAlhowzri9N4XLsMNu1RNoBOKctHDsACEPZ02-XKoM-57LI0W4FmD1T-1aL4SgFsTSBZqVjDuN38bWUIdH6xVZ71u7nHQoSO85ds0Q__&Key-Pair-Id=K2HSFNDJXOU9YS
- **p4 Pilot:** https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/swRJGXrCqdKOFdqU.mp4?Expires=1823853737&Signature=JyH9jg7dz-Mq2~vcmQdU7rpKPnDx3OOoN~nAQP1zJhdj3CtgjBhmrFajQDr1AepymP~owZWRF2Lbpj8qItzHl~4X6ZEEi2rMMzlBV5AuQsQRxpwLVkJnDXZYUR-xLLNAq2AkCUm9t8gY3SlFE6g~nsZcdF28tVpAlFKak226PogquVPqHlpUJEgr5vnrJtuQWOs5J54lz9QF2y0X~DcABmQLrDsLHcna67haqM6gQ~N1kxBIsw1XhEHNOZ3sb6wH72H-PU9v8J6t9A91yPj4Qqbo-u8EYLPHSyBI8ENBt3xnqPe2pW-Gimu5iDNLML8nZkVyWYYji5cbB-1XklYSAw__&Key-Pair-Id=K2HSFNDJXOU9YS
- **p5 termctl:** https://private-us-east-1.manuscdn.com/user_upload_by_module/session_file/310519664029888977/xgdojwjmHuWyoIen.mp4?Expires=1823853684&Signature=dvWqQztvxXfAushW3MrIp7j0EWdaDPuCS60tDvtOofqLb4Z33MwSz~~qKR6-OAIEhO0WoXfx6HEGYAeKn8tgQ0Pn0-1HvtpW~8qSMudlFovdVAEngeYtUlMMXKWoIHIWFGK8iegCzR7J1EawpWfhXCI7140k15lE89QpxdQNfCX~i1nRMJ-xKYPny3PyxXrQBiimdyDyHf7AYeMfmC1FEABcS88wyG5-CFjebDHBc4sNOYukOCl42~2Gt3QirscgiiTJG3gj3m9TBmAZNC5~YNn8kcL4I92GvOmVgrao5Ola1lFtgtqHMCgcp~CN6mrFQK43r2rTNR8~tsKU9N26bQ__&Key-Pair-Id=K2HSFNDJXOU9YS
- **p6 Veil:** no separate public video link yet. Local copy: `p6/veil-promo.mp4`, with its poster frame `p6/veil-promo-poster.png`.
- The p3, p4 and p5 links are signed public CDN links, valid until 18 October 2027.
- The planning brief named this deliverable `p7-promo-video/`; the videos were delivered here, in `p7-promo-assets/`, next to each product's stills.
