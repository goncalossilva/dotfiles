# Bootstrap

To bootstrap a new machine:

```
~/.bootstrap/bootstrap.sh
```

Or run individual steps separately:

```
~/.bootstrap/install-packages.macos.sh
~/.bootstrap/link-app-configs.macos.sh
~/.bootstrap/apply-system-settings.macos.sh
~/.bootstrap/setup-apps.sh
```

## Layout

- `bootstrap.sh` — dispatches to the macOS or Linux scripts, then opens the matching post-install checklist.
- `Brewfile.macos` — Homebrew taps, formulae, casks, and fonts for macOS.
- `install-packages.macos.sh` — installs Homebrew and runs `brew bundle`.
- `link-app-configs.macos.sh` — links tracked app config files and shell profile into their macOS locations.
- `setup-apps.sh` — performs cross-platform app setup, such as asdf runtimes or global npm packages.
- `apply-system-settings.macos.sh` — applies macOS `defaults write` settings, imports tracked system preference snapshots, and sets the login shell to `/bin/bash`.
- `install-packages.linux.sh` — Linux placeholder; extend with distro-specific package lists.
- `link-app-configs.linux.sh` — links tracked app config files into their Linux locations.
- `apply-system-settings.linux.sh` — Linux placeholder.
- `app-configs/` — tracked file-backed app configs, such as Ghostty and Zed.
- `app-configs/macos-preferences/` — tracked macOS preference snapshots for keyboard shortcuts, Services shortcuts, and Accessibility Zoom.
- `npm-globals.txt` — global npm packages.
- `post-install-checklist.*.md` — manual steps that should not be fully automated.
