# Brief: Problem 3, local AI agent harness with plugins

Paste this file into a new Manus task in local mode on this Mac.

## Problem (verbatim)

Build a local AI agent harness that supports plugins. Users can install, inspect, configure, enable and run plugins; plugin developers can add new capabilities to the host by following a clear protocol. The product can be a CLI, a desktop app, a local web app, or a combination of these.

Also provide at least two plugins that are meaningfully different, and use them to prove that the plugin mechanism really extends the host rather than hard-coding features into the main program.

Things worth thinking about:

- Plugin developer experience: how a plugin's directory, manifest, entry point, capabilities and lifecycle are defined, and how a developer can write and debug a first plugin as quickly as possible;
- Plugin management for users: how to discover, install, enable, disable, configure and update plugins, and how users understand what happened when a plugin fails;
- The boundary between host and plugin: which capabilities the host provides, what plugins can access, and how data, events, UI or commands pass between them;
- Stability and compatibility: how to handle a single plugin crashing, timing out or being version-incompatible, and how to keep it from bringing down the whole host;
- Permissions and security: whether third-party code is isolated, and how permissions for files, network, processes or sensitive configuration are declared, granted and revoked.

## Ground rules for this task

- **Context:** this is one of several problems being built in parallel in separate Manus tasks on the same Mac. Work only inside `/Users/wesley/Documents/manus/p3-plugin-harness/`. Don't read or change other `p*` folders. Use ports 3030 to 3039.
- **Time:** there is a hard deadline. Get a working end-to-end version first (about 75 to 90 minutes in), then improve it. Stop adding features at T+2:30 and finish packaging by T+2:45, where T is when answering started. Ask me for the current time if you need it.
- **Way of working:** plan briefly before coding. State the approach and what you'll cut, then build. Verify with real evidence (tests run, outputs shown) before saying something works. Ask me only for things only I can do. Otherwise proceed on reasonable assumptions.
- **OpenRouter key:** read it from the `OPENROUTER_API_KEY` environment variable, kept in a gitignored `.env`. Never hard-code it or include it in deliverables, logs or screenshots. Cap the agent loop with a maximum step count. Use the key only inside the product, not to help build it.
- **Deliverables:** put them in `p3-plugin-harness/outputs/`. Include a source zip without `node_modules`, build caches or secrets, and a `README.md` acceptance note. The note covers what it is, install and run steps, a 5-minute review script, the plugin protocol and how to write a first plugin, design decisions and trade-offs, and known limitations.
- **Promo assets:** save 3 to 5 screenshots or terminal captures, an optional 30 to 60 second recording, a one-line pitch and three key points to `/Users/wesley/Documents/manus/promo-assets/p3/`.

## Environment and risk notes

- **Suggested shape (not required):** a Node/TypeScript CLI with an optional local web UI. Each plugin runs as its own child process and talks JSON-RPC over stdio. A manifest declares the plugin's capabilities, permissions and the host API version it needs. Process isolation is what keeps one crashing or hanging plugin from taking down the host.
- **Two meaningfully different plugins:** for example, one adds agent tools, and another adds a different kind of extension point, such as a model provider, an event hook, a command or a UI panel.
- **Optional, last hour only:** a plugin that mounts any MCP server, which would let a separately built MCP terminal server run inside the harness. Don't depend on it.
- **Verification:** run tests for install, enable, disable and config, a crashing plugin, a plugin that hangs until it times out, a version-incompatible plugin and a denied permission. The agent loop must run end to end with real tool calls.
- **Node 24.3.0:** this is what's installed.
