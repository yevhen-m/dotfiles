# Git utils
# ====================================================================================

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

# Select changed files in git repo
gj() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# Select git branch
gi() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# Select git tag
gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

# Select git commit hash
gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# Select remote repo
gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# Checkout git commit
fzf-checkout() {
  local commits commit
  commits=$(git log --graph --color=always --format="%C(auto)%h%d %s %C(241)%C(bold)%cr %C(auto)%C(blue)%cn") &&
    commit=$(echo "$commits" | fzf-down --ansi --no-sort --reverse --tiebreak=index) && echo $commit &&
    git checkout $(echo "$commit" | grep -o "[a-f0-9]{7,}")
}
bindkey -s '^g^o' 'fzf-checkout\n'

# Checkout git branch
fzf-branch() {
    local branches branch
    branches=$(git branch -a --color=always | grep -v HEAD | sort) &&
        branch=$(echo "$branches" |
    fzf-down --ansi --tac -d $(( 2 + $(wc -l <<< "$branches") )) +m +s) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
bindkey -s '^g^k' 'fzf-branch\n'

# Browse git commits
vim-git-log() {
    is_in_git_repo || return
    vim -c "GV -50"
}
bindkey -s '^g^l' 'vim-git-log\n'


join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper j i t r h
unset -f bind-git-helper

# Other utils
# ====================================================================================

# Integration with z
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
alias j=z
