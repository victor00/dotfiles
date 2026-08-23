alias help-aliases='dev-help aliases'
alias help-tools='dev-help tools'
alias help-zellij='dev-help zellij'
alias help-nvim='dev-help lazyvim'
alias help-git='dev-help git'
alias help-k8s='dev-help kubernetes'
alias help-rails='dev-help rails'
alias help-api='dev-help api'

# Give concise descriptions for dotfiles shortcuts while preserving the builtin
# behavior for regular commands, multiple arguments, and options such as -a.
typeset -gA DEV_COMMAND_DESCRIPTIONS=(
  kuse 'select a Kubernetes context with fzf and confirmation'
  knuse 'select a Kubernetes namespace with fzf and confirmation'
  kwhere 'show the current Kubernetes context and namespace'
  k 'run kubectl'
  kctx 'show the current Kubernetes context'
  kcontexts 'list configured Kubernetes contexts'
  kgp 'list Kubernetes pods in the current namespace'
  kgpa 'list Kubernetes pods across all namespaces'
  klf 'follow logs from a Kubernetes pod'
  k9 'open k9s'
  g 'run Git'
  gs 'show compact Git status with the current branch'
  ga 'stage a file in Git'
  gaa 'stage all Git changes'
  gc 'create a Git commit'
  gd 'show unstaged Git changes'
  gds 'show staged Git changes'
  gf 'fetch all Git remotes and prune stale references'
  glog 'show compact Git graph history'
  lg 'open Lazygit'
  d 'run Docker'
  dc 'run Docker Compose'
  dps 'show Docker containers, status, and ports as a table'
  dlogs 'follow recent Docker Compose logs'
  mkcd 'create a directory and enter it'
  croot 'go to the root of the current Git repository'
  port 'show the process listening on a local port'
  zja 'create or attach to a Zellij session'
  zjl 'start a Zellij layout in a named session'
)

type() {
  if (( $# == 1 )) && [[ -n "${DEV_COMMAND_DESCRIPTIONS[$1]:-}" ]]; then
    print -r -- "$1: ${DEV_COMMAND_DESCRIPTIONS[$1]}"
    return 0
  fi
  builtin type "$@"
}
