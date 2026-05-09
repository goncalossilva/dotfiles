#!/usr/bin/env bash
set -euo pipefail

ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export ASDF_DATA_DIR
export PATH="$ASDF_DATA_DIR/shims:$ASDF_DATA_DIR/bin:$PATH"

main() {
  ensure_asdf_available
  add_plugins
  install_versions
}

ensure_asdf_available() {
  if command -v asdf >/dev/null 2>&1; then
    return
  fi

  local brew_asdf_sh=""
  if command -v brew >/dev/null 2>&1; then
    brew_asdf_sh="$(brew --prefix asdf 2>/dev/null)/libexec/asdf.sh"
  fi

  if [ -n "$brew_asdf_sh" ] && [ -f "$brew_asdf_sh" ]; then
    # shellcheck disable=SC1090
    . "$brew_asdf_sh"
  elif [ -f "$ASDF_DATA_DIR/asdf.sh" ]; then
    # shellcheck disable=SC1091
    . "$ASDF_DATA_DIR/asdf.sh"
  fi

  if ! command -v asdf >/dev/null 2>&1; then
    echo "asdf is not available. Install it first, then rerun this script." >&2
    exit 1
  fi
}

add_plugins() {
  add_plugin dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
  add_plugin elixir https://github.com/asdf-vm/asdf-elixir.git
  add_plugin erlang https://github.com/asdf-vm/asdf-erlang.git
  add_plugin golang https://github.com/kennyp/asdf-golang.git
  add_plugin java https://github.com/halcyon/asdf-java.git
  add_plugin kotlin https://github.com/asdf-community/asdf-kotlin.git
  add_plugin maven https://github.com/halcyon/asdf-maven.git
  add_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
  add_plugin python https://github.com/danhper/asdf-python.git
  add_plugin ruby https://github.com/asdf-vm/asdf-ruby.git
  add_plugin rust https://github.com/asdf-community/asdf-rust.git
}

add_plugin() {
  local name="$1"
  local url="$2"

  if asdf plugin list 2>/dev/null | grep -qx "$name"; then
    echo "asdf plugin already present: $name"
  else
    asdf plugin add "$name" "$url"
  fi
}

install_versions() {
  if [ ! -f "$HOME/.tool-versions" ]; then
    echo "No ~/.tool-versions found; skipping asdf install."
    return
  fi

  (cd "$HOME" && asdf install)
  asdf reshim || true
}

main "$@"
