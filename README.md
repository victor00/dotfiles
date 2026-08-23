# Dotfiles para Ubuntu

Ambiente modular e reproduzível para desenvolvimento no Ubuntu. Warp ou Ghostty
renderizam o terminal; Zellij é o único multiplexador; Zsh é o shell; Starship é o
prompt; LazyVim, VS Code e Cursor são os editores; LazyGit concentra o fluxo Git.

O perfil do Ghostty usa o tema Atom One Dark, JetBrainsMono Nerd Font 13,
transparência leve e abas GTK. Cada nova superfície anexa à sessão principal `work`
do Zellij. O Starship usa uma paleta Operator baseada em One Dark — azul, laranja,
vermelho, verde e roxo, sem rosa — e mostra contexto técnico apenas quando
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

Consulte [docs/DAILY-HELP.md](docs/DAILY-HELP.md) para o manual completo ou abra o
[cheatsheet dos 30 comandos essenciais](docs/CHEATSHEET.md).

Se `command -v ghostty` não retornar caminho, instale-o primeiro no seu próprio
terminal (a senha sudo é digitada localmente):

```bash
./install.sh desktop
./install.sh --apply desktop
command -v ghostty || test -x /snap/bin/ghostty
```

Depois, abra “Ghostty” pelo menu de aplicativos ou execute `ghostty` (use
`/snap/bin/ghostty` antes de reiniciar a sessão caso o PATH ainda não tenha sido
atualizado). Recarregue a configuração com `Ctrl-Shift-,`. Para conferir os valores:

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
neovim .                  # nome alternativo para nvim
lazyvim .                 # nome alternativo para nvim
code .                    # VS Code no mesmo projeto
cursor .                  # Cursor, quando desejado
```

No LazyVim, `<leader>` é `Espaço`: `<leader><space>` localiza arquivos,
`<leader>/` pesquisa no projeto, `<leader>gg` abre o LazyGit e `<leader>?` mostra os
atalhos disponíveis. O perfil inclui extras sob demanda para símbolos, refatoração,
tarefas, testes, GitHub, REST, TypeScript/Tailwind e formatação/lint. No VS Code,
abra o terminal integrado com `` Ctrl-` ``; ele usa
o Zsh e o Starship, mas não inicia outro Zellij dentro do editor. Se o perfil não for
Zsh, use `Terminal: Select Default Profile`, escolha `zsh` e abra um terminal novo.

O prompt usa rótulos legíveis: `git:main`, `novos:1`, `modificados:1` e
`ruby:v3.4.4`, por exemplo. Diretório, Git e relógio aparecem sempre; runtimes e
ferramentas de infraestrutura aparecem somente em projetos detectados. Usuário/host aparecem
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
Enquanto você digita, comandos, funções e aliases válidos ficam verdes; comandos
inexistentes ficam vermelhos e caminhos ficam azuis. O realce é feito pelo
Zsh Syntax Highlighting carregado por último no `.zshrc`. Depois que `z NOME`
navega, uma linha verde `✓ /caminho` confirma o destino acessado.

No shell, `gst` mostra o status Git e `..` sobe um diretório. Consulte exemplos e
cuidados em `dev-help git`.

### Painel de operações no terminal

O comando `dev` oferece equivalentes leves aos widgets de desenvolvimento, usando
somente ferramentas de terminal e sem substituir GNOME, Ghostty ou Zellij:

```bash
dev kube                   # contexto Kubernetes local
dev kube --live            # nós e resumo dos pods
dev docs git               # manpage ou exemplos tldr
dev status                 # status oficial de serviços
dev localhost              # endpoints, portas e processos locais
dev port 3000              # processo que escuta na porta
dev open 3000              # abre http://localhost:3000
```

Use `dev-help kube`, `dev-help docs`, `dev-help status` e `dev-help ports` para
detalhes e limites de segurança. A saída segue Catppuccin e respeita `NO_COLOR`.

### Bancos no terminal

Rainfrog é o navegador principal e funciona fora de projetos Rails:

```bash
./install.sh database          # plano sem alterações
./install.sh --apply database  # instala versão fixada via Cargo, sem sudo
scripts/link-config --apply    # disponibiliza o comando db
db configure                   # configuração privada fora do Git
db                             # seleciona conexão e abre o TUI
db doctor
```

Para projetos próprios, use `db configure` e crie uma entrada sem senha em `[db]`.
Se o Docker publicar uma porta dinâmica, descubra-a com
`docker compose port SERVICO 5432` e passe a porta ao Rainfrog pela CLI. Detalhes e
um exemplo genérico estão em `dev-help database`.

PostgreSQL tem prioridade; MySQL e SQLite são suportados pelo mesmo binário, sem
wrappers adicionais. Veja conexões, navegação, SQL, histórico, favoritos e cuidados
de produção em `dev-help database`.

## Configuração em um PC novo

O fluxo abaixo importa estes dotfiles sem sobrescrever arquivos existentes e sem
presumir um caminho fixo para o clone.

1. Instale Git e clone o repositório:

   ```bash
   sudo apt-get update
   sudo apt-get install git
   git clone git@github.com:victor00/dotfiles.git ~/src/dotfiles
   cd ~/src/dotfiles
   ```

