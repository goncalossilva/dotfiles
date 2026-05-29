# macOS post-install checklist

Install manually or via the App Store:

- Xcode — no direct Homebrew cask. `xcodes` / `xcodes-app` exist, but they are Xcode managers.
- WireGuard — no Homebrew GUI cask found; Homebrew has CLI-related `wireguard-tools` / `wireguard-go` only.
- iA Writer — no Homebrew cask found.
- Supercut — no Homebrew cask found.

System Settings to verify manually:

- Keyboard shortcuts, Services shortcuts, and Accessibility → Zoom are imported by bootstrap. If they do not appear immediately, log out and back in.
- Keyboard → Keyboard Shortcuts → Modifier Keys: map Caps Lock to Control for each keyboard.
- Keyboard → Input Sources: enable `USInternational-PC` and keep/remove `U.S.` as desired.
- Privacy & Security permissions:
  - Accessibility: Alfred, BetterTouchTool, Caffeine, Handy, LinearMouse, MonitorControl, Moonlight, Supercut.
  - Screen & System Audio Recording: BetterTouchTool, Chromium, Firefox, Supercut
  - System Audio Recording Only: Granola
  - Full Disk Access: AppCleaner, terminal/editor/sync tools if needed.
- Tailscale system extension/kernel extension approval if macOS asks for it.

SSH:

- After restoring `~/.ssh/id_rsa`, load it into the macOS keychain-backed agent:
  - `ssh-add --apple-use-keychain ~/.ssh/id_rsa`
  - `ssh-add -l`
  - `ssh -T git@github.com`
- This lets Git/SSH use `SSH_AUTH_SOCK` instead of reading private keys directly.

Firefox:

- Sign in to Firefox Sync; it will restore synced settings and extensions.

Resilio Sync:

- Set these power user preferences manually after first launch:
  - `log_size`: `1`
  - `log_ttl`: `1`
  - `disk_low_priority`: `true`

Dock layout is not automated. Pinned apps:

- Firefox
- TIDAL
- Todoist
- WhatsApp
- Telegram
- Signal
- Discord
- Slack
- Zed
- Fork
- Ghostty

Stacks/folders:

- Applications
- Downloads

BetterTouchTool:

- Use Manage Presets → Export/Import for portable presets.
