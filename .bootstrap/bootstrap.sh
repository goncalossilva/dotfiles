#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  case "$(uname -s)" in
    Darwin)
      "$BOOTSTRAP_DIR/install-packages.macos.sh"
      "$BOOTSTRAP_DIR/link-app-configs.macos.sh"
      "$BOOTSTRAP_DIR/apply-settings.macos.sh"
      ;;
    Linux)
      "$BOOTSTRAP_DIR/install-packages.linux.sh"
      "$BOOTSTRAP_DIR/link-app-configs.linux.sh"
      "$BOOTSTRAP_DIR/apply-settings.linux.sh"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

main "$@"
