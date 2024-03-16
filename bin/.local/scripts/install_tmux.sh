#!/bin/bash

# Verificar se tmux está instalado
if ! command -v tmux &> /dev/null; then
    echo "tmux não encontrado. Instalando..."
    sudo apt update && sudo apt install -y tmux
else
    echo "tmux já está instalado."
fi
