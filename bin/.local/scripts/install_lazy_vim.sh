#!/bin/bash

# Instalar Neovim se não estiver instalado
if ! command -v nvim &> /dev/null; then
    echo "Neovim não encontrado. Instalando..."
    sudo apt install -y neovim
else
    echo "Neovim já está instalado."
fi

# Verificar se a versão do Neovim é >= 0.9.0
NEOVIM_VERSION=$(nvim --version | head -n1 | grep -oP "\d+\.\d+\.\d+")
if dpkg --compare-versions "$NEOVIM_VERSION" "lt" "0.9.0"; then
    echo "A versão do Neovim instalada é inferior a 0.9.0. Por favor, atualize o Neovim."
    exit 1
fi

# Verificar e instalar Git se necessário
if ! command -v git &> /dev/null || [ $(git --version | grep -oP '\d+\.\d+\.\d+' | head -n1 | cut -d. -f1) -lt 2 ] || [ $(git --version | grep -oP '\d+\.\d+\.\d+' | head -n1 | cut -d. -f2) -lt 19 ]; then
    echo "Git não encontrado ou versão não suportada. Instalando a versão mais recente..."
    sudo apt install -y git
else
    echo "Git já está instalado e atualizado."
fi

# Instalar compilador C (build-essential)
if ! command -v gcc &> /dev/null; then
    echo "Compilador C não encontrado. Instalando..."
    sudo apt install -y build-essential
else
    echo "Compilador C já está instalado."
fi

# Instalar fonte Fira Code
if ! fc-list | grep -i "FiraCode" &> /dev/null; then
    echo "Fonte Fira Code não encontrada. Instalando..."
    sudo apt install -y fonts-firacode
else
    echo "Fonte Fira Code já está instalada."
fi

# Instalar LazyVim se não estiver instalado
if [ ! -d "${HOME}/.config/nvim" ]; then
    echo "LazyVim não encontrado. Instalando..."
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.sh)
else
    echo "LazyVim já está instalado."
fi