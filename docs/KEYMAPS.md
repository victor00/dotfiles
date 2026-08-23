# Atalhos

## Ghostty

- Nova aba: `Ctrl-Shift-T`.
- Fechar superfície: `Ctrl-Shift-W`.
- Aba seguinte/anterior: `Ctrl-PageDown` / `Ctrl-PageUp`.
- Recarregar configuração: `Ctrl-Shift-,`.

As abas são superfícies do terminal; sessões, layouts e panes continuam no Zellij.

## Warp sem Zellij

- Dividir à direita/abaixo: `Ctrl-Shift-D` / `Ctrl-Shift-E`.
- Focar outro pane: `Ctrl-Alt-Setas`.
- Pane anterior/seguinte: `Ctrl-Shift-{` / `Ctrl-Shift-}`.
- Maximizar/restaurar pane: `Ctrl-Shift-Enter`.
- Fechar pane ativo: `Ctrl-Shift-W`.
- Nova aba: `Ctrl-Shift-T`.
- Paleta de comandos: `Ctrl-Shift-P`.
- Buscar comandos e outros itens: `Ctrl-R`; prefixe com `history:` ou `h:` para
  limitar ao histórico.
- Buscar apenas no histórico local do Zsh com `fzf`: `Alt-R`.
- Buscar Workflows: `Ctrl-Shift-R`.

Esses são atalhos nativos do Warp no Linux e não precisam do Zellij. Caso uma
versão ou keyset os altere, procure a ação pelo nome na paleta ou em
**Settings > Keyboard Shortcuts**.

Na busca do Warp, `Enter` insere o comando selecionado no editor para revisão; não
o executa automaticamente. No histórico `fzf`, `Ctrl-R` alterna a ordenação,
`Enter` insere e `Esc` cancela.

## Zellij

Consulte `dev-help zellij`. Navegação global usa `Alt-h/j/k/l`; o Neovim usa `Ctrl-h/j/k/l`, evitando disputa.

## LazyVim

- Ajuda: `<leader>h*`.
- APIs: `<leader>a*`.
- IA CLI: `<leader>i*`.
- Git: `<leader>g*`.

Use `<leader>?` para atalhos do buffer e `:map COMBINAÇÃO` para investigar conflitos. WhichKey apresenta os grupos registrados.
