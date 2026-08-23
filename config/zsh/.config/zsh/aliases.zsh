alias cls='clear'
alias reload!='exec zsh'

alias g='git'
alias gs='git status --short --branch'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch --all --prune'
alias glog='git log --graph --decorate --oneline --all -20'
alias lg='lazygit'

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dlogs='docker compose logs --follow --tail=200'

alias k='kubectl'
alias kctx='kubectl config current-context'
alias kcontexts='kubectl config get-contexts'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias klf='kubectl logs --follow --tail=200'
alias k9='k9s'

alias zj='zellij attach --create work'
alias zj-ls='zellij list-sessions'

(( $+commands[eza] )) && alias ls='eza --group-directories-first' && alias ll='eza -lah --git --group-directories-first'
if (( $+commands[bat] )); then alias cat='bat --paging=never'; elif (( $+commands[batcat] )); then alias cat='batcat --paging=never'; fi
(( ! $+commands[fd] && $+commands[fdfind] )) && alias fd='fdfind'
