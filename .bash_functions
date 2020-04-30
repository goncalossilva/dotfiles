findlocal() {
  find $@ ! -fstype nfs
}

srt() {
  conda activate subliminal
  subliminal download -l en $1
  conda deactivate
}
