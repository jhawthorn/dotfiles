if (( $+commands[gh] )) ; then
  alias git="gh"
elif (( $+commands[hub] )) ; then
  alias git="hub"
fi

compdef hub=git
compdef gh=git
