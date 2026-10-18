# Make sure that networksetup is available. This plugin works only on macs (for
# now).
if (( ! $+commands[networksetup] )); then
    return 1
fi
