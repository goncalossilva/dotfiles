#!/usr/bin/env bash
set -euo pipefail

main() {
  configure_login_shell
  configure_keyboard
  configure_trackpad
  configure_finder
  configure_dock
  configure_menu_bar
  configure_textedit
  restart_affected_apps
}

configure_login_shell() {
  set_default_shell /bin/bash
}

set_default_shell() {
  local desired_shell="$1"
  local current_shell=""

  if [ ! -x "$desired_shell" ]; then
    echo "Default shell does not exist or is not executable: $desired_shell" >&2
    exit 1
  fi

  current_shell="$(current_login_shell)"

  if [ "$current_shell" = "$desired_shell" ]; then
    echo "Default shell is already $desired_shell"
    return
  fi

  if [ -n "$current_shell" ]; then
    echo "Changing default shell from $current_shell to $desired_shell"
  else
    echo "Changing default shell to $desired_shell"
  fi

  chsh -s "$desired_shell"
}

current_login_shell() {
  dscl . -read "/Users/$(id -un)" UserShell 2>/dev/null | awk '/UserShell:/ { print $2 }'
}

configure_keyboard() {
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
}

configure_trackpad() {
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
  defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
  defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2
}

configure_finder() {
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
  defaults write com.apple.finder ShowRecentTags -bool false
}

configure_dock() {
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 64
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock mru-spaces -bool false

  defaults write com.apple.dock wvous-bl-corner -int 2
}

configure_menu_bar() {
  defaults write com.apple.menuextra.clock ShowSeconds -bool true
}

configure_textedit() {
  defaults write com.apple.TextEdit RichText -bool false
}

restart_affected_apps() {
  killall Finder Dock SystemUIServer 2>/dev/null || true
}

main "$@"
