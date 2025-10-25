findlocal() {
  find "$@" ! -fstype nfs
}

srt() {
  subliminal download -l en "$1"
}
