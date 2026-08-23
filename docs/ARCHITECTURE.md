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

- **Ghostty** renderiza o terminal e fornece integração com o shell. Splits, abas e
  sessões não são configurados nele.
- **Zellij** é o único multiplexador. Controla sessões, abas, painéis, layouts e
  restauração quando disponível.
- **Zsh** é o shell interativo; **Starship** é somente o prompt.
- **LazyVim, VS Code e Cursor** são editores. Nenhum deles assume a função de
  multiplexador.
- **LazyGit** concentra a interface Git. Git CLI continua disponível para scripts e
  operações pontuais.
- **Claude, Cursor e Codex** são agentes de desenvolvimento. Autenticação e contexto
  enviado ficam fora dos dotfiles.

## Regras de integração

1. O Ghostty não cria atalhos de abas ou splits que concorram com o Zellij.
2. O Zellij nunca é iniciado quando a sessão já possui `ZELLIJ`, em SSH, shell não
   interativo, terminal integrado ou `TERM=dumb`.
3. A inicialização automática continua opt-in por `DOTFILES_AUTO_ZELLIJ=1`. Isso evita
   quebrar scripts e permite abrir um shell de recuperação.
4. Layouts fornecem terminais genéricos; não executam servidor, teste, migração ou
   comando de cluster automaticamente.
5. Starship não gerencia runtimes, diretórios, sessões ou aliases.

Ao abrir o Ghostty, `command = zellij attach --create work` cria ou anexa a sessão
principal. Uma sessão de recuperação pode ser aberta explicitamente com
`ghostty -e zsh -l`; isso não configura outro multiplexador.
