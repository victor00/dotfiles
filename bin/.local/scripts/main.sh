#!/bin/bash


echo -e "\033[1;32mInstalando TOOLS\033[0m"

# Caminho para o diretório binário
BINDIR="$(dirname "$0")"

# Instalar Oh My Zsh
bash "$BINDIR/install_oh_my_zsh.sh"

# Instalar Lazy Docker
bash "$BINDIR/install_lazy_docker.sh"

# Instalar Zoxide
bash "$BINDIR/install_zoxide.sh"

# Instalar tmux
bash "$BINDIR/install_tmux.sh"

# Instalar tldr
bash "$BINDIR/install_tldr.sh"

# Instalar scc
bash "$BINDIR/install_scc.sh"

# Instalar scc
bash "$BINDIR/install_lazy_vim.sh"


echo -e "\033[1;32mMy setup is finished and ready to GO\033[0m"
echo -e "\033[1;32mConfiguração concluída. Por favor, reinicie o terminal.\033[0m"


echo -e "\033[1;32mCREATING SYMBOL LINKS\033[0m"

# Criar links simbólicos para zsh e gitconfig
bash "$BINDIR/create_symbol_links.sh"