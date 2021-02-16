### PROMPT

# Load version control information
autoload -Uz vcs_info
autoload -U colors && colors
precmd() { vcs_info }

#https://jonasjacek.github.io/colors/
LIGHT_BLUE=33

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git*' formats "%F{magenta}%b%f%F{green}%m%u%c%f "

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{$LIGHT_BLUE}%n@%m%f:${vcs_info_msg_0_}@%F{$LIGHT_BLUE}${PWD/#$HOME/~}%f$ '

# Change color of directories when running `ls -l`

export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

### /PROMPT


### ALIASES

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -la -G'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias grep='grep --color=auto'
alias grepc='grep -r -v "i18n"'
alias amend='git commit --amend -C HEAD'
alias amenda='git commit -a --amend -C HEAD'
alias gsuir='git submodule update --init --recursive'

# Find only files relevant to the current git repo, ignoring i18n folders (!)
alias grepg='git ls-files --recurse-submodules | grep -v "i18n" | xargs grep -s --color=auto'

### /ALIASES


### NVM

export NVM_DIR="$HOME/.nvm"

# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

### /NVM

### PYTHON

# Add binaries installed via pip to PATH.
path+=('/Users/carl/Library/Python/3.7/bin')
export PATH

### /PYTHON


### RUST

path+=('/Users/carl/.cargo/bin')
export PATH

### /RUST

### LQ

path+=('/Users/carl/src/lookback/logquery/build.Darwin')
export PATH
source /Users/carl/.lq/credentials

###
