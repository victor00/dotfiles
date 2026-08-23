# Repository guidelines

## Safety

- Never commit credentials, tokens, private keys, kubeconfigs, `.env` files, or private HTTP environment files.
- Never run `sudo`, installers, cluster mutations, or authentication commands without explicit approval.
- Preserve existing files. Linking must refuse conflicts unless an explicit backup mode is selected.
- Keep installation idempotent and make dry-run the default.

## Structure

- `bootstrap/` installs tools; it must not contain daily commands.
- `config/` contains XDG/Home configuration grouped by tool.
- `bin/` contains lightweight commands intended for `~/.local/bin`.
- `scripts/` contains repository maintenance and validation commands.
- `docs/DAILY-HELP.md` is the source of truth for `dev-help` topics.

## Validation

- Run `make check` after changes.
- Shell scripts must pass `bash -n` and ShellCheck.
- Zsh modules must pass `zsh -n`.
- Never add a Neovim keymap without checking LazyVim and WhichKey mappings.
- Optional missing tools must not break shell, Neovim, or Zellij startup.
