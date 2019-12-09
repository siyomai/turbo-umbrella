#!/bin/sh

# ohmyzsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
source ~/.zshrc

# asdf setup
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
source ~/.zshrc

# asdf plugins
asdf plugin-add erlang git@github.com:asdf-vm/asdf-erlang.git
asdf plugin-add elixir git@github.com:asdf-vm/asdf-elixir.git
asdf plugin-add nodejs git@github.com:asdf-vm/asdf-nodejs.git
asdf plugin-add postgres

# vim setup
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp .vimrc ~/.vimrc
(cd ~ && vim +PlugInstall)

if [-f "/etc/arch-release"]; then
  pacman -S tmux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install tmux
fi

cp .tmux.conf ~/.tmux.conf
