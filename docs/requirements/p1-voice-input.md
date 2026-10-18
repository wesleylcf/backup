# Brief: Problem 1, desktop voice input

Paste this file into a new Manus task in local mode on this Mac.

## Problem (verbatim)

Build a desktop voice input product. In any application, the user presses a global keyboard shortcut and simply starts talking; the product recognizes the speech, turns it into text suitable for written communication, and inserts it into the input field that is currently active on the system.

It should not be just a speech-to-text page. It should become an input method that feels natural across different desktop applications.

Things worth thinking about:

- Onboarding: how the user grants permissions such as microphone and accessibility, how the shortcut is set up, and how the user succeeds on their very first try;
- Shortcut and voice input experience: the trade-offs between push-to-talk, press-once-to-start and other approaches; how to show the current state; how to cancel, edit or avoid accidental triggers;
- Speech recognition quality and performance: latency to the first word, speed of the full result, accuracy, multiple languages and mixed Chinese-English speech, punctuation and formatting, memory of proper nouns or a personal dictionary;
- Text processing and insertion: how to turn spoken language into appropriate text, how to reliably find the current input focus and insert the content, and how to degrade gracefully in unsupported applications;
- Privacy and trust: when recording starts, whether audio and history are kept, and how the user clearly perceives and controls these behaviors.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p1-voice-input/`. Don't read or change other `p*` folders. If you need local ports, use 3010 to 3019.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do, such as granting a permission or speaking into the mic. Otherwise proceed on reasonable assumptions.
- **OpenRouter key:** read it from the `OPENROUTER_API_KEY` environment variable or the app's settings, stored in Keychain or a local config file. Never hard-code it or include it in deliverables, logs or screenshots. Use it only inside the product, not to help build it.
- **Deliverables:** put them in `p1-voice-input/outputs/`. Include the built `.app` zipped, plus a source zip without build products or secrets. Add a `README.md` acceptance note covering what it is, how to install and run it, the permissions to grant, a 5-minute review script, design decisions and trade-offs, and known limitations.
- **Promo assets:** save 3 to 5 screenshots, an optional 30 to 60 second screen recording (I can record it with Cmd-Shift-5 if you ask), a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p1/`.

## Environment and risk notes

- **Toolchain:** macOS 15.3.1 on Apple Silicon, with Xcode 16.4 and Swift 6.1.2 installed. A native Swift/AppKit menu-bar app is the most reliable route to global shortcuts, the Accessibility API and text insertion. Electron or Tauri would make insertion and permission handling harder.
- **Permission resets:** macOS ties microphone and Accessibility permissions to the app's code signature and bundle ID. Rebuilding an ad-hoc-signed app can silently reset the grant, which looks like random failures during testing. Use a fixed bundle ID, consistent signing and a fixed install location, such as `~/Applications`.
- **Speech recognition:** choose a recognition engine in the first 20 minutes. Options include Apple's Speech framework (on-device, streaming, low latency), local Whisper (WhisperKit or whisper.cpp, good at mixed Chinese-English, private) or a cloud model through OpenRouter (check which models accept audio input). Measure latency to the first word and to the full result.
- **Testing without speaking:** `say -v Tingting -o zh.aiff "..."` and `say -v Samantha -o en.aiff "..."` generate Chinese and English test audio files for automated tests of the pipeline.
- **Insertion fallbacks:** first set the focused element's selected text through the Accessibility API. If that fails, paste through the pasteboard plus Cmd-V and restore the clipboard afterwards. As a last resort, copy the text and show a notification.
- **What I'll test by hand:** granting the mic and Accessibility permissions (plus Input Monitoring if you use an event tap), then dictating in Notes, a Chrome text area, VS Code, Terminal and one chat app.
