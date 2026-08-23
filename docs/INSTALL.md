# Instalação

## Pré-requisitos

Ubuntu é a única plataforma suportada pelo bootstrap. Clone o repositório no local de sua preferência; nenhum script presume `~/dotfiles`.

## Fluxo seguro

```bash
./setup.sh                 # seleção guiada, somente planos
./setup.sh --apply         # seleção guiada com aplicação confirmada
make doctor
./install.sh core
./install.sh terminal
scripts/link-config
make check
```

O primeiro comando de cada grupo mostra ferramenta, finalidade, origem, versão e atualização. Para aplicar:

```bash
./install.sh --apply core
```

O assistente `setup.sh` explica cada grupo e aceita `y` para incluir, `Enter` ou
`n` para pular e `q` para cancelar. Mesmo com `--apply`, ele mostra a seleção completa
e pede confirmação antes de iniciar. Confirmações de `sudo` e a proteção contra
conflitos de links continuam independentes.

APT exige confirmação interativa antes de `sudo`. Instaladores de binários externos permanecem bloqueados até uma versão e checksum serem registrados e revisados.

### Ghostty no Ubuntu 22.04

```bash
./install.sh desktop          # mostra origem, finalidade e atualização
./install.sh --apply desktop  # confirma sudo e instala o Snap classic
```

O Ubuntu 22.04 não oferece Ghostty no APT. O grupo desktop usa o Snap listado pela
documentação do Ghostty e nunca executa `curl | sh`. Depois de instalado, Ghostty abre
`zellij attach --create work`. Para recuperação sem Zellij, execute `ghostty -e zsh -l`.
Abra “Ghostty” pelo menu do GNOME, execute `ghostty` ou, antes de a sessão atualizar
o PATH, `/snap/bin/ghostty`. Se o launcher não aparecer, encerre e abra a sessão
gráfica novamente.

## Links

```bash
scripts/link-config                  # plano
scripts/link-config --apply          # somente destinos ausentes
scripts/link-config --apply --backup # conflitos vão para backup datado
```

Além das configurações, o manifesto vincula `dev-help`, `dev` e os executáveis
`git-*` em `~/.local/bin`. O Zsh gerenciado inclui esse diretório no `PATH`; por isso
`bin/git-pr` é descoberto automaticamente pelo Git como `git pr`. Após criar links
em um shell já aberto, rode `exec zsh` para recarregar aliases e funções.

O grupo `core` também garante `curl`, `jq`, `tldr`, `man`, `ss` (iproute2) e
`xdg-open` (xdg-utils), usados pelos subcomandos operacionais de `dev`. A instalação
continua idempotente e só usa APT depois da confirmação interativa.

O grupo `database` instala Rainfrog 0.4.3 com `cargo install --locked
--no-default-features` em `~/.local/bin`, sem sudo. PostgreSQL, MySQL e SQLite
permanecem disponíveis; os drivers opcionais DuckDB/Oracle não são compilados. Rode
primeiro o plano e depois aplique:

```bash
./install.sh database
./install.sh --apply database
scripts/link-config --apply
db configure
```

`db configure` cria `~/.config/rainfrog/rainfrog_config.toml` com modo `0600`. Esse
arquivo e `~/.local/share/rainfrog/` são privados da máquina e não são links do Git.

Nunca use `--backup` sem revisar cada conflito mostrado no dry-run. O destino pode ser alterado para testes:

```bash
DOTFILES_TARGET_HOME=/tmp/dotfiles-home scripts/link-config --apply
```

## Atualização e rollback

Atualize o repositório, rode `make doctor`, revise mudanças de versões, execute `make check` e só então aplique o grupo necessário. Para rollback, remova apenas links confirmados e restaure o diretório datado em `~/.local/state/dotfiles/backups/`.
