#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR=`brew --prefix`/bin/nvim
export VISUAL=$EDITOR
export PIP_REQUIRE_VIRTUALENV=true

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber
set -o emacs
shopt -s cmdhist
# Append to the history file, don't overwrite it
shopt -s histappend
# Update history immediately
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Save multi-line commands as one command
shopt -s cmdhist
shopt -s interactive_comments
shopt -s cdspell
# Correct spelling errors during tab-completion
shopt -s dirspell
# Disable softward flow control
stty -ixon

HISTSIZE=1000000
HISTFILESIZE=1000000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='l':'workon':'j':'gl':'gs':'gd'

source ~/Dotfiles/fzf-utils.bash

if [[ -f `brew --prefix`/etc/profile.d/z.sh ]]
then
    source `brew --prefix`/etc/profile.d/z.sh
    unalias z 2> /dev/null
    z() {
      [ $# -gt 0 ] && _z "$*" && return
      cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
    }
    alias j=z
fi

VIRTUALENVWRAPPER="`brew --prefix`/bin/virtualenvwrapper.sh"
if [[ -s $VIRTUALENVWRAPPER ]]
then
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=`brew --prefix python@3.9`/bin/python
    source $VIRTUALENVWRAPPER
fi

# Set TERM variable correctly in and out of tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color" || TERM="tmux-256color"

# Completion
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

export BASH_COMPLETION_COMPAT_DIR=`brew --prefix`/etc/bash_completion.d
[[ -r `brew --prefix`/etc/profile.d/bash_completion.sh ]] && . `brew --prefix`/etc/profile.d/bash_completion.sh

# Aliases
alias l='eza -lha --time-style long-iso --icons=always --color=always --git'
alias ll=l
alias ls=l
# For "short" ls output
alias lss='l -1 --icons=never'

alias zsh='bash'
alias ag=rg
alias grep=rg

# Git aliases
alias gl=lg
alias gd='gl'
alias gdc='gl'
alias gp='git pull'
alias gP='git push origin HEAD'
alias gs=lg
alias gst=lg
alias gc='git checkout'
alias gcb='gc -b'
alias glg=lg
alias gc='git add -u && git commit'
alias gca='gc --amend --no-edit'
alias gpr='gh pr view -w'

alias rm=trash

# Tmux aliases
alias ta="tmux attach"
alias tat="ta -t"
alias td="tmux detach"
alias tl="tmux ls | rg '^(\w+):' -or '\$1' --color=never"

# Vim aliases
alias vi="`brew --prefix`/bin/nvim"
alias vim="`brew --prefix`/bin/nvim"

# Ranger
alias r=ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# Lazygit
alias gl='lazygit --use-config-file="$HOME/.config/lazygit"'
alias lg='gl'

# Lazydocker
alias dl='lazydocker'
alias ld='dl'

# Bat
export BAT_THEME="Catppuccin Macchiato"
alias cat=bat

# PATH manipulations
[[ -d $HOME/bin ]] && export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=`brew --prefix`/opt/node@16/bin:$PATH
export PATH="/Users/yevhen/.pyenv/shims:${PATH}"

export PYENV_SHELL=bash
if command -v pyenv 1>/dev/null 2>&1
then
    eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null
then
    eval "$(pyenv virtualenv-init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
