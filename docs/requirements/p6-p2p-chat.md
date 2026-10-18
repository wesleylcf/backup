# Brief: Problem 6, P2P encrypted chat room

Paste this file into a new Manus task in local mode, publishing with Manus hosting so two people on different networks can connect through a public URL.

## Problem (verbatim)

Build a P2P encrypted chat room. Users can connect with each other and send and receive messages, with the focus on preventing chat data from leaking as much as possible. Whether to build accounts or a login system is up to you; it is not the focus of this problem.

You may use a server for user discovery, connection signaling or message relay, but think about how chat data could leak on the sending side, in transit, through intermediate services and on the receiving side, and how to reduce those risks.

Things worth thinking about:

- Threat model: which data needs protection, which attackers you may face, which components can be trusted, and which risks are out of scope;
- End-to-end encryption: how keys are generated, exchanged, verified, stored and rotated, and how to avoid man-in-the-middle attacks, replay attacks and home-made, unreliable cryptographic protocols;
- Transport and intermediate services: what signaling servers, relays, network requests, message queues or offline messages can see, and how to ensure they cannot read message content;
- Local data security: how to handle chat history, keys, caches, logs, notifications and error reports, and what happens if a device is lost or used by someone else;
- Metadata and privacy boundaries: even with encrypted content, whether information such as who is talking, when, how often, IP addresses or message sizes can still leak;
- Expressing security state in the product: how users confirm they are talking to the right person, and how they understand key changes, failed verification or insecure connections.

Using only HTTPS or WSS does not mean end-to-end encryption. Do not make blanket claims that the product is "absolutely secure"; explain the actual security boundaries in a way that can be verified.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p6-p2p-chat/`. Don't read or change other `p*` folders. Use ports 3060 to 3069 for local servers.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do, such as testing from a second device or network. Otherwise proceed on reasonable assumptions.
- **No AI key:** this product doesn't need the OpenRouter key.
- **Deliverables:** put them in `p6-p2p-chat/outputs/`. Include the published URL, a source zip without `node_modules`, build caches or secrets, and a `README.md` acceptance note. The note covers how to run it, a 5-minute two-person review script including identity verification and a key-change warning, and how a reviewer can check for themselves what the server sees. Also include `THREAT_MODEL.md` covering assets, attackers, trust boundaries, what each component can see, metadata leakage, and what's out of scope.
- **Promo assets:** save 3 to 5 screenshots, an optional 30 to 60 second recording of two people verifying each other and chatting, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p6/`.

## Environment and risk notes

- **Don't invent cryptography:** use vetted libraries (for example libsodium or Web Crypto) and established constructions, with authenticated key agreement, authenticated encryption, replay protection, and a safety-number or fingerprint check against man-in-the-middle attacks. Name the construction in the README.
- **Transport:** WebRTC DataChannel gives peer-to-peer transport, with the server used only for signaling. Add an end-to-end-encrypted relay fallback if time allows. Be honest that STUN and ICE expose IP addresses to the peer and to STUN servers, and that some NATs need a TURN relay.
- **Make it checkable:** a "what the server sees" view or log helps reviewers confirm the server only ever handles ciphertext and minimal metadata.
- **Check hosting first:** in the first 15 minutes, confirm the host supports persistent WebSocket connections for signaling. If it doesn't, change the transport or host before building further.
- **Verification:** run an automated two-client test (two headless browsers) that establishes a session and exchanges messages. Then inspect the server logs and confirm there's no plaintext, and simulate a key change to confirm the warning appears.
