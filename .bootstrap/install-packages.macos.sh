#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$BOOTSTRAP_DIR/Brewfile.macos"

main() {
  install_homebrew
  configure_homebrew_for_this_shell
  brew bundle --file "$BREWFILE"
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

main "$@"
