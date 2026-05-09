# macOS post-install checklist

Install manually or via the App Store:

- Xcode — no direct Homebrew cask. `xcodes` / `xcodes-app` exist, but they are Xcode managers.
- WireGuard — no Homebrew GUI cask found; Homebrew has CLI-related `wireguard-tools` / `wireguard-go` only.
- iA Writer — no Homebrew cask found.
- Supercut — no Homebrew cask found.

Intentionally excluded:

- Ledger Wallet / Ledger Live.
- Chiaki.
- `Install macOS Big Sur.app`.
- `sandbox-runtime`, because it was installed from a local/uncommitted Homebrew formula.
- Direct `icu4c` formulae; dependencies should pull ICU versions as needed.

System Settings to verify manually:

- Keyboard → Keyboard Shortcuts → Modifier Keys: map Caps Lock to Control for each keyboard.
- Keyboard → Input Sources: enable `USInternational-PC` and keep/remove `U.S.` as desired.
- Privacy & Security permissions:
  - Accessibility: Alfred, BetterTouchTool, LinearMouse, terminal/editor apps as needed.
  - Input Monitoring: BetterTouchTool/keyboard utilities if requested.
  - Screen Recording: meeting/screenshot/automation tools if requested.
  - Full Disk Access: terminal/editor/sync tools if needed.
- Tailscale system extension/kernel extension approval if macOS asks for it.
- Xcode first launch/license after installing:
  - `sudo xcodebuild -license accept`
  - `sudo xcodebuild -runFirstLaunch`

Dock layout is not automated. Pinned apps from the audited machine:

- Firefox
- TIDAL
- Todoist
- Slack
- Discord
- Telegram
- Signal
- WhatsApp
- Zed
- Ghostty
- Fork
- TextEdit

Stacks/folders:

- Applications
- Downloads

Manual/source-specific fonts:

- Segoe UI fonts found in `~/Library/Fonts` on the audited machine.
- RODE Noto fonts found in `/Library/Fonts`; these likely came from RODE software.

BetterTouchTool:

- Use Manage Presets → Export/Import for portable presets.
- Do not track raw `~/Library/Application Support/BetterTouchTool` data stores, licenses, clipboard databases, logs, or preference plists.
