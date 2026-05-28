#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  local checklist=""

  case "$(uname -s)" in
    Darwin)
      checklist="$BOOTSTRAP_DIR/post-install-checklist.macos.md"
      "$BOOTSTRAP_DIR/install-packages.macos.sh"
      "$BOOTSTRAP_DIR/link-app-configs.macos.sh"
      "$BOOTSTRAP_DIR/apply-system-settings.macos.sh"
      "$BOOTSTRAP_DIR/setup-apps.sh"
      ;;
    Linux)
      checklist="$BOOTSTRAP_DIR/post-install-checklist.linux.md"
      "$BOOTSTRAP_DIR/install-packages.linux.sh"
      "$BOOTSTRAP_DIR/link-app-configs.linux.sh"
      "$BOOTSTRAP_DIR/apply-system-settings.linux.sh"
      "$BOOTSTRAP_DIR/setup-apps.sh"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac

  open_post_install_checklist "$checklist"
}

open_post_install_checklist() {
  local checklist="$1"

  echo "Opening post-install checklist: $checklist"

  case "$(uname -s)" in
    Darwin)
      if command -v open >/dev/null 2>&1 && open "$checklist"; then
        return
      fi
      ;;
    *)
      if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$checklist" >/dev/null 2>&1 &
        return
      fi
      ;;
  esac

  echo "Open this post-install checklist: $checklist"
}

main "$@"
