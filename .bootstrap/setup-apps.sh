#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

NPM_GLOBALS="$BOOTSTRAP_DIR/npm-globals.txt"

RESILIO_IGNORE_LIST="$BOOTSTRAP_DIR/app-configs/resilio-sync/IgnoreList"
RESILIO_SYNC_FOLDERS=(
  Brain
  Code
  Desktop
  Documents
  Downloads
  Movies
  Music
  Pictures
  Presentations
  Scripts
  Shows
)

export ASDF_DATA_DIR
export PATH="$ASDF_DATA_DIR/shims:$ASDF_DATA_DIR/bin:$PATH"

main() {
  setup_asdf
  install_npm_globals
  setup_resilio_sync
}

setup_asdf() {
  case "$(uname -s)" in
    Darwin)
      install_asdf_runtimes
      ;;
    Linux)
      if asdf_is_available; then
        install_asdf_runtimes
      else
        echo "asdf is not installed; skipping runtime setup."
      fi
      ;;
  esac
}

asdf_is_available() {
  local brew_asdf_prefix=""

  if command -v asdf >/dev/null 2>&1 || [ -f "$HOME/.asdf/asdf.sh" ]; then
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    brew_asdf_prefix="$(brew --prefix asdf 2>/dev/null || true)"
    [ -n "$brew_asdf_prefix" ] && [ -f "$brew_asdf_prefix/libexec/asdf.sh" ] && return 0
  fi

  return 1
}

install_asdf_runtimes() {
  ensure_asdf_available
  add_asdf_plugins
  install_asdf_versions
}

ensure_asdf_available() {
  local brew_asdf_prefix=""

  if command -v asdf >/dev/null 2>&1; then
    return
  fi

  if command -v brew >/dev/null 2>&1; then
    brew_asdf_prefix="$(brew --prefix asdf 2>/dev/null || true)"
    if [ -n "$brew_asdf_prefix" ] && [ -f "$brew_asdf_prefix/libexec/asdf.sh" ]; then
      # shellcheck disable=SC1091
      . "$brew_asdf_prefix/libexec/asdf.sh"
    fi
  elif [ -f "$ASDF_DATA_DIR/asdf.sh" ]; then
    # shellcheck disable=SC1091
    . "$ASDF_DATA_DIR/asdf.sh"
  fi

  if ! command -v asdf >/dev/null 2>&1; then
    echo "asdf is not available. Install it first, then rerun this script." >&2
    exit 1
  fi
}

add_asdf_plugins() {
  add_asdf_plugin dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
  add_asdf_plugin elixir https://github.com/asdf-vm/asdf-elixir.git
  add_asdf_plugin erlang https://github.com/asdf-vm/asdf-erlang.git
  add_asdf_plugin golang https://github.com/kennyp/asdf-golang.git
  add_asdf_plugin java https://github.com/halcyon/asdf-java.git
  add_asdf_plugin kotlin https://github.com/asdf-community/asdf-kotlin.git
  add_asdf_plugin maven https://github.com/halcyon/asdf-maven.git
  add_asdf_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
  add_asdf_plugin python https://github.com/danhper/asdf-python.git
  add_asdf_plugin ruby https://github.com/asdf-vm/asdf-ruby.git
  add_asdf_plugin rust https://github.com/asdf-community/asdf-rust.git
}

add_asdf_plugin() {
  local name="$1"
  local url="$2"

  if asdf plugin list 2>/dev/null | grep -qx "$name"; then
    echo "asdf plugin already present: $name"
  else
    asdf plugin add "$name" "$url"
  fi
}

install_asdf_versions() {
  if [ ! -f "$HOME/.tool-versions" ]; then
    echo "No ~/.tool-versions found; skipping asdf install."
    return
  fi

  (cd "$HOME" && asdf install)
  asdf reshim || true
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

setup_resilio_sync() {
  local folder=""

  if [ ! -f "$RESILIO_IGNORE_LIST" ]; then
    echo "Missing Resilio Sync IgnoreList: $RESILIO_IGNORE_LIST" >&2
    exit 1
  fi

  for folder in "${RESILIO_SYNC_FOLDERS[@]}"; do
    install_resilio_ignore_list "$HOME/$folder/.sync/IgnoreList"
  done
}

install_resilio_ignore_list() {
  local target="$1"

  mkdir -p "$(dirname "$target")"

  if [ -f "$target" ] && [ ! -L "$target" ] && cmp -s "$RESILIO_IGNORE_LIST" "$target"; then
    echo "Already current: $target"
    return
  fi

  rm -f "$target"
  cp "$RESILIO_IGNORE_LIST" "$target"
  echo "Installed Resilio Sync IgnoreList: $target"
}

main "$@"
