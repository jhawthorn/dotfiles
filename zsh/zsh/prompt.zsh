# Prevent % on missing newline
export PROMPT_EOL_MARK=''

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "(%b %m%u%c)"
zstyle ':vcs_info:*' actionformats "(%b %m%c%u %F{cyan}%a%f)"
zstyle ':vcs_info:*' stagedstr "%F{green}S%f"
zstyle ':vcs_info:*' unstagedstr "%F{yellow}U%f"

prompt_hawth_precmd() {
	vcs_info
}

precmd_functions+=(prompt_hawth_precmd)

PS1='
%F{135}%n%f@%F{166}%m%f:%F{118}%~%f ${vcs_info_msg_0_} [${RUBY_ENGINE} ${RUBY_VERSION}]
$ '


setopt prompt_subst
