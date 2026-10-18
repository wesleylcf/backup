# Brief: Problem 4, Chrome agent extension with a Side Panel

Paste this file into a new Manus task in local mode on this Mac.

## Problem (verbatim)

Build a Chrome extension. In the Side Panel, the user describes in natural language what they want to get done; the agent understands the current page and browser state and helps carry out the task through browser actions.

At a minimum, the product should read the necessary information from the current page and complete several consecutive actions on real web pages, such as finding content, scrolling, clicking, filling in forms or managing tabs. The user needs to know what the agent is about to do, what it is doing, and whether it ultimately succeeded.

Things worth thinking about:

- First use and permissions: how users understand what the extension can do, how they install and authorize it, and how to avoid asking for permissions on all sites and the whole browser up front;
- How the agent interacts: whether the plan should be shown; how users add information, pause, cancel or retry; which steps can run automatically and which should be previewed first;
- Page understanding and reliable actions: how to handle dynamic pages, SPAs, navigation, pop-ups, changing elements, login state and different site structures;
- Safety and a sense of control: how to confirm actions with external effects such as sending messages, submitting forms, purchasing or deleting, and how to handle sensitive fields and malicious instructions embedded in web pages;
- Failure recovery and explainability: how the agent notices and recovers when it cannot find an element, the page changes, or the result does not match expectations.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p4-chrome-agent/`. Don't read or change other `p*` folders. Use ports 3040 to 3049 for local test pages.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do, such as loading the unpacked extension in my Chrome or testing on a logged-in site. Otherwise proceed on reasonable assumptions.
- **OpenRouter key:** the user enters it on the extension's options or onboarding screen, and it's stored in `chrome.storage.local`. Never hard-code or bundle it, and keep it out of deliverables, logs and screenshots. Cap agent steps per task. Use the key only inside the product, not to help build it.
- **Deliverables:** put them in `p4-chrome-agent/outputs/`. Include the unpacked extension zipped (ready for "Load unpacked"), a source zip without `node_modules` or secrets, and a `README.md` acceptance note. The note covers install steps, a 5-minute review script with concrete tasks on real sites, the permission model, safety design, and known limitations.
- **Promo assets:** save 3 to 5 screenshots, an optional 30 to 60 second recording of a multi-step task, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p4/`.

## Environment and risk notes

- **Permissions:** use Manifest V3 with the `sidePanel` API. Use `activeTab` plus `optional_host_permissions` requested at runtime, instead of asking for `<all_urls>` up front.
- **Automated testing:** recent branded Google Chrome ignores the `--load-extension` command-line flag, so automated tests should use Playwright's bundled Chromium. The final check is me loading the unpacked extension in my own Chrome, which is installed.
- **Test targets:** build a local test page on ports 3040 to 3049 with a form, an SPA route change, a pop-up and elements that change. Then use two or three real sites, for example a Wikipedia search, plus tab management.
- **Safety:** treat page text as untrusted input (prompt injection). Require explicit confirmation before actions with external effects, and mask sensitive fields.
