if [[ -f ~/.fzf.bash ]]
then
    source ~/.fzf.bash
    export FZF_DEFAULT_OPTS="--bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border=rounded --bind=alt-a:select-all+accept"
    export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS='--no-reverse'
    source ~/.config/nvim/plugged/tokyonight.nvim/extras/fzf/tokyonight_night.zsh
fi

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --border-label '📜 History'
  --border-label-pos 2
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target --border-label '📁 Folders' --border-label-pos 2 --height=~100%
  --preview 'tree -C {}'"

# Integration with z
unalias z 2> /dev/null
z() {
  [ $# -select-tag 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
alias j=z
