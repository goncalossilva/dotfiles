# Bootstrap

To bootstrap a new machine:

```
~/.bootstrap/bootstrap.sh
```

Or run individual steps separately:

```
~/.bootstrap/install-packages.macos.sh
~/.bootstrap/settings.macos.sh
```

## Layout

- `bootstrap.sh` — dispatches to the macOS or Linux scripts.
- `Brewfile.macos` — Homebrew taps, formulae, casks, and fonts for macOS.
- `install-packages.macos.sh` — installs Homebrew, runs `brew bundle`, configures asdf, installs global npm packages.
- `settings.macos.sh` — macOS `defaults write` settings.
- `install-packages.linux.sh` — Linux placeholder; extend with distro-specific package lists.
- `settings.linux.sh` — Linux placeholder.
- `asdf.sh` — shared asdf plugin/runtime setup from `~/.tool-versions`.
- `npm-globals.txt` — global npm packages.
- `post-install-checklist.*.md` — manual steps that should not be fully automated.
