# Solução de problemas

## Shell

```bash
zsh -n ~/.zshrc
zsh -xlic exit 2>/tmp/zsh-startup.log
```

O Zellij automático só ocorre quando `DOTFILES_AUTO_ZELLIJ=1`.

Se `gst`, `..`, `dev` ou `git pr` não forem encontrados após uma atualização:

```bash
scripts/link-config             # confirma se os destinos estão linked/missing
scripts/link-config --apply     # cria apenas links ausentes
exec zsh                        # recarrega PATH, aliases e funções
command -v dev git-pr
```

`z NOME` consulta primeiro o histórico do zoxide. Sem correspondência, procura um
projeto Git ou pasta por nome. Se houver várias pastas, escolha uma no fzf ou refine
o nome. `dev find NOME` mostra todos os caminhos sem mudar de diretório. A linha
verde `✓ /caminho` confirma que a navegação terminou com sucesso.

Na branch padrão, `git pr` abre o repositório. Nas demais branches, a mensagem “no
pull request found” indica que não existe PR associado; use `git pr --create` se a
criação for desejada. Confira autenticação com `gh auth status`.

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
