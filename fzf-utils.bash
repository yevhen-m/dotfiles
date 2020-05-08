# Git utils
# ====================================================================================

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border=horizontal
}

select-changed() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

select-branch() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

select-tag() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

select-commit() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# Checkout git commit
checkout-commit() {
  local commits commit
  commits=$(git log --graph --color=always --format="%C(auto)%h%d %s %C(241)%C(bold)%cr %C(auto)%C(blue)%cn") &&
    commit=$(echo "$commits" | fzf-down --ansi --no-sort --reverse --tiebreak=index) && echo $commit &&
    git checkout $(echo "$commit" | grep -E -o "[a-f0-9]{7,}")
}

# Checkout git branch
checkout-branch() {
    local branches branch
    branches=$(git branch -a --color=always | grep -v HEAD | sort) &&
        branch=$(echo "$branches" |
    fzf-down --ansi --tac -d $(( 2 + $(wc -l <<< "$branches") )) +m +s) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

bind '"\er": redraw-current-line'
bind '"\C-g\C-j": "$(select-changed)\e\C-e\er"'
bind '"\C-g\C-i": "$(select-branch)\e\C-e\er"'
bind '"\C-g\C-t": "$(select-tag)\e\C-e\er"'
bind '"\C-g\C-h": "$(select-commit)\e\C-e\er"'
bind '"\C-g\C-k": "$(checkout-branch)\e\C-e\er"'
bind '"\C-g\C-o": "$(checkout-commit)\e\C-e\er"'

# Other utils
# ====================================================================================

# Integration with z
unalias z 2> /dev/null
z() {
  [ $# -select-tag 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
alias j=z
