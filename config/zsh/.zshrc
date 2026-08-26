[[ -o interactive ]] || return

export ZDOTDIR="${ZDOTDIR:-$HOME}"
export DOTFILES_ZSH_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Treat a relative directory entered by itself as `cd <directory>`.
setopt AUTO_CD

for module in environment history completion aliases functions integrations fzf help; do
  module_file="$DOTFILES_ZSH_DIR/$module.zsh"
  [[ -r "$module_file" ]] && source "$module_file"
done
unset module module_file

# Make a bare `~` enter the home directory.
_home_on_accept_line() {
  [[ $BUFFER == "~" ]] && BUFFER="cd ~"
  zle .accept-line
}
zle -N accept-line _home_on_accept_line

# Machine/work configuration belongs outside the repository.
[[ -r "$DOTFILES_ZSH_DIR/local.zsh" ]] && source "$DOTFILES_ZSH_DIR/local.zsh"

# Must be loaded last so it can highlight every alias and function defined above.
if [[ -z "${NO_COLOR:-}" && "${TERM:-}" != dumb ]]; then
  syntax_highlighting_sources=(
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  )
  for syntax_highlighting_source in "${syntax_highlighting_sources[@]}"; do
    if [[ -r "$syntax_highlighting_source" ]]; then
      source "$syntax_highlighting_source"
      ZSH_HIGHLIGHT_STYLES[command]='fg=#FF6B00,bold'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=#FF6B00,bold'
      ZSH_HIGHLIGHT_STYLES[function]='fg=#FF6B00,bold'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=#FF6B00,bold'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=#FF6B00,bold'
      ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#E06C75,bold'
      ZSH_HIGHLIGHT_STYLES[path]='fg=#61AFEF,underline'
      break
    fi
  done
  unset syntax_highlighting_source syntax_highlighting_sources
fi
