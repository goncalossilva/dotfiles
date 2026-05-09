#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$BOOTSTRAP_DIR/Brewfile.macos"
NPM_GLOBALS="$BOOTSTRAP_DIR/npm-globals.txt"

main() {
  install_homebrew
  configure_homebrew_for_this_shell
  brew bundle --file "$BREWFILE"
  "$BOOTSTRAP_DIR/asdf.sh"
  install_npm_globals
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

configure_homebrew_for_this_shell() {
  local brew_bin=""

  if [ -x /opt/homebrew/bin/brew ]; then
    brew_bin=/opt/homebrew/bin/brew
  elif [ -x /usr/local/bin/brew ]; then
    brew_bin=/usr/local/bin/brew
  else
    brew_bin="$(command -v brew)"
  fi

  eval "$($brew_bin shellenv)"
}

install_npm_globals() {
  if [ ! -s "$NPM_GLOBALS" ]; then
    return
  fi

  if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found; skipping global npm packages." >&2
    return
  fi

  grep -vE '^($|#)' "$NPM_GLOBALS" | xargs npm install -g
}

main "$@"
