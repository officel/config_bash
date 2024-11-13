# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# use !!
shopt -s histverify

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[01;34m\]\W\[\033[00m\] $ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash_aliases ]; then
    .   ${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# 2024-04-26
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# cli version manager aqua
export PATH="$(aqua root-dir)/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}/aqua/aqua.yaml

# 2024-05-20 ssh-agent for git commit ssh signature verification
if [ -z "${SSH_AGENT_PID}" ]; then
    eval $(ssh-agent) 1>/dev/null
    ssh-add ~/.ssh/id_ed25519 1>/dev/null 2>&1
fi

# 2024-05-21 direnv
eval "$(direnv hook bash)"

# # 2024-05-24 rye
# . "$HOME/.rye/env"

# completion
complete -C aws_completer aws
complete -C terraform terraform
complete -C terraform t
source <(kubectl completion bash)

# 2024-06-05 https://github.com/cykerway/complete-alias
# brew install bash-completion@2
# wget  https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias
# chmod +x complete_alias
# sudo mv complete_alias /usr/local/bin/
[[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
. /usr/local/bin/complete_alias

# complete -F _complete_alias k
complete -F _complete_alias g

# 2024-06-05 krew for kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# 2024-07-28 history
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:ll:'ls -l':'ls -la':history:pwd:exit:which:w:
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTSIZE=1000
export HISTFILESIZE=2000

# 2024-08-06 clip
# https://qiita.com/tawara_/items/0916eaec6ad09fce86a5
function clip() {
  { printf "\xff\xfe"; iconv -t UTF-16LE; } | clip.exe
}

# 2024-09-15 cargo, install https://github.com/mitsuhiko/minijinja/tree/main/minijinja-cli
source $HOME/.cargo/env

# uv
export PATH="$HOME/.local/bin:$PATH"

# stern install from krew
# https://github.com/stern/stern?tab=readme-ov-file#completion
source <(kubectl stern --completion bash)
complete -o default -F __start_stern kubectl stern

# volta
export PATH="$HOME/.volta/bin:$PATH"

# GOPATH
export PATH="$HOME/go/bin:$PATH"
