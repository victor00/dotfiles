# Installing NVIM on Ubuntu 

```bash
wget https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz

tar xzvf nvim-linux64.tar.gz

sudo cp -r nvim-linux64/* /usr/local/

nvim --version
```

# 📂 File Structure

## Dotfiles

```bash
.dotfiles/
├── bin/.local/scripts/
├── git/
│   └── .gitconfig
├── zsh/
│   └── .zshrc
│   └── .aliases
│   └── .extra_configs
├── tmux/
│   └── .tmux.conf
├── vim/
│   └── init.vim
```

## LazyVim

```bash
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.lua
```

[LazyVim] https://github.com/LazyVim/LazyVim

## After installing Lazyvim

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## 🔥 Scripts to run the fast setup

```bash
chmod +x ~/dotfiles/bin/.local/scripts/main.sh

~/dotfiles/bin/.local/scripts/main.sh
```