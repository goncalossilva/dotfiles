# Bootstrap

To bootstrap a new machine:

```
~/.bootstrap/bootstrap.sh
```

Or run individual steps separately:

```
~/.bootstrap/install-packages.macos.sh
~/.bootstrap/link-app-configs.macos.sh
~/.bootstrap/apply-settings.macos.sh
```

## Layout

- `bootstrap.sh` — dispatches to the macOS or Linux scripts.
- `Brewfile.macos` — Homebrew taps, formulae, casks, and fonts for macOS.
- `install-packages.macos.sh` — installs Homebrew, runs `brew bundle`, configures asdf, installs global npm packages.
- `link-app-configs.macos.sh` — links tracked app config files into their macOS locations.
- `apply-settings.macos.sh` — applies macOS `defaults write` settings.
- `install-packages.linux.sh` — Linux placeholder; extend with distro-specific package lists.
- `link-app-configs.linux.sh` — links tracked app config files into their Linux locations.
- `apply-settings.linux.sh` — Linux placeholder.
- `app-configs/` — tracked file-backed app configs, such as Ghostty and Zed.
- `asdf.sh` — shared asdf plugin/runtime setup from `~/.tool-versions`.
- `npm-globals.txt` — global npm packages.
- `post-install-checklist.*.md` — manual steps that should not be fully automated.
