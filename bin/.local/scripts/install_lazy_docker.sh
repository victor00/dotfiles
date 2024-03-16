#!/bin/bash

# Verificar se Lazy Docker está instalado
if ! command -v lazydocker > /dev/null; then
    echo "Instalando Lazy Docker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
    echo "Lazy Docker já está instalado."
fi

