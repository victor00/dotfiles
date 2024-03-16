# 📂 File Structure

# Dotfiles
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

# LazyVim
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


# 🔥 Scripts to run the fast setup
```bash
chmod +x ~/dotfiles/bin/.local/scripts/main.sh

~/dotfiles/bin/.local/scripts/main.sh
```