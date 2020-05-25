# Load version control information
autoload -Uz vcs_info
autoload -U colors && colors
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git*' formats "%{$fg[magenta]%}%b%{$reset_color%}%{$fg[green]%}%m%u%c%{$reset_color%} "
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[blue]%}%n@%m%{$reset_color%}:${vcs_info_msg_0_}@${PWD/#$HOME/~}'
