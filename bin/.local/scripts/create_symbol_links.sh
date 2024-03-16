#!/bin/bash

# Criar links simbólicos para o .zshrc e outros arquivos necessários
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig