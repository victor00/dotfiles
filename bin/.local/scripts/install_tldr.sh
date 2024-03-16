#!/bin/bash

if ! command -v tldr &> /dev/null; then
    echo "Instalando tldr..."
    sudo apt install -y tldr
else
    echo "tldr já está instalado."
fi
