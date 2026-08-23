# Migração do ambiente existente

A árvore antiga permanece intacta durante a primeira fase. A configuração nova vive em `config/` e os arquivos reais do `$HOME` não são substituídos automaticamente.

## Ordem

1. Rode `make doctor` e salve o inventário sem valores sensíveis.
2. Rode `make check`.
3. Teste links em `DOTFILES_TARGET_HOME` temporário.
4. Compare módulos novos com o comportamento do shell ativo.
5. Atualize Neovim para release estável `>= 0.11.2`.
6. Teste LazyVim com diretórios XDG temporários.
7. Valide Zellij e layouts.
8. Rode `scripts/link-config` e trate cada conflito individualmente.
9. Só então use `--apply --backup`.
10. Confirme `~/.local/bin` no `PATH`, aplique os links de `dev`/`git-*` e execute
    `exec zsh` antes de testar `gst`, `z NOME`, `dev find NOME` e `git pr -h`.

mise será introduzido gradualmente. rbenv e NVM continuam funcionando enquanto cada projeto é testado.
