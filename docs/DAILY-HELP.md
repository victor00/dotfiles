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
- [Containers](#docker)
- [Kubernetes](#kubernetes)
- [Infraestrutura](#infrastructure)
- [IA](#ai)

<!-- dev-help:shell -->
## Shell e terminal {#shell}

Finalidade: Ghostty renderiza o terminal; Zsh fornece o shell modular, e Starship somente o prompt. Zellij cuida de sessões, abas e painéis.

- Configuração: `config/ghostty/`, `config/zsh/` e `config/starship/`.
- Ghostty não define splits ou abas: esses atalhos pertencem exclusivamente ao Zellij.
- Ghostty abre `zellij attach --create work`; recuperação: `ghostty -e zsh -l`.
- Atualização: pelo grupo `make install-terminal`, após revisar o plano exibido.
- Desabilitar integração: comente o módulo correspondente ou use `local.zsh` fora do Git.
- Zellij automático é opt-in com `DOTFILES_AUTO_ZELLIJ=1`.
- O fzf detecta capacidades; versões antigas usam os scripts de integração do Ubuntu.

Comandos:

```bash
exec zsh                 # inicia uma sessão nova sem source duplicado
z nome                   # navega por frequência com zoxide
zi                       # seleção interativa de diretório
Ctrl-R                   # histórico pesquisável pelo fzf
dev-help --interactive   # ajuda pesquisável
```

Problemas comuns: rode `zsh -n ~/.zshrc` para sintaxe e `make doctor` para dependências. Configuração privada pertence a `~/.config/zsh/local.zsh`.
<!-- /dev-help -->

<!-- dev-help:aliases -->
## Aliases e funções

Git: `g`, `gs`, `ga`, `gaa`, `gc`, `gd`, `gds`, `gf`, `glog`, `lg`.

Docker: `d`, `dc`, `dps`, `dlogs`. Kubernetes: `k`, `kctx`, `kcontexts`, `kgp`, `kgpa`, `klf`, `k9`.

Funções:

```bash
mkcd projeto             # cria e entra no diretório
croot                    # vai à raiz do Git
port 3000                # mostra o listener, sem encerrar processos
kwhere                   # mostra contexto/namespace atuais
kuse                     # troca contexto após confirmação; ALTERA ESTADO local
knuse                    # troca namespace após confirmação; ALTERA ESTADO local
zja projeto              # cria/anexa sessão Zellij
zjl api minha-api        # inicia layout api na sessão indicada
```
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
gd                        # diff não staged
gds                       # diff staged
lg                        # abre LazyGit
gh pr view --web          # abre o PR atual
gh pr checks              # mostra checks do PR
```

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
Lock:     Ctrl-g trava/destrava
Global:   Alt-h/j/k/l navega | Alt-f floating | Alt-? ajuda
```

```bash
zja projeto               # anexa/cria sessão
zjl general projeto       # layout geral
zjl rails app             # Rails sem iniciar comandos automaticamente
zjl api service-api       # API sem assumir servidor ou coleção
zjl kubernetes infra      # terminais neutros, sem alterar cluster
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
<leader>tt teste próximo       <leader>tf arquivo de testes
<leader>db breakpoint          <leader>dc continuar debug
<leader>? keymaps do buffer    :checkhealth
```

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

```bash
docker compose up                    # inicia serviços em foreground
docker compose up -d                 # inicia em background
docker compose logs -f               # acompanha logs
docker compose exec app bash         # shell; confirme o nome do serviço
docker compose config --services     # lista serviços
docker compose down                  # ALTERA ESTADO
```

`docker compose down -v` remove volumes e pode apagar bancos locais.
<!-- /dev-help -->

<!-- dev-help:kubernetes -->
## Kubernetes {#kubernetes}

Comandos de leitura:

```bash
kubectl config current-context
kubectl get pods -A
kubectl logs -f POD -n NAMESPACE
kubectl describe pod POD -n NAMESPACE
kubectl port-forward svc/SERVICE 8080:80 -n NAMESPACE
helm list -A
```

`kuse` e `knuse` pedem confirmação porque alteram contexto local. `apply`, `delete`, `scale`, `rollout`, `patch`, `edit`, `helm install/upgrade/uninstall` **ALTERAM CLUSTER** e nunca são executados pelos dotfiles.

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
```

Autentique cada CLI pelo fluxo oficial. Nunca coloque tokens nos dotfiles. Arquivo, seleção, diagnósticos ou diff só são enviados quando você aciona o comando; revise o contexto e não envie `.env`, credenciais, kubeconfigs, chaves, dados de clientes ou buffers sensíveis.
<!-- /dev-help -->
