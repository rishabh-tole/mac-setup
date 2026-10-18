#!/bin/bash

REPO_URL="https://github.com/rishabh-tole/mac-setup.git"
REPO_DIR="$HOME/.config/mac-setup"

# Install homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing rust.."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

echo "Cloning mac-setup to $REPO_DIR..."
# Ensure that config directory exists
mkdir -p ~/.config
git clone --recursive "$REPO_URL" "$REPO_DIR"

# Install dependencies from Brewfile (includes Raycast, Vorssaint)
echo "Installing dependencies from Brewfile..."
brew bundle --file="$REPO_DIR/Brewfile"

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Install Monaco Nerd Font: https://github.com/thep0y/monaco-nerd-font/releases.\n Hit Enter to continue"
read -rs

echo "Creating and configuring ssh keys for github..."
# Configure github ssh keys
ssh-keygen -f ~/.ssh/id_rsa_github -t rsa -b 4096 -C "rishabhtole@gmail.com"

# Add ssh key to agent
ssh-add ~/.ssh/id_rsa_github

# Copy ssh public key
cat ~/.ssh/id_rsa_github.pub|pbcopy

echo "Configure Github SSH keys. Hit Enter to continue"
read -rs

echo "Installing shell and editor..."
# Configure zsh as the default shell. Hit Enter to continue
chsh -s /bin/zsh

# Configure nvim, zsh, kitty
ln -s "$REPO_DIR/nvim" ~/.config/nvim
ln -s "$REPO_DIR/zsh-files" ~/.config/zsh-files
ln -s "$REPO_DIR/kitty" ~/.config/kitty

ln -s ~/.config/zsh-files/_zshenv ~/.zshenv

echo "Installing rishabhwm (window manager)..."
# Config first, so rishabhwm doesn't write its own default on first launch
ln -s "$REPO_DIR/rishabhwm-config" ~/.config/rishabhwm
"$REPO_DIR/rishabhwm/scripts/install.sh"

echo "Allow rishabhwm in System Settings → Privacy & Security → Accessibility. Hit Enter to continue"
read -rs

echo "Configuring Dock..."
# Auto-hide the Dock and show it instantly on hover
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
killall Dock
