# Brief: Problem 2, multiplayer web game

Paste this file into a new Manus task in local mode, publishing with Manus hosting so two people on different devices can play through a public URL.

## Problem (verbatim)

Build a real-time multiplayer game that can be played directly in the browser. At least two players can enter the same match, see each other's actions, and go through the full flow of joining, starting, playing, and finishing or playing again. The game genre and mechanics are up to you.

It must be a truly networked product, not two unrelated local game screens. The gameplay does not need to be complex, but it should make people want to finish a match and let them feel the fun of playing with another real person.

Things worth thinking about:

- Getting into a game: how to create or join a room, how to invite the other player, whether accounts are needed, and how two people can start their first match as quickly as possible;
- Core gameplay and feedback: whether the rules are easy to understand, the controls feel good, winning and losing are clear, and how visuals, animation, sound and pacing together create a sense of play;
- Quality of real-time sync: who is authoritative over the state, and how to handle network latency, duplicate actions, out-of-order events, cheating, and the two sides seeing different results;
- Room and player lifecycle: what should happen on refresh, disconnect, reconnect, leaving, joining mid-game, and restarting.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p2-multiplayer-game/`. Don't read or change other `p*` folders. Use ports 3020 to 3029 for local servers.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do, such as playtesting on a second device. Otherwise proceed on reasonable assumptions.
- **No AI key:** this product doesn't need the OpenRouter key.
- **Deliverables:** put them in `p2-multiplayer-game/outputs/`. Include the published URL, a source zip without `node_modules`, build caches or secrets, and a `README.md` acceptance note. The note covers how to play, how to run it locally, a 5-minute two-player review script, the sync design (authority, latency, duplicate and out-of-order handling, anti-cheat, lifecycle), and known limitations.
- **Promo assets:** save 3 to 5 screenshots, an optional 30 to 60 second recording of a two-player match, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p2/`.

## Environment and risk notes

- **Check hosting first:** in the first 15 minutes, confirm the chosen host supports persistent WebSocket connections, or whatever real-time transport you pick. If it doesn't, change the transport or host before building any gameplay.
- **Suggested sync design:** a server-authoritative room state, client actions carrying an ID and sequence number (so duplicates and out-of-order events can be dropped), and reconnect through a session token kept in `localStorage`.
- **Verification:** run an automated two-client test (two headless browsers or two socket clients) that plays a full match, including disconnect, reconnect and rematch. Then ask me for a human playtest on two devices.
- **Node 24.3.0:** this is what's installed.
