# Solução de problemas

## Shell

```bash
zsh -n ~/.zshrc
zsh -xlic exit 2>/tmp/zsh-startup.log
```

O Zellij automático só ocorre quando `DOTFILES_AUTO_ZELLIJ=1`.

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
