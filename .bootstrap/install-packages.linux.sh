#!/usr/bin/env bash
set -euo pipefail

main() {
  install_linux_packages
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

main "$@"
