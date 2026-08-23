[[ -o interactive ]] || return

export ZDOTDIR="${ZDOTDIR:-$HOME}"
export DOTFILES_ZSH_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

for module in environment history completion aliases functions integrations fzf help; do
  module_file="$DOTFILES_ZSH_DIR/$module.zsh"
  [[ -r "$module_file" ]] && source "$module_file"
done
unset module module_file

# Machine/work configuration belongs outside the repository.
[[ -r "$DOTFILES_ZSH_DIR/local.zsh" ]] && source "$DOTFILES_ZSH_DIR/local.zsh"
