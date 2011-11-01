# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc.py
export SHELL=bash



# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

HISTTIMEFORMAT="%Y%m%d %H:%M:%S "

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

symbolic_hostname="`cat /etc/symbolic_hostname 2> /dev/null`.d"
if [ "$symbolic_hostname" == ".d" ]; then
    symbolic_hostname=`hostname`
fi

if [ "$color_prompt" = yes ]; then

    # Blue for own comp
    if [ "$HOSTNAME" = "Tesla.local" ] || [ "$HOSTNAME" = "Tesla" ] || [ "$HOSTNAME" = "tesla.local" ] || [ "$HOSTNAME" = "tesla" ] || [ "$HOSTNAME" = "Snowstorm.local" ] || [ "$HOSTNAME" = "Snowstorm" ]; then
        color="4"  

    # Green for dev
    elif [ "$HOSTNAME" = "bangbang" ]; then
        color="2"     
    
    # Red for production or unknown
    else
        color="1"  
    fi
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;3${color}m\]\u@$symbolic_hostname\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@$symbolic_hostname:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]1"
#    ;;
#*)
#    ;;
#esac

# If this is an xterm set the title to user@host:dir
 case "$TERM" in
 xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD/$HOME/~}\007"'
     ;;
 *)
     ;;
 esac



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support (linux) of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# Enable color coding support for OS X
export CLICOLOR=1
# LSCOLORS needs to be tweaked
export LSCOLORS=ExFxCxDxBxegedabagacad

# some more ls aliases
alias ll='ls -la'
#alias la='ls -A'
#alias l='ls -CF'
alias rm='rm -i'
alias ssh='ssh -A'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -la --color=auto'
alias sl='cowsay "slow down boi!";sleep 10'
alias py='python '
alias cdiff='bash ~/src/misc/coloured_svn_diff.sh'
alias gst='git status'
alias gd='git diff'
alias grep='grep --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

function photoshop { open -a /Applications/Adobe\ Photoshop\ CS4/Adobe\ Photoshop\ CS4.app $*; }

# Make the ruby gems work from command line
export PATH=$PATH:/var/lib/gems/1.8/bin
