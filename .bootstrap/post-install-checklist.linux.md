# Linux post-install checklist

Linux package and desktop settings bootstrap is intentionally minimal for now.

When extending this, prefer distro-specific files instead of hiding package-manager differences in one large script, for example:

- `apt.linux.txt`
- `dnf.linux.txt`
- `pacman.linux.txt`

Then have `install-packages.linux.sh` detect the package manager and install from the matching list.
