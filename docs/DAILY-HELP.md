# Ajuda diária do ambiente de desenvolvimento

Este é o manual operacional e a fonte de conteúdo do comando `dev-help`. Ferramentas marcadas como opcionais não são presumidas como instaladas. Comandos marcados com **ALTERA ESTADO** exigem atenção.

## Índice

- [Shell e terminal](#shell)
- [Navegação e arquivos](#files)
- [Git](#git)
- [Zellij](#zellij)
- [LazyVim](#lazyvim)
- [Ruby e Rails](#rails)
- [Go](#go)
- [Python](#python)
- [Java](#java)
- [APIs](#api)
- [Documentação local](#docs)
- [Status de serviços](#status)
- [Portas locais](#ports)
- [Bancos de dados](#database)
- [Containers](#docker)
- [Kubernetes](#kubernetes)
- [Infraestrutura](#infrastructure)
- [IA](#ai)

<!-- dev-help:shell -->
## Shell e terminal {#shell}

Finalidade: Ghostty ou Warp renderizam o terminal; Zsh fornece o shell modular, e Starship somente o prompt. Zellij cuida das sessões persistentes; Warp pode cuidar de panes simples nativamente.

- O tema `Atom One Dark` é um recurso incluído no Ghostty Snap 1.3.1; nomes de temas
  externos não são presumidos em instalações novas.

- Configuração: `config/ghostty/`, `config/zsh/` e `config/starship/`.
- Tema do Warp: `config/warp/`, vinculado em
  `~/.local/share/warp-terminal/themes/operator-hacker.yaml`; selecione
  `Operator Hacker` em Appearance > Current Theme e confirme no check. Panes
  nativos: `Ctrl-Shift-D/E`, foco com `Ctrl-Alt-Setas`, maximizar com
  `Ctrl-Shift-Enter` e fechar com `Ctrl-Shift-W`.
- Ghostty usa abas GTK para superfícies; Zellij continua responsável por sessões,
  layouts e panes dentro de cada superfície.
- Ghostty abre `zellij attach --create work`; recuperação: `ghostty -e zsh -l`.
- Ghostty: `Ctrl-Shift-T` nova aba, `Ctrl-Shift-W` fecha superfície,
  `Ctrl-PageDown/PageUp` navega e `Ctrl-Shift-,` recarrega a configuração.
- JetBrainsMono Nerd Font usa peso Bold, ligaturas de código e zero diferenciado;
  cursor de bloco laranja e padding compacto mantêm leitura e densidade.
- A JetBrainsMono Nerd Font fornece os ícones de arquivos; o prompt usa rótulos
  textuais para não depender de símbolos ambíguos.
- Ghostty, Starship e o realce do Zsh compartilham uma paleta Operator baseada em
  One Dark: azul `#61AFEF`, laranja vivo `#FF6B00`, vermelho `#E06C75`, verde
  `#98C379` e violeta `#6D5BD0`. Slots magenta do terminal são remapeados para
  laranja/violeta, sem rosa.
- No prompt Starship, o diretório usa violeta profundo `#6D5BD0`, a branch Git usa azul
  escuro `#4B8FCC` e o estado Git usa amarelo forte `#FFB000`; o laranja vivo
  `#FF6B00` destaca o cursor, os acentos e comandos válidos digitados. No Warp, o
  Operator Hacker usa o gradiente vertical do Cyber Wave, de `#002633` a `#000000`;
  Ghostty preserva o fundo preto-azulado `#0B0F14`.
- Exemplos: `git:main`, `untracked:1`, `modified:1`, `staged:1` e
  `ruby:v3.4.4`. `untracked` significa arquivos ainda não rastreados pelo Git.
- Usuário/host aparecem somente em SSH ou como root. Runtimes, Docker, Kubernetes,
  Helm e Terraform são exibidos apenas quando o diretório tem contexto compatível.
- Atualização: pelo grupo `make install-terminal`, após revisar o plano exibido.
- Desabilitar integração: comente o módulo correspondente ou use `local.zsh` fora do Git.
- Zellij automático é opt-in com `DOTFILES_AUTO_ZELLIJ=1`.
- O fzf detecta capacidades; versões antigas usam os scripts de integração do Ubuntu.
- A inicialização interativa esperada nesta máquina é próxima de `0,10 s`; meça com
  `/usr/bin/time zsh -i -c exit` antes de adicionar integrações globais.

Comandos:

```bash
exec zsh                 # inicia uma sessão nova sem source duplicado
z nome                   # navega por frequência com zoxide
zi                       # seleção interativa de diretório
Ctrl-R                   # busca rica do Warp; use history: ou h: para comandos
Alt-R                    # histórico local/compartilhado do Zsh via fzf
Ctrl-Shift-R             # Workflows no Warp
dev-help --interactive   # ajuda pesquisável
nvim .                   # abre o projeto no LazyVim
neovim .                 # alias legível para nvim
lazyvim .                # alias legível para nvim
code .                   # abre o projeto no VS Code
warp-terminal            # abre o Warp; Ctrl-Shift-P mostra todas as ações
```

No terminal integrado do VS Code, use `` Ctrl-` ``. Se necessário, selecione Zsh em
`Terminal: Select Default Profile`; a proteção do shell impede iniciar outro Zellij
dentro do editor.

Problemas comuns: rode `zsh -n ~/.zshrc` para sintaxe e `make doctor` para dependências. Configuração privada pertence a `~/.config/zsh/local.zsh`.

O histórico mantém até 100 mil entradas, compartilha comandos entre shells e
remove duplicatas. Comandos iniciados por espaço não são salvos. O Warp mantém
metadados próprios por sessão; ao fechar panes ele combina o histórico, enquanto
`Alt-R` consulta imediatamente o arquivo local do Zsh. Nenhuma das buscas executa a
seleção automaticamente.
<!-- /dev-help -->

<!-- dev-help:database -->
## Bancos de dados {#database}

Rainfrog é o navegador TUI independente de framework. PostgreSQL é prioridade;
MySQL e SQLite usam o suporte nativo do mesmo binário. Conexões, senhas, histórico,
favoritos e exports ficam fora do repositório.

```bash
db                       # seleciona conexão e abre o Rainfrog
db configure             # cria/edita configuração privada
db doctor                # versões e caminhos, sem mostrar credenciais
db reenter-password      # solicita novamente a senha da conexão escolhida
db -- --help             # ajuda nativa do Rainfrog
dev-help database
```

Para cadastrar um banco de projeto, rode `db configure` e adicione uma entrada sem
senha:

```toml
[db]
meu-projeto = { host = "localhost", driver = "postgres", port = 5432, database = "app_development", username = "postgres" }
```

Quando o Docker Compose publicar uma porta dinâmica, descubra a porta do host e abra
o Rainfrog sem salvar credenciais:

```bash
docker compose port SERVICO_POSTGRES 5432
db -- --driver postgres --username USUARIO --host 127.0.0.1 --port PORTA --database BANCO
```

Mantenha atalhos específicos de trabalho em `~/.config/zsh/local.zsh`, que fica fora
do Git. O wrapper não inicia containers nem servidores automaticamente.

Fluxo inicial:

1. Rode `db configure` e ajuste o bloco `postgres-local` sem gravar senha.
2. Rode `db`; selecione a conexão e informe a senha no prompt/keyring do Rainfrog.
3. Use `Alt-1` a `Alt-5` para menu, SQL, resultados, histórico e favoritos; `Tab`
   também alterna o foco.
4. Navegue schemas/tabelas no menu, filtre pelo nome, abra metadados e escreva SQL
   no editor. `Ctrl-Space` força autocomplete.
5. Exporte/copiei resultados somente pela ação explícita no painel de resultados.

Evite contas de produção com permissão de escrita. Prefira usuário read-only e nunca
coloque senha ou URL com credencial no arquivo versionado, histórico do shell ou
linha de comando.
<!-- /dev-help -->

<!-- dev-help:docs -->
## Documentação local {#docs}

`dev docs` consulta primeiro manuais já instalados e usa tldr como fallback para
exemplos práticos. A pesquisa não envia código, arquivos ou contexto do projeto.

```bash
dev docs git             # manual local; tldr quando não houver manpage
dev docs kubectl
dev docs --search archive # pesquisa descrições das manpages com apropos
```
<!-- /dev-help -->

<!-- dev-help:status -->
## Status de serviços {#status}

Consulta endpoints públicos oficiais com timeout curto, sem token e sem alterar
serviços. Uma falha de rede aparece como `unavailable`, não como indisponibilidade
confirmada do provedor.

```bash
dev status               # GitHub, Cloudflare, npm, OpenAI e Docker
dev status github        # somente um serviço
dev status openai
```
<!-- /dev-help -->

<!-- dev-help:ports -->
## Portas e servidores locais {#ports}

```bash
dev localhost            # endpoints, portas e processos que estão escutando
dev ports                # equivalente explícito
dev port 3000            # detalhes de uma porta
dev open 3000            # abre http://localhost:3000; ALTERA ESTADO da interface
```

Processos de outros usuários podem aparecer como `unknown` sem privilégios. A lista
não presume que toda porta fale HTTP. Nenhum comando encerra processos; `dev open`
confirma que há um listener e só então abre HTTP quando chamado diretamente.
<!-- /dev-help -->

<!-- dev-help:shortcuts -->
## Shortcuts by context {#shortcuts}

### Kubernetes

```bash
kwhere                   # show the current context and namespace
kctx                     # show the current context
kcontexts                # list configured contexts
kuse                     # select a context with fzf; CHANGES local state
knuse                    # select a namespace with fzf; CHANGES local state
k                        # kubectl
kgp                      # kubectl get pods
kgpa                     # list pods across all namespaces
klf POD                  # follow pod logs
k9                       # open k9s
```

`kuse` and `knuse` require `kubectl` and `fzf`. `kuse` switches context as soon as
one is selected; `knuse` asks for confirmation and queries namespaces from the
cluster.

### Git

```bash
g                        # git
gs                       # show compact status with branch
ga FILE                  # stage a file
gaa                      # stage all changes
gc                       # create a commit
gd                       # show unstaged changes
gds                      # show staged changes
gf                       # fetch remotes and prune stale references
glog                     # show compact graph history
lg                       # open Lazygit
croot                    # go to the current repository root
```

### Docker

```bash
d                        # docker
dc                       # docker compose
dps                      # show containers, status, and ports as a table
dlogs                    # follow recent Compose logs
```

### Navigation and terminal

```bash
mkcd project             # create and enter a directory
port 3000                # show the listener without stopping processes
zja project              # create or attach to a Zellij session
zjl api my-api           # start the api layout in the given session
```

To inspect how any shortcut is defined in Zsh:

```bash
type kuse                 # describe what the shortcut does
whence -v kgp             # identify an alias, function, or executable
alias                     # list all loaded aliases
```

For documented dotfiles shortcuts, `type NAME` prints a concise English
description. For other commands and options, it keeps the standard Zsh behavior.

This topic is also available through `dev-help aliases` or `dev-help commands`.
<!-- /dev-help -->

<!-- dev-help:files -->
## Navegação e arquivos {#files}

- `fd`: encontra arquivos; no Ubuntu, `fdfind` recebe alias somente se `fd` não existir.
- `rg`: busca conteúdo respeitando `.gitignore`.
- `bat`: visualiza arquivos com syntax highlight.
- `eza`: substituição opcional e moderna para listagem.
- `jq`: JSON; `yq` v4: YAML. O yq v3 atual deve ser atualizado antes de usar exemplos v4.

```bash
fd controller app/
rg 'TODO|FIXME' --glob '*.rb'
bat config/routes.rb
ls                        # eza com ícones automáticos
ll                        # detalhes, ocultos e estado Git
tree                      # árvore com ícones automáticos
jq '.items[] | .metadata.name' response.json
yq '.services | keys' docker-compose.yml
```
<!-- /dev-help -->

<!-- dev-help:tools -->
## Ferramentas e instalação

```bash
make doctor               # instalado, ausente e conflitos de links
./install.sh terminal     # plano, sem alterações
./install.sh --apply core # solicita confirmação antes de sudo/apt
make check                # sintaxe, ShellCheck e whitespace
```

Os instaladores mostram finalidade, origem, versão e atualização antes de agir. Binários upstream precisam de versão e checksum revisados; não há `curl | sh`.
<!-- /dev-help -->

<!-- dev-help:git -->
## Git e LazyGit {#git}

- Git: `config/git/.gitconfig`; identidade privada: `~/.config/git/local.config`.
- LazyGit: `config/lazygit/.config/lazygit/config.yml`.
- GitHub CLI usa autenticação própria; tokens não ficam nos dotfiles.

```bash
gs                        # status compacto
gst                       # status compacto (forma fácil de lembrar)
gco nome-da-branch        # entra em uma branch
gd                        # diff não staged
gds                       # diff staged
lg                        # abre LazyGit
git pr                    # abre o PR; na branch padrão abre o repositório
git pr --url              # imprime a URL do PR
git pr --status           # detalhes do PR
git pr --checks           # checks do PR
git pr --diff             # diff do PR
git pr --comments         # PR e comentários
git pr --create           # inicia a criação guiada pelo gh
git root                  # imprime a raiz do repositório
git recent 10             # branches locais atualizadas recentemente
git cleanup-preview       # lista branches merged; nunca apaga
dev project orchestrator  # encontra o projeto; `z` também usa esse fallback
dev find orchestrator     # localiza arquivos e pastas pelo nome
dev directory orchestrator # localiza somente pastas
dev file application.rb   # localiza somente arquivos
z orchestrator            # acessa por histórico ou busca pelo nome
```

Antes de executar, comandos, aliases e funções reconhecidos pelo Zsh aparecem em
verde; comandos inexistentes aparecem em vermelho e caminhos em azul. Assim, o `z`
de `z orchestrator` fica verde enquanto o argumento permanece legível. Depois da
navegação, `✓ /caminho` confirma em verde que o destino foi acessado.

`git reset --hard`, force push e descarte no LazyGit podem perder trabalho. Revise alvo e diff antes.
<!-- /dev-help -->

<!-- dev-help:zellij -->
## Zellij {#zellij}

Finalidade: multiplexador principal. Configuração em `config/zellij/.config/zellij/`.

```text
Normal:   Ctrl-p pane | Ctrl-t tab | Ctrl-r resize | Ctrl-s scroll | Ctrl-o session
Pane:     h/j/k/l foco | n novo | d abaixo | r direita | f fullscreen | w floating
Resize:   h/j/k/l aumenta | H/J/K/L diminui
Tab:      h/l anterior/próxima | n nova | r renomeia | 1..5 seleciona
Scroll:   j/k | d/u meia página | Ctrl-f/Ctrl-b página | e editar scrollback
Session:  d detach | w session manager
Lock:     Ctrl-y trava/destrava (Ctrl-g fica reservado para focar o Codex)
Global:   Alt-h/j/k/l navega | Alt-f floating | Alt-? ajuda
```

```bash
zja projeto               # anexa/cria sessão
zjl general projeto       # layout geral
zjl rails app             # Rails sem iniciar comandos automaticamente
zjl api service-api       # API sem assumir servidor ou coleção
zjl kubernetes infra      # terminais neutros, sem alterar cluster
zjl docker containers     # workspace Docker/Compose sem iniciar serviços
zellij list-sessions
```

Sessões são serializadas, mas comandos ressuscitados exigem confirmação. `zellij delete-session` remove estado de sessão.
<!-- /dev-help -->

<!-- dev-help:lazyvim -->
## LazyVim {#lazyvim}

Configuração: `config/nvim/.config/nvim`. Requer Neovim estável `>= 0.11.2`.

```text
<leader><space> arquivos       <leader>/ busca no projeto
<leader>fb buffers             <leader>xx diagnósticos
gd definição                  gr referências
K documentação                <leader>cf formatação
<leader>gg LazyGit             <leader>gb blame
<leader>gi issues GitHub       <leader>gp pull requests GitHub
<leader>cs símbolos            <leader>cn gerar documentação
<leader>ow lista de tarefas    <leader>oo executar tarefa
<leader>rs refatorar           <leader>fp projetos
<leader>tt teste próximo       <leader>tf arquivo de testes
<leader>db breakpoint          <leader>dc continuar debug
<leader>? keymaps do buffer    :checkhealth
```

Extras selecionados incluem Mini Surround/Move, Neogen, Aerial, Overseer,
Refactoring, Tree-sitter Context, Octo, Project, REST/Kulala, Prettier, ESLint,
TypeScript VTSLS e Tailwind. Eles são carregados sob demanda; atalhos específicos de
REST (`<leader>R`) aparecem em arquivos `.http`, e contexto Tree-sitter somente em
buffers compatíveis.

Ajuda: `<leader>hh`; Kubernetes `<leader>hk`; Rails `<leader>hr`; APIs `<leader>ha`; Zellij `<leader>hz`. Recursos pesados: `NVIM_DISABLE_AI=1`, `NVIM_DISABLE_DAP=1` ou `NVIM_DISABLE_TESTS=1`.
<!-- /dev-help -->

<!-- dev-help:rails -->
## Ruby e Rails {#rails}

Runtime pertence ao projeto (`.ruby-version`/mise); gems pertencem ao Bundler. LazyVim fornece Ruby LSP, RuboCop, testes e vim-rails.

```bash
bundle install
bundle exec rspec spec/requests/example_spec.rb # executa o spec indicado
bundle exec rspec                               # suíte; pode ser demorada
bundle exec rubocop                             # lint
bin/rails console                               # console da aplicação
bin/rails db:migrate                            # ALTERA ESTADO do banco
bundle exec sidekiq                             # worker; depende do projeto/Redis
```

Em Docker Compose, descubra primeiro o serviço com `docker compose config --services`; não é presumido que ele se chame `app`.
<!-- /dev-help -->

<!-- dev-help:go -->
## Go {#go}

gopls fornece LSP; gofumpt/goimports formatam; golangci-lint analisa; Delve depura.

```bash
go run ./cmd/server
go test ./...
go test -run TestName ./path/to/package
gofumpt -w file.go          # ALTERA o arquivo
golangci-lint run
dlv test ./path/to/package
```
<!-- /dev-help -->

<!-- dev-help:python -->
## Python {#python}

uv é o fluxo preferido quando o projeto o utiliza; Poetry e venv continuam detectáveis. basedpyright faz type checking, Ruff lint/formatação, pytest testes e debugpy debugging.

```bash
uv sync
uv run pytest
uv run pytest tests/test_api.py::test_health
uv run ruff check .
uv run ruff format .        # ALTERA arquivos
python3 -m venv .venv
```
<!-- /dev-help -->

<!-- dev-help:java -->
## Java {#java}

JDTLS fornece LSP/debug/test. Maven ou Gradle devem vir do projeto, preferencialmente pelos wrappers.

```bash
./mvnw test
./mvnw spring-boot:run
./gradlew test
./gradlew bootRun
```

Java 11 está instalado atualmente; respeite a versão definida pelo projeto antes de executar builds Spring Boot.
<!-- /dev-help -->

<!-- dev-help:api -->
## APIs {#api}

- Bruno: exploração visual e coleções mantidas pelo projeto.
- Kulala/`.http`: requisições rápidas dentro do Neovim.
- HTTPie: chamadas legíveis no terminal.
- curl: diagnóstico universal e scripts.
- grpcurl: serviços gRPC.
- Playwright, Schemathesis e k6: pertencem ao projeto, não aos dotfiles.

```bash
curl -fsS http://localhost:3000/health | jq .
http GET http://localhost:3000/health
grpcurl HOST:50051 list
bru run api/bruno             # somente em coleção existente
```

No Neovim: `<leader>ah` executa request, `<leader>ab` abre Bruno, `<leader>ag` mostra ajuda gRPC e `<leader>aa` mostra esta ajuda.
<!-- /dev-help -->

<!-- dev-help:bruno -->
## Bruno

Cliente visual principal para explorar APIs. Desktop e CLI são opcionais e instalados separadamente. Cada projeto pode manter:

```text
api/bruno/
├── bruno.json
├── environments/
├── health/
├── authentication/
└── resources/
```

Esse diretório não é criado pelos dotfiles. Tokens, cookies e ambientes privados ficam fora do Git. `bru run` executa uma coleção existente e pode chamar APIs mutáveis.
<!-- /dev-help -->

<!-- dev-help:http -->
## HTTP e arquivos `.http`

Kulala é o único cliente HTTP no Neovim. Use `###` entre requests e `{{VARIABLE}}` para variáveis. Valores privados pertencem a `http-client.private.env.json`, ignorado no projeto.

```http
GET http://localhost:3000/health
Accept: application/json
```

Antes de executar POST/PUT/PATCH/DELETE, confirme host e ambiente.
<!-- /dev-help -->

<!-- dev-help:grpc -->
## gRPC

grpcurl é opcional. Reflection precisa estar habilitado ou devem ser fornecidos protos do projeto.

```bash
grpcurl HOST:50051 list
grpcurl HOST:50051 describe package.Service
grpcurl -plaintext -d '{"id":"123"}' HOST:50051 package.Service/Get
```

Chamadas RPC podem alterar estado; confira o método antes.
<!-- /dev-help -->

<!-- dev-help:websocket -->
## WebSocket

Kulala suporta `WS` em arquivos `.http`. Para terminal, `websocat` é opcional:

```bash
websocat ws://localhost:3000/cable
```

Use apenas quando interação fora do editor trouxer ganho; não é dependência obrigatória.
<!-- /dev-help -->

<!-- dev-help:json -->
## JSON, YAML e payloads

```bash
jq . response.json
jq -r '.items[].id' response.json
yq '.services' compose.yml
curl -fsS URL | jq .
```

`jq` não altera arquivos sem redirecionamento. Confirme que o yq instalado é v4 antes de usar a sintaxe documentada.
<!-- /dev-help -->

<!-- dev-help:docker -->
## Docker e Docker Compose {#docker}

Instalação e atualização são idempotentes e usam o repositório APT oficial. O plano
é o padrão; `--apply` pede confirmação antes de APT, configuração do daemon ou
reinício. A configuração mescla as chaves existentes com GC do BuildKit em `20GB`
e rotação de logs `json-file` em `10m`, três arquivos. Opções novas de log valem
para containers criados depois da mudança.

```bash
make install-docker                   # mostra o plano, sem alterar o sistema
./install.sh --apply docker           # instala/atualiza após confirmação
docker-dev doctor                     # versões, acesso, daemon e uso de disco
docker-dev cleanup                    # preview conservador
docker-dev cleanup --apply            # sem volumes e sem imagens nomeadas
docker-dev test                       # smoke tests descartáveis de Engine/Compose
zjl docker containers                 # sessão Docker no Zellij
docker compose up                    # inicia serviços em foreground
docker compose up -d                 # inicia em background
docker compose logs -f               # acompanha logs
docker compose exec app bash         # shell; confirme o nome do serviço
docker compose config --services     # lista serviços
docker compose down                  # ALTERA ESTADO
```

`docker compose down -v`, `docker volume prune` e `docker system prune --volumes`
podem apagar bancos locais. O `docker-dev cleanup` nunca remove volumes. Pertencer
ao grupo `docker` equivale a conceder privilégios administrativos; após inclusão,
abra uma nova sessão de login ou use `newgrp docker` conscientemente.
<!-- /dev-help -->

<!-- dev-help:kubernetes -->
## Kubernetes {#kubernetes}

Comandos de leitura:

```bash
dev kube                         # contexto local, sem consultar o cluster
dev kube contexts                # contextos configurados
dev kube --live                  # nós e resumo de pods, com timeout
kubectl config current-context
kubectl get pods -A
kubectl logs -f POD -n NAMESPACE
kubectl describe pod POD -n NAMESPACE
kubectl port-forward svc/SERVICE 8080:80 -n NAMESPACE
helm list -A
```

`dev kube use CONTEXTO` e `knuse` pedem confirmação porque alteram contexto local;
`kuse` troca imediatamente após a seleção. `apply`, `delete`, `scale`, `rollout`, `patch`, `edit`,
`helm install/upgrade/uninstall` **ALTERAM CLUSTER** e nunca são executados pelos
dotfiles.

LazyVim fornece YAML schemas, Helm e validação; CRDs podem precisar de schemas específicos mantidos no projeto.
<!-- /dev-help -->

<!-- dev-help:infrastructure -->
## Infraestrutura {#infrastructure}

- Terraform/HCL: LSP e formatação; Terraform CLI é opcional.
- Google Cloud CLI: instalação existente é preservada; dotfiles não fazem login nem mudam conta.
- Temporal CLI: já instalada; alvo depende do projeto.
- stern: logs Kubernetes multi-pod, opcional.
- CircleCI CLI: opcional; CI específica fica no projeto.

```bash
terraform fmt -check -recursive
terraform plan                 # lê estado e provedores
terraform apply                # ALTERA INFRAESTRUTURA
gcloud config list             # não muda autenticação
temporal workflow list
stern 'api-.*' -n NAMESPACE
```
<!-- /dev-help -->

<!-- dev-help:temporal -->
## Temporal

```bash
temporal workflow list
temporal workflow describe --workflow-id ID
temporal workflow show --workflow-id ID
```

Start, signal, cancel e terminate alteram workflows; confirme namespace e ambiente antes.
<!-- /dev-help -->

<!-- dev-help:ai -->
## IA: Claude, Codex e Cursor {#ai}

Sidekick integra somente as CLIs Claude, Codex e Cursor dentro do Neovim/Zellij. GitHub Copilot não faz parte desta configuração.

```text
<leader>ii selecionar CLI       <leader>ic Claude
<leader>ix Codex                <leader>iu Cursor agent
<leader>if enviar arquivo       <leader>iv enviar seleção
<leader>ip ações de prompt
Ctrl-Shift-G focar Codex no Warp (o terminal envia Ctrl-G)
```

Autentique cada CLI pelo fluxo oficial. Nunca coloque tokens nos dotfiles. Arquivo, seleção, diagnósticos ou diff só são enviados quando você aciona o comando; revise o contexto e não envie `.env`, credenciais, kubeconfigs, chaves, dados de clientes ou buffers sensíveis.
<!-- /dev-help -->
