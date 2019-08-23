export DISABLE_AUTO_TITLE=true
export EDITOR='/usr/local/bin/nvim'
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LESS='-i -M -R -z-4'
export VISUAL='/usr/local/bin/nvim'
export GREP_COLOR="30;43"

export PIPENV_DEFAULT_PYTHON_VERSION=3.6
export PURE_PROMPT_SYMBOL=❯❯❯
unset VIRTUAL_ENV_DISABLE_PROMPT

# ZSH options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt HISTIGNORESPACE           # Don't save commands with leading space to history
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt NO_CORRECT                # Turn off autocorrect
setopt NO_INC_APPEND_HISTORY     # Write to the history file only when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.

# Z settings
Z_SCRIPT="$HOME/.config/z/z.sh"
[[ -s $Z_SCRIPT ]] && source $Z_SCRIPT

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-utils.zsh ] && source ~/.fzf-utils.zsh

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

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  --bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border --bind=alt-a:select-all+accept"
}
_gen_fzf_default_opts

export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
# export FZF_DEFAULT_OPTS='--color=dark,bg+:18 --bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border --bind=alt-a:select-all+accept'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--no-reverse'

# Base16 colorscheme
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# virtualenv-wrapper
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper_lazy.sh"
[[ -s $VIRTUALENVWRAPPER ]] && source $VIRTUALENVWRAPPER

# Activate virtualenv in a child shell
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Set TERM variable correctly in and out of tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color" || TERM="screen-256color"

# Dir for my scripts
[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH

# Brew sbin dir
export PATH="/usr/local/sbin:$PATH"

# Try to fix disappering cursor in gnome-terminal
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

ZSH_AUTOSUGGEST_USE_ASYNC=1

# Edit long commands with vim
autoload edit-command-line
zle -N edit-command-line
bindkey '^g^g' edit-command-line

# Aliases
# ================================================
alias ll='exa -la'
alias l='exa -la'
alias r=ranger
alias ag='ag --mmap'
alias ww='workon $(basename `pwd`)'

# Aliases for Linux setups
if [[ $(uname -s) = Linux ]]; then
    alias pbcopy='xclip -sel clip'
    alias pbpaste='xclip -sel clip -o'
fi

# Git
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

# Vim aliases
alias _vim="/usr/local/bin/vim"
alias vi="/usr/local/bin/nvim"
alias vim="/usr/local/bin/nvim"

# Tmux aliases
alias tl="tmux ls | cut -d ' ' -f 1 | sed 's/://'"
alias tat="tmux attach -t"
alias ta="tmux attach"
alias td="tmux detach"

# Copy-paste `pyenv init -` wihout rehash call because it's too slow
export PATH="/Users/yevhen/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval "$(direnv hook zsh)"
