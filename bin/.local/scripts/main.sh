#!/bin/bash

# Caminho para o diretório binário
BINDIR="$(dirname "$0")"

# Instalar Oh My Zsh
bash "$BINDIR/install_oh_my_zsh.sh"

# Instalar Lazy Docker
bash "$BINDIR/install_lazy_docker.sh"

# Instalar Zoxide
bash "$BINDIR/install_zoxide.sh"

echo -e "\033[1;32mMy setup is finished and ready to GO\033[0m"
echo -e "\033[1;32mConfiguração concluída. Por favor, reinicie o terminal.\033[0m"
