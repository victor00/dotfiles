#!/bin/bash

# Script to open pull request directly into your default browser.
# It is very useful when diff between default branch on GitHub
# and development purpose branch is too high.

function _zpr() {
    current_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    parent_branch_with_remote=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
    parent_branch="${parent_branch_with_remote##*/}"
    github_username=$(git config user.username)

      remote_url=$(git ls-remote --get-url)
    if [[ "$remote_url" =~ git@github.com:(.+)/(.+)\.git ]]; then
        user="${BASH_REMATCH[1]}"
        repo="${BASH_REMATCH[2]}"
    elif [[ "$remote_url" =~ https://github.com/(.+)/(.+).git ]]; then
        user="${BASH_REMATCH[1]}"
        repo="${BASH_REMATCH[2]}"
    else
        echo "Formato da URL do remote não reconhecido: $remote_url"
        return 1
    fi

    zprURL="https://github.com/$user/$repo/compare/$current_branch"
    xdg-open "$zprURL"
}
_zpr