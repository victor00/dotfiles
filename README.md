# Dotfiles para Ubuntu

Ambiente modular e reproduzível para desenvolvimento no Ubuntu. Warp ou Ghostty
renderizam o terminal; Zellij é o único multiplexador; Zsh é o shell; Starship é o
prompt; LazyVim, VS Code e Cursor são os editores; LazyGit concentra o fluxo Git.

## Início rápido

```bash
make doctor                    # diagnóstico sem alterações
./install.sh terminal          # plano de instalação
./install.sh --apply terminal  # aplica após confirmação
scripts/link-config            # mostra links e conflitos
scripts/link-config --apply    # cria somente links ausentes
make check                     # valida o repositório
```

Instalação e links são operações separadas e usam dry-run por padrão. Operações APT
pedem confirmação antes de `sudo`; destinos existentes nunca são sobrescritos sem a
opção explícita de backup. Veja [instalação](docs/INSTALL.md) e
[migração](docs/MIGRATION.md).

## Arquitetura

```text
Warp ou Ghostty
└── Zellij
    ├── Zsh + Starship
    ├── LazyVim / VS Code / Cursor
    ├── LazyGit
    ├── Rails console
    ├── logs
    └── testes
```

Zellij é o único multiplexador; não existe fallback para Tmux. As regras contra
inicialização recursiva estão em [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Estrutura

```text
bootstrap/   instaladores modulares e idempotentes
config/      configurações separadas por ferramenta
bin/         comandos para ~/.local/bin
scripts/     diagnóstico, links e validação
docs/        instalação, arquitetura, atalhos e ajuda diária
Makefile     interface curta para tarefas recorrentes
install.sh   entrada única dos grupos de instalação
```

## Ajuda para uso diário

```bash
dev-help
dev-help --interactive
dev-help rails
dev-help kubernetes
dev-help api
```

Consulte [docs/DAILY-HELP.md](docs/DAILY-HELP.md) para o manual completo.

## Segurança

Credenciais, tokens, chaves, kubeconfigs, `.env`, telemetria local e ambientes HTTP
privados não pertencem ao repositório. Dependências e testes específicos permanecem
em cada projeto. Leia [docs/SECURITY.md](docs/SECURITY.md).
