export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR='/usr/local/bin/nvim'
export PIP_REQUIRE_VIRTUALENV=true

set -o noclobber
shopt -s cmdhist
shopt -s histappend
shopt -s nocaseglob
shopt -s interactive_comments
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTCONTROL=ignorespace:erasedups

if [[ -f ~/.fzf.bash ]]
then
    source ~/.fzf.bash
    color00='#2d2d2d'
    color01='#393939'
    color02='#515151'
    color03='#747369'
    color04='#a09f93'
    color05='#d3d0c8'
    color06='#e8e6df'
    color07='#f2f0ec'
    color08='#f2777a'
    color09='#f99157'
    color0A='#ffcc66'
    color0B='#99cc99'
    color0C='#66cccc'
    color0D='#6699cc'
    color0E='#cc99cc'
    color0F='#d27b53'
    export FZF_DEFAULT_OPTS="
      --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
      --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
      --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
      --bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border --bind=alt-a:select-all+accept"
    unset -v color0{0..9} color0{A..F}
    export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS='--no-reverse'
    source ~/.fzf-utils.bash
fi

if [[ -f ~/.config/z/z.sh ]]
then
    source ~/.config/z/z.sh
    unalias z 2> /dev/null
    z() {
      [ $# -gt 0 ] && _z "$*" && return
      cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
    }
    alias j=z
fi

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper_lazy.sh"
if [[ -s $VIRTUALENVWRAPPER ]]
then
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    source $VIRTUALENVWRAPPER
fi

# Set TERM variable correctly in and out of tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color" || TERM="screen-256color"

# Aliases
alias l='exa -la'
alias zsh='bash'
# Linux related
if [[ $(uname -s) = Linux ]]
then
    alias pbcopy='xclip -sel clip'
    alias pbpaste='xclip -sel clip -o'
fi
# Git aliases
alias gd='git diff -w'
alias gdc='git diff --cached -w'
alias gp='git push origin HEAD'
alias gu='git pull'
alias gs='git status -sb'
alias gc='git checkout'
alias gcb='git checkout -b'
alias glg='git lg'
alias gl='git lg'
alias gam='git add -u && git commit --amend --no-edit'
alias gcv='git add -u && git commit -v'

alias rm=trash
# Tmux aliases
alias tl="tmux ls | cut -d ' ' -f 1 | sed 's/://'"
alias tat="tmux attach -t"
alias ta="tmux attach"
alias td="tmux detach"
# Vim aliases
alias _vim="/usr/local/bin/vim"
alias vi="/usr/local/bin/nvim"
alias vim="/usr/local/bin/nvim"

# PATH manipulations
[[ -d $HOME/bin ]] && export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="/Users/yevhen/.pyenv/shims:${PATH}"

export PYENV_SHELL=bash
source '/usr/local/Cellar/pyenv/1.2.13/libexec/../completions/pyenv.bash'
# command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
if which pyenv-virtualenv-init > /dev/null
then
    eval "$(pyenv virtualenv-init -)"
fi

# Git support
source /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# Prompt
export PS1="\[\e[01;35m\]\w \$(__git_ps1 '[%s]')\n❯❯❯ \[\e[0m\]"

eval "$(direnv hook bash)"
