if [[ -f ~/.fzf.bash ]]
then
    source ~/.fzf.bash
    export FZF_DEFAULT_OPTS="--bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border=rounded --bind=alt-a:select-all+accept"
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--no-reverse --preview 'bat -n --color=always --line-range :500 {}'"
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
fi

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {} | bat -l bash -p --color=always' --preview-window right:40%:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --border-label '📜 History'
  --border-label-pos 2
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target --border-label '📁 Folders' --border-label-pos 2 --height=~100%
  --preview 'eza --tree --color=always {} --icons=always | head -200'"

# Use bat for fzf previews
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd) fzf --preview 'eza --tree --color=always --icons=always {} | head -200' "$@";;
    export|unset) fzf --preview "eval 'echo \$'{} | bat --color=always -l bash -p" --preview-window right:50%:wrap "$@";;
    ssh) fzf --preview 'dig {}' "$@";;
    *) fzf --preview 'bat -n --color=always --line-range :500 {}' "$@";;
  esac
}

# Integration with z
unalias z 2> /dev/null
z() {
  [ $# -select-tag 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
alias j=z
