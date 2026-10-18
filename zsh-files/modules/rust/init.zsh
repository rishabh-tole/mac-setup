# Make sure that rust is installed
command -v $HOME/.cargo/bin

if (( ! $? )); then
    return 1
fi

# Configure rust path
path+=($HOME/.cargo/bin)

# Source module files.
source "${0:h}/alias.zsh"
