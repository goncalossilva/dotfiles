function findlocal() {
	find $@ ! -fstype nfs
}

function srt() {
	conda activate subliminal
	subliminal download -l en $1
	conda deactivate
}
