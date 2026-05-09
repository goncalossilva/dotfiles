#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NPM_GLOBALS="$BOOTSTRAP_DIR/npm-globals.txt"

main() {
  install_linux_packages
  setup_asdf_if_available
  install_npm_globals
}

install_linux_packages() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "Linux apt package list is not defined yet."
  elif command -v dnf >/dev/null 2>&1; then
    echo "Linux dnf package list is not defined yet."
  elif command -v pacman >/dev/null 2>&1; then
    echo "Linux pacman package list is not defined yet."
  else
    echo "No supported Linux package manager found."
  fi
}

setup_asdf_if_available() {
  if command -v asdf >/dev/null 2>&1 || [ -f "$HOME/.asdf/asdf.sh" ]; then
    "$BOOTSTRAP_DIR/asdf.sh"
  else
    echo "asdf is not installed; skipping runtime setup."
  fi
}

install_npm_globals() {
  if [ ! -s "$NPM_GLOBALS" ]; then
    return
  fi

  if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found; skipping global npm packages."
    return
  fi

  grep -vE '^($|#)' "$NPM_GLOBALS" | xargs npm install -g
}

main "$@"
