#!/bin/bash

# Verificar se scc está instalado
if ! command -v scc &> /dev/null; then
    echo "scc não encontrado. Instalando..."
    sudo snap install scc
else
    echo "scc já está instalado."
fi
