#!/bin/bash

# Verificar se zoxide está instalado
if ! command -v zoxide &> /dev/null; then
    echo "zoxide não encontrado. Instalando..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo "zoxide já está instalado."
fi

# Verificar se fzf está instalado
if ! command -v fzf &> /dev/null; then
    echo "fzf não encontrado. Instalando..."
    # Insira aqui o método de instalação do fzf apropriado para o seu sistema
    # Por exemplo, em sistemas baseados em Debian/Ubuntu:
    sudo apt install fzf
    # Para outras distribuições ou sistemas, substitua o comando acima conforme necessário
else
    echo "fzf já está instalado."
fi
