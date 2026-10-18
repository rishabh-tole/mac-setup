# Make sure that kubectl is installed
if (( ! $+commands[kubectl] )); then
    return 1
fi
