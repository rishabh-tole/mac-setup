# Make sure that adb is installed.
if [ ! -f ${HOME}/Library/Android/sdk/platform-tools/adb ]; then
    return 1
fi

# Source module files.
source "${0:h}/alias.zsh"
