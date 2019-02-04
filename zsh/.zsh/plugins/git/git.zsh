function git_current_branch() {
	git rev-parse --abbrev-ref HEAD 2>/dev/null
}
