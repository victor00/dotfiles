# Ferramentas e ownership

| Área | Ferramentas | Instalação/ownership |
|---|---|---|
| Shell | Zsh, fzf, zoxide, Starship, Zsh Syntax Highlighting | sistema ou release fixada; prompt contextual e comandos válidos em verde |
| Terminal | Ghostty, JetBrainsMono Nerd Font | pacote oficial para Ubuntu; renderização, símbolos e superfícies GTK |
| Multiplexador | Zellij | release oficial fixada; sessões, abas, painéis e layouts |
| Aplicativos TUI | LazyGit, eza | release oficial fixada |
| Fluxo diário | `git pr`, `git root`, `git recent`, `git cleanup-preview`, `dev project` | scripts locais em `bin/`, sem credenciais ou exclusões automáticas |
| Arquivos | ripgrep, fd, bat, jq, yq | sistema quando compatível |
| Runtime | mise | versões definidas pelo projeto |
| Ruby | Ruby LSP, RuboCop | projeto/Bundler quando fixado; Mason como fallback |
| Go | gopls, gofumpt, goimports, golangci-lint, Delve | Mason; código por Go modules |
| Python | basedpyright, Ruff, debugpy | Mason; bibliotecas por uv/Poetry/projeto |
| Java | JDTLS, debug/test adapters | Mason; Maven/Gradle pelo wrapper do projeto |
| API | curl, HTTPie, Kulala, grpcurl, Bruno | grupos opcionais separados |
| Infra | kubectl, k9s, Helm, stern, Terraform | fontes oficiais, sem autenticação automática |
| IA | Claude, Codex, Cursor via Sidekick | CLIs e autenticação oficiais fora do Git |

Mason gerencia ferramentas editoriais globais. Ele não instala runtimes nem dependências das aplicações. Quando um projeto fixa formatter/linter, a versão do projeto tem precedência.
