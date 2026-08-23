# Arquitetura do ambiente

```text
Ghostty
└── Zellij
    ├── Zsh + Starship
    ├── LazyVim, VS Code ou Cursor
    ├── LazyGit
    ├── Rails console
    ├── logs
    └── testes
```

## Responsabilidades

- **Ghostty** renderiza o terminal, fornece integração com o shell e pode organizar
  superfícies em abas GTK. Cada superfície continua executando o cliente Zellij.
- **Zellij** é o único multiplexador. Controla sessões, abas, painéis, layouts e
  restauração quando disponível.
- **Zsh** é o shell interativo; **Starship** é somente o prompt. Seu tema
  Catppuccin Mocha usa detecção local do projeto e não consulta clusters.
- **LazyVim, VS Code e Cursor** são editores. Nenhum deles assume a função de
  multiplexador.
- **LazyGit** concentra a interface Git. Git CLI continua disponível para scripts e
  operações pontuais.
- **Comandos em `bin/`** formam uma camada pequena e descobrível. O Git encontra
  `git-*` pelo `PATH`; `dev` localiza projetos e caminhos sem manter índice próprio.
- **Claude, Cursor e Codex** são agentes de desenvolvimento. Autenticação e contexto
  enviado ficam fora dos dotfiles.

## Regras de integração

1. O Ghostty reserva `Ctrl-Shift-T`, `Ctrl-Shift-W`, `Ctrl-PageDown` e `Ctrl-PageUp`
   para superfícies/abas nativas. Os atalhos modais e panes continuam no Zellij.
2. O Zellij nunca é iniciado quando a sessão já possui `ZELLIJ`, em SSH, shell não
   interativo, terminal integrado ou `TERM=dumb`.
3. A inicialização automática continua opt-in por `DOTFILES_AUTO_ZELLIJ=1`. Isso evita
   quebrar scripts e permite abrir um shell de recuperação.
4. Layouts fornecem terminais genéricos; não executam servidor, teste, migração ou
   comando de cluster automaticamente.
5. Starship não gerencia runtimes, diretórios, sessões ou aliases.
6. Ghostty seleciona JetBrainsMono Nerd Font para renderizar os símbolos do
   Starship, do `eza` e das interfaces TUI de forma consistente.
7. Helpers de Git validam repositório, remote, branch, dependências e autenticação
   antes de delegar ao Git ou GitHub CLI. Operações destrutivas nunca são implícitas.

Ao abrir o Ghostty, `command = zellij attach --create work` cria ou anexa a sessão
principal em cada superfície. As abas GTK são clientes visuais e não substituem as
sessões, layouts ou panes do Zellij. Uma sessão de recuperação pode ser aberta com
`ghostty -e zsh -l`; isso não configura outro multiplexador.
