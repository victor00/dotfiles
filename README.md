# Dotfiles para Ubuntu

Ambiente modular e reproduzível para desenvolvimento no Ubuntu. Warp ou Ghostty
renderizam o terminal; Zellij é o único multiplexador; Zsh é o shell; Starship é o
prompt; LazyVim, VS Code e Cursor são os editores; LazyGit concentra o fluxo Git.

O perfil do Ghostty usa o tema One Dark Pro Mix, JetBrainsMono Nerd Font 13,
transparência leve e abas GTK. Cada nova superfície anexa à sessão principal `work`
do Zellij. O Starship usa Catppuccin Mocha e mostra contexto técnico apenas quando
relevante. No shell, `ls`, `ll` e `tree` usam `eza` quando ele está disponível.

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
dev-help git
```

Consulte [docs/DAILY-HELP.md](docs/DAILY-HELP.md) para o manual completo.

Recarregue o Ghostty com `Ctrl-Shift-,`. Para conferir os valores efetivos:

```bash
ghostty +show-config | rg 'theme|font-family|font-size|background-opacity'
```

## Usando Ghostty, LazyVim e VS Code

Abra o Ghostty pelo menu de aplicativos ou execute `ghostty`. A configuração padrão
abre/anexa a sessão Zellij `work`; `Ctrl-Shift-T` cria outra aba do Ghostty e os
atalhos `Ctrl-p` e `Ctrl-t` controlam panes e abas dentro do Zellij. Para uma sessão
sem Zellij, útil em recuperação, execute `ghostty -e zsh -l`.

No diretório de um projeto, escolha o editor sem mudar de ambiente:

```bash
cd ~/codigo/meu-projeto
nvim .                    # LazyVim no terminal atual
code .                    # VS Code no mesmo projeto
cursor .                  # Cursor, quando desejado
```

No LazyVim, `<leader>` é `Espaço`: `<leader><space>` localiza arquivos,
`<leader>/` pesquisa no projeto, `<leader>gg` abre o LazyGit e `<leader>?` mostra os
atalhos disponíveis. No VS Code, abra o terminal integrado com `` Ctrl-` ``; ele usa
o Zsh e o Starship, mas não inicia outro Zellij dentro do editor. Se o perfil não for
Zsh, use `Terminal: Select Default Profile`, escolha `zsh` e abra um terminal novo.

O prompt exibe diretório, Git e relógio sempre; runtimes e ferramentas de
infraestrutura aparecem somente em projetos detectados. Usuário/host aparecem
somente por SSH ou como root. Comandos acima de 1,5 s mostram a duração, e o símbolo
final fica azul em sucesso ou vermelho em erro.

### Comandos de fluxo diário

Os executáveis em `bin/git-*` viram subcomandos nativos do Git quando vinculados em
`~/.local/bin`: use `git pr`, `git root`, `git recent` e `git cleanup-preview`.
`git pr -h` lista as ações de PR disponíveis. Para projetos ainda não aprendidos
pelo zoxide, `dev project NOME` imprime o caminho e `z NOME` usa essa busca como
fallback. Configure raízes menores com `DEV_PROJECT_ROOTS=~/trabalho:~/pessoal`.
Na branch padrão, `git pr` abre a página principal do repositório em vez de procurar
um PR para `main`/`master`.
Para localizar nomes diretamente, use `dev find NOME`, `dev directory NOME` ou
`dev file NOME`; as buscas incluem diretórios ocultos, mas ignoram conteúdos `.git`.
Ao navegar com `z NOME`, uma confirmação verde mostra o diretório acessado; com
`NO_COLOR` definido, a mesma mensagem é exibida sem sequências de cor.

No shell, `gst` mostra o status Git e `..` sobe um diretório. Consulte exemplos e
cuidados em `dev-help git`.

## Segurança

Credenciais, tokens, chaves, kubeconfigs, `.env`, telemetria local e ambientes HTTP
privados não pertencem ao repositório. Dependências e testes específicos permanecem
em cada projeto. Leia [docs/SECURITY.md](docs/SECURITY.md).
