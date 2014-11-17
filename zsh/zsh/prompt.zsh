# Prevent % on missing newline
export PROMPT_EOL_MARK=''

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "(%b %m%u%c)"
zstyle ':vcs_info:*' actionformats "(%b %m%c%u %F{cyan}%a%f)"
zstyle ':vcs_info:*' stagedstr "%F{green}S%f"
zstyle ':vcs_info:*' unstagedstr "%F{yellow}U%f"

precmd() {
	vcs_info
}

setopt prompt_subst
