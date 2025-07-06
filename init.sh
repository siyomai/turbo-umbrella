#!/bin/sh
set -e  # Exit immediately if a command exits with a non-zero status

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install package based on OS
install_package() {
  if [ -f "/etc/arch-release" ]; then
    echo "Installing $1 on Arch Linux..."
    sudo pacman -S --noconfirm "$1" || { echo "Failed to install $1"; exit 1; }
  elif [ -d "/etc/apt" ]; then
    echo "Installing $1 on Debian/Ubuntu..."
    sudo apt update && sudo apt install -y "$1" || { echo "Failed to install $1"; exit 1; }
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing $1 on macOS..."
    if ! command_exists brew; then
      echo "Homebrew not found. Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install "$1" || { echo "Failed to install $1"; exit 1; }
  else
    echo "Unsupported OS. Please install $1 manually."
    exit 1
  fi
}

# Setup Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Setting up Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# Source zshrc if it exists
[ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc" || echo "Warning: ~/.zshrc not found."

# Setup asdf if not already installed
if [ ! -d "$HOME/.asdf" ]; then
  echo "Setting up asdf version manager..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  
  # Add asdf to shell configuration if not already there
  if ! grep -q "asdf.sh" "$HOME/.zshrc"; then
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
  fi
  
  # Source zshrc again to load asdf
  [ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc" || echo "Warning: ~/.zshrc not found."
else
  echo "asdf is already installed."
fi

# Setup asdf plugins if asdf is available
if command_exists asdf; then
  echo "Setting up asdf plugins..."
  
  # Add plugins if not already added
  asdf plugin list | grep -q "erlang" || asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin list | grep -q "elixir" || asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  asdf plugin list | grep -q "nodejs" || asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin list | grep -q "postgres" || asdf plugin-add postgres
else
  echo "Warning: asdf command not found. Skipping plugin installation."
fi

# Setup Vim if not already done
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Setting up Vim..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  # Copy vimrc if it exists in the current directory
  if [ -f ".vimrc" ]; then
    cp .vimrc ~/.vimrc
    (cd ~ && vim +PlugInstall +qall)
  else
    echo "Warning: .vimrc not found in current directory."
  fi
else
  echo "Vim Plug is already installed."
fi

# Install tmux if not already installed
if ! command_exists tmux; then
  echo "Installing tmux..."
  install_package tmux
else
  echo "tmux is already installed."
fi

# Copy tmux configuration if it exists in the current directory
if [ -f ".tmux.conf" ]; then
  cp .tmux.conf ~/.tmux.conf
  echo "Copied tmux configuration to ~/.tmux.conf"
else
  echo "Warning: .tmux.conf not found in current directory."
fi

echo "Setup completed successfully!"
