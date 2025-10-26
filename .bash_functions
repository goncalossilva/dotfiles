findlocal() {
  find "$@" ! -fstype nfs
}

copy() {
  if hash pbcopy 2>/dev/null; then
    pbcopy
  elif hash xclip 2>/dev/null; then
    xclip -selection clipboard
  elif hash putclip 2>/dev/null; then
    putclip
  else
    rm -f /tmp/clipboard 2> /dev/null
    if [ $# -eq 0 ]; then
    cat > /tmp/clipboard
    else
      cat "$1" > /tmp/clipboard
    fi
  fi
}

pasta() {
  if hash pbpaste 2>/dev/null; then
    pbpaste
  elif hash xclip 2>/dev/null; then
    xclip -selection clipboard -o
  elif [[ -e /tmp/clipboard ]]; then
    cat /tmp/clipboard
  else
    echo ''
  fi
}

trash() {
  if [[ "$(uname)" == 'Darwin' ]]; then
    # Heavily modified from [this script][0], licensed under the MIT License.
    # [0]: https://github.com/morgant/tools-osx/blob/71c2db389c48cee8d03931eeb083cfc68158f7ed/src/trash#L293-L311
    for arg in "$@"; do
      file="$(realpath "$arg")"
      /usr/bin/osascript -e "tell application \"Finder\" to delete POSIX file \"$file\"" > /dev/null
    done
  else
    gio trash "$@"
  fi
}

beep() {
  echo -e "\a"
}
