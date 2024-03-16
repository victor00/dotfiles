#!/bin/bash

# Caminho para o diretório binário
BINDIR="$(dirname "$0")"

# Instalar Oh My Zsh
bash "$BINDIR/install_oh_my_zsh.sh"

# Instalar Lazy Docker
bash "$BINDIR/install_lazy_docker.sh"

echo "My setup is finished and ready to GO"
echo "Configuração concluída. Por favor, reinicie o terminal."