2. Faça o diagnóstico e revise todos os planos, ainda sem alterações:

   ```bash
   make doctor
   ./install.sh core
   ./install.sh terminal
   ./install.sh languages
   ./install.sh development
   ./install.sh database
   ./install.sh desktop
   scripts/link-config
   ```

3. Aplique somente os grupos desejados. Cada operação APT pede confirmação antes de
   usar sudo; grupos Cargo/binários escrevem no diretório do usuário:

   ```bash
   ./install.sh --apply core
   ./install.sh --apply terminal
   ./install.sh --apply languages
   ./install.sh --apply development
   ./install.sh --apply database
   ./install.sh --apply desktop
   ```

4. Revise conflitos antes dos links. Para uma máquina limpa, crie apenas destinos
   ausentes; em migração, use backup somente depois de conferir o dry-run:

   ```bash
   scripts/link-config
   scripts/link-config --apply
   # scripts/link-config --apply --backup  # somente para conflitos revisados
   exec zsh
   ```

5. Mantenha dados específicos da máquina fora do Git:

   ```bash
   nvim ~/.config/zsh/local.zsh
   nvim ~/.config/git/local.config
   db configure
   ```

   Não copie tokens, kubeconfigs, `.env`, senhas ou URLs de banco com credenciais
   para o repositório. Autentique `gh`, `gcloud` e outras CLIs pelos fluxos oficiais.

6. Valide o resultado:

   ```bash
   make doctor
   make check
   zsh -n ~/.zshrc
   nvim --headless '+checkhealth' '+qa'
   zellij setup --check
   db doctor
   command -v ghostty || test -x /snap/bin/ghostty
   ```

   Se o Ghostty recém-instalado não aparecer no menu ou no `PATH`, encerre e abra a
   sessão gráfica novamente. Até lá, `/snap/bin/ghostty` inicia o aplicativo.

Para testar links sem tocar no `$HOME`, use
`DOTFILES_TARGET_HOME=/tmp/dotfiles-home scripts/link-config --apply`. Consulte
[instalação](docs/INSTALL.md), [migração](docs/MIGRATION.md) e
[segurança](docs/SECURITY.md) antes de restaurar backups ou resolver conflitos.

## Referência rápida de ferramentas

| Ferramenta/comando | Para que serve | Exemplo | Ajuda |
|---|---|---|---|
| `dev-help` | Manual diário pesquisável | `dev-help git` | `dev-help --help` |
| Zsh + Starship | Shell e prompt contextual | `exec zsh` | `dev-help shell` |
| Zellij | Sessões, abas e panes | `zja projeto` | `dev-help zellij` |
| Ghostty | Terminal gráfico | `ghostty` | `ghostty +show-config` |
| zoxide | Navegação por frequência/nome | `z orchestrator` | `zoxide --help` |
| `dev project/find` | Localiza projetos, pastas e arquivos | `dev project api` | `dev --help` |
| fd | Busca arquivos rapidamente | `fd controller app` | `fd --help` |
| ripgrep (`rg`) | Busca texto em projetos | `rg 'TODO|FIXME'` | `rg --help` |
| eza | Lista arquivos com Git/ícones | `ll` | `eza --help` |
| bat | Exibe arquivos com syntax highlight | `bat README.md` | `bat --help` |
| fzf | Seleção interativa | `Ctrl-R` | `fzf --help` |
| Git | Controle de versão | `gst` | `dev-help git` |
| `git pr` | Abre/inspeciona PR da branch | `git pr --checks` | `git pr -h` |
| LazyGit | Interface Git TUI | `lg` | `lazygit --help` |
| GitHub CLI | PRs, issues e checks | `gh pr checks` | `gh help` |
| LazyVim | Editor principal no terminal | `nvim .` | `dev-help lazyvim` |
| VS Code/Cursor | Editores gráficos | `code .` | `code --help` |
| Docker Compose | Serviços locais | `docker compose up -d` | `dev-help docker` |
| kubectl/k9s/Helm | Operação Kubernetes | `dev kube` | `dev-help kubernetes` |
| Terraform/GCloud | Infraestrutura e cloud | `terraform plan` | `dev-help infrastructure` |
| `dev status` | Status público de provedores | `dev status github` | `dev-help status` |
| `dev ports` | Portas e processos locais | `dev port 3000` | `dev-help ports` |
| curl/HTTPie | Requisições HTTP | `http GET :3000/health` | `dev-help api` |
| jq/yq | Consulta JSON/YAML | `jq '.items[]' file.json` | `dev-help json` |
| Rainfrog | Navegador SQL TUI | `db` | `dev-help database` |
| psql | Cliente PostgreSQL direto | `psql -d postgres` | `psql --help` |
| ShellCheck/shfmt | Validação de shell | `make check` | `shellcheck --help` |

Use `dev-help --list` para todas as categorias e `dev-help --interactive` para
selecioná-las com fzf.

## Segurança

Credenciais, tokens, chaves, kubeconfigs, `.env`, telemetria local e ambientes HTTP
privados não pertencem ao repositório. Dependências e testes específicos permanecem
em cada projeto. Leia [docs/SECURITY.md](docs/SECURITY.md).
