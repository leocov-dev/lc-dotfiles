#!/usr/bin/env bash

if command_exists hub; then
    alias git='hub'
fi

alias git-summary-src='git-summary -q ~/src'
alias git-summary-repos='git-summary -q ~/repos'

alias gpl='git pull --prune'
#alias glg="git log --graph --decorate --oneline --abbrev-commit"
#alias glga="glg --all"
alias gp='git push origin HEAD'
#alias gpa='git push origin --all'
#alias gd='git diff'
#alias gc='git commit -s'
#alias gca='git commit -s -a'
alias gx='git checkout'
#alias gb='git branch -v'
#alias ga='git add'
alias ga='git add -A && git status -sb'
alias gc='git commit -m'
#alias gcam='git commit -s -a -m'
alias gs='git status -sb'
#alias gpr='gp && git pr'
#alias glnext='git log --oneline $(git describe --tags --abbrev=0 @^)..@'
alias gsquash='ga && gc "s" && git rebase -i fusion && git push -f'

#if command -v svu >/dev/null 2>&1; then
#	alias gtpatch='echo `svu p`; git tag `svu p`'
#	alias gtminor='echo `svu m`; git tag `svu m`'
#fi

gi() {
    curl -s "https://www.gitignore.io/api/$*"
}
