# Solução de problemas

## Shell

```bash
zsh -n ~/.zshrc
zsh -xlic exit 2>/tmp/zsh-startup.log
```

O Zellij automático só ocorre quando `DOTFILES_AUTO_ZELLIJ=1`.

Se `ghostty` não existir, configuração vinculada não significa aplicativo instalado:

```bash
./install.sh desktop
./install.sh --apply desktop  # execute no seu terminal e digite a senha sudo ali
command -v ghostty || test -x /snap/bin/ghostty
/snap/bin/ghostty             # caminho temporário até atualizar a sessão/PATH
```

Depois da instalação Snap, saia e entre novamente na sessão gráfica se o launcher
“Ghostty” ainda não aparecer no menu do GNOME.

Se `gst`, `..`, `dev` ou `git pr` não forem encontrados após uma atualização:

```bash
scripts/link-config             # confirma se os destinos estão linked/missing
scripts/link-config --apply     # cria apenas links ausentes
exec zsh                        # recarrega PATH, aliases e funções
command -v dev git-pr
```

`z NOME` consulta primeiro o histórico do zoxide. Sem correspondência, procura um
projeto Git ou pasta por nome. Se houver várias pastas, escolha uma no fzf ou refine
o nome. `dev find NOME` mostra todos os caminhos sem mudar de diretório.

Se comandos válidos não ficarem verdes enquanto são digitados, confirme a presença
de `/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` ou do plugin em
`~/.oh-my-zsh/custom/plugins/`, depois execute `exec zsh`. O realce é carregado por
último para reconhecer aliases e funções como `gst` e `z`.

O realce durante a digitação e a confirmação posterior são independentes: o plugin
colore o comando antes do Enter; a função `z` imprime `✓ /caminho` somente depois de
uma navegação bem-sucedida. Ambos respeitam terminais sem suporte a cor, e a
confirmação respeita `NO_COLOR`.

Na branch padrão, `git pr` abre o repositório. Nas demais branches, a mensagem “no
pull request found” indica que não existe PR associado; use `git pr --create` se a
criação for desejada. Confira autenticação com `gh auth status`.

## Painel `dev`

- `dev status` mostra `unavailable`: confirme DNS/rede; cada requisição expira em até
  oito segundos e falhas não são apresentadas como outage confirmado.
- `dev kube --live` falha: confira `dev kube`, VPN e permissões do contexto. A consulta
  usa `--request-timeout=8s` e nunca aplica recursos.
- `dev ports` mostra processo `unknown`: o kernel pode ocultar processos de outros
  usuários; não execute com sudo apenas para preencher essa coluna.
- `dev docs TERMO` não encontra conteúdo: tente `dev docs --search TERMO` ou instale
  documentação do pacote correspondente.

## Rainfrog e bancos

```bash
db doctor
command -v rainfrog psql
rainfrog --version
```

- `db` não mostra conexões: rode `db configure`, ajuste host/database/usuário e não
  adicione senha ao TOML.
- Falha de autenticação: use `db reenter-password`; o wrapper não lê nem registra a
  senha.
- Símbolos quebrados: confirme JetBrainsMono Nerd Font no Ghostty.
- Banco inacessível: confirme VPN, DNS, porta com `dev port PORT` e acesso usando uma
  conta read-only. O wrapper não inicia containers ou servidores automaticamente.

## fzf

fzf 0.29 não possui `fzf --zsh`. A configuração usa integração direta somente quando a opção existe; caso contrário, usa scripts do Ubuntu.

## Neovim

```vim
:LazyHealth
:checkhealth
:checkhealth vim.lsp
:checkhealth nvim-treesitter
:checkhealth sidekick
```

Neovim inferior a 0.11.2 não atende ao LazyVim atual. Use `NVIM_DISABLE_AI=1 nvim` para isolar IA.

Para diagnóstico sem downloads de ferramentas/parsers, use `NVIM_SKIP_MASON=1 NVIM_SKIP_TREESITTER=1 nvim`.

No Ubuntu 22.04, não use um tree-sitter CLI pré-compilado que exija GLIBC 2.39. O bootstrap deve usar uma versão compilada localmente com Cargo e deixar o executável em `~/.cargo/bin`.

## Zellij e links

```bash
zellij setup --check
make doctor
scripts/link-config
```

Links nunca são substituídos sem `--backup` explícito.
