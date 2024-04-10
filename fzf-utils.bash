if [[ -f ~/.fzf.bash ]]
then
    source ~/.fzf.bash
    export FZF_DEFAULT_OPTS="--bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border=rounded --bind=alt-a:select-all+accept"
    export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS='--no-reverse'

    _gen_fzf_default_opts() {

    local color00='#2d2d2d'
    local color01='#393939'
    local color02='#515151'
    local color03='#747369'
    local color04='#a09f93'
    local color05='#d3d0c8'
    local color06='#e8e6df'
    local color07='#f2f0ec'
    local color08='#f2777a'
    local color09='#f99157'
    local color0A='#ffcc66'
    local color0B='#99cc99'
    local color0C='#66cccc'
    local color0D='#6699cc'
    local color0E='#cc99cc'
    local color0F='#d27b53'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

    }
    _gen_fzf_default_opts
    source ~/Dotfiles/fzf-git.sh
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
