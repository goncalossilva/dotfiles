# Linux post-install checklist

SSH:

- After restoring `~/.ssh/id_rsa`, load it into your SSH agent if needed:
  - `ssh-add ~/.ssh/id_rsa`
  - `ssh-add -l`
  - `ssh -T git@github.com`

Firefox:

- Sign in to Firefox Sync; it will restore synced settings and extensions.

Resilio Sync:

- Set these power user preferences manually after first launch:
  - `log_size`: `1`
  - `log_ttl`: `1`
  - `disk_low_priority`: `true`

Linux package and desktop settings bootstrap is intentionally minimal for now.

When extending this, prefer distro-specific files instead of hiding package-manager differences in one large script, for example:

- `apt.linux.txt`
- `dnf.linux.txt`
- `pacman.linux.txt`

Then have `install-packages.linux.sh` detect the package manager and install from the matching list.
