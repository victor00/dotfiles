#!/bin/bash

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