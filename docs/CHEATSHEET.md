# Cheatsheet essencial

Os 30 comandos de maior uso diário. Para o manual completo, execute
`dev-help --interactive` ou consulte [DAILY-HELP.md](DAILY-HELP.md).

| # | Comando | Para que serve | Ajuda |
|---:|---|---|---|
| 1 | `make doctor` | Diagnostica ferramentas e links | `make help` |
| 2 | `scripts/link-config` | Mostra plano de links/conflitos | `scripts/link-config --help` |
| 3 | `make check` | Valida shell, Zsh, Lua e whitespace | `make help` |
| 4 | `exec zsh` | Recarrega o shell e configurações | `dev-help shell` |
| 5 | `dev-help --interactive` | Abre o manual pesquisável | `dev-help --help` |
| 6 | `z NOME` | Entra em diretório por histórico/nome | `zoxide --help` |
| 7 | `dev project NOME` | Localiza um repositório | `dev --help` |
| 8 | `dev find NOME` | Localiza arquivo ou pasta | `dev --help` |
| 9 | `gst` | Mostra status Git compacto | `dev-help git` |
| 10 | `git pr` | Abre PR ou página do repositório | `git pr -h` |
| 11 | `git root` | Imprime a raiz do repositório | `git root -h` |
| 12 | `git recent 10` | Lista branches recentes | `git recent -h` |
| 13 | `git cleanup-preview` | Lista branches merged sem excluir | `git cleanup-preview -h` |
| 14 | `lg` | Abre LazyGit | `lazygit --help` |
| 15 | `nvim .` / `lazyvim .` | Abre o projeto no LazyVim | `dev-help lazyvim` |
| 16 | `code .` | Abre o projeto no VS Code | `code --help` |
| 17 | `zja NOME` | Cria/anexa sessão Zellij | `dev-help zellij` |
| 18 | `dev kube` | Mostra contexto Kubernetes local | `dev-help kubernetes` |
| 19 | `k9s` | Abre navegador Kubernetes TUI | `k9s help` |
| 20 | `docker compose up -d` | Inicia serviços locais | `dev-help docker` |
| 21 | `dev status` | Consulta status oficial de serviços | `dev-help status` |
| 22 | `dev localhost` | Lista portas/processos locais | `dev-help ports` |
| 23 | `dev port 3000` | Inspeciona uma porta | `dev-help ports` |
| 24 | `dev docs COMANDO` | Abre manpage ou tldr | `dev-help docs` |
| 25 | `db` | Abre Rainfrog e seleciona conexão | `dev-help database` |
| 26 | `db configure` | Edita conexões privadas | `db --help` |
| 27 | `psql -d BANCO` | Abre PostgreSQL diretamente | `psql --help` |
| 28 | `http GET :3000/health` | Faz requisição HTTP | `dev-help api` |
| 29 | `jq . arquivo.json` | Consulta/formata JSON | `dev-help json` |
| 30 | `Ctrl-R` / `Alt-R` | Busca rica do Warp / histórico Zsh com fzf | `dev-help shell` |

Comandos marcados como preview/leitura não alteram recursos. Antes de operações Git,
Docker, Kubernetes, banco ou infraestrutura que escrevam estado, revise alvo e diff.
