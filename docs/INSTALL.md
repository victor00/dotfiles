# Instalação

## Pré-requisitos

Ubuntu é a única plataforma suportada pelo bootstrap. Clone o repositório no local de sua preferência; nenhum script presume `~/dotfiles`.

## Fluxo seguro

```bash
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

APT exige confirmação interativa antes de `sudo`. Instaladores de binários externos permanecem bloqueados até uma versão e checksum serem registrados e revisados.

### Ghostty no Ubuntu 22.04

```bash
./install.sh desktop          # mostra origem, finalidade e atualização
./install.sh --apply desktop  # confirma sudo e instala o Snap classic
```

O Ubuntu 22.04 não oferece Ghostty no APT. O grupo desktop usa o Snap listado pela
documentação do Ghostty e nunca executa `curl | sh`. Depois de instalado, Ghostty abre
`zellij attach --create work`. Para recuperação sem Zellij, execute `ghostty -e zsh -l`.

## Links

```bash
scripts/link-config                  # plano
scripts/link-config --apply          # somente destinos ausentes
scripts/link-config --apply --backup # conflitos vão para backup datado
```

Nunca use `--backup` sem revisar cada conflito mostrado no dry-run. O destino pode ser alterado para testes:

```bash
DOTFILES_TARGET_HOME=/tmp/dotfiles-home scripts/link-config --apply
```

## Atualização e rollback

Atualize o repositório, rode `make doctor`, revise mudanças de versões, execute `make check` e só então aplique o grupo necessário. Para rollback, remova apenas links confirmados e restaure o diretório datado em `~/.local/state/dotfiles/backups/`.
