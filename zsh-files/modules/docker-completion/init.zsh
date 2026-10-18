# Make sure that docker is installed
if (( ! $+commands[docker] )); then
    return 1
fi

# Source module files.
source "${0:h}/completion.zsh"

compinit
