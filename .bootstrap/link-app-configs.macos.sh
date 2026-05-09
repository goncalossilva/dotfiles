#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  link_file \
    "$BOOTSTRAP_DIR/app-configs/ghostty/config" \
    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

  link_file \
    "$BOOTSTRAP_DIR/app-configs/zed/settings.json" \
    "$HOME/.config/zed/settings.json"

  link_file \
    "$BOOTSTRAP_DIR/app-configs/zed/keymap.json" \
    "$HOME/.config/zed/keymap.json"

  link_file \
    "$BOOTSTRAP_DIR/app-configs/linearmouse/linearmouse.json" \
    "$HOME/.config/linearmouse/linearmouse.json"
}

link_file() {
  local source="$1"
  local target="$2"
  local backup=""

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "Already linked: $target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ -f "$target" ] && cmp -s "$source" "$target"; then
      rm "$target"
    else
      backup="$target.backup.$(date +%Y%m%d%H%M%S)"
      mv "$target" "$backup"
      echo "Backed up existing file: $backup"
    fi
  fi

  ln -s "$source" "$target"
  echo "Linked: $target -> $source"
}

main "$@"
