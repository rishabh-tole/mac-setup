# Initialize shortcuts

local shortcuts

shortcuts=( basic editor git nav npm )
for shortcut in $shortcuts
do
    source "${0:h}/${shortcut}.zsh"
done
