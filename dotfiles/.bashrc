# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# 忽略重复的命令, or force ignoredups and ignorespace
# HISTCONTROL=ignoreboth
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}erasedups
export HISTCONTROL=ignoreboth:erasedups
# 忽略由冒号分割的这些命令, ignore duplicate command and space lead command
export HISTIGNORE="[]*:bg:fg:ls:pwd:exit:top:clear:df *:?:??:???:?? ?"
# 设置保存历史命令的文件大小
export HISTFILESIZE=1000000000
# 保存历史命令条数
export HISTSIZE=1000000
# show Time of command
export HISTTIMEFORMAT='%F %T '

# append to the history file, don't overwrite it. (muplite terminal)
shopt -s histappend
# history will be nicely up-to-date and synchronized with any other terminals.
# http://briancarper.net/blog/248/
# export PROMPT_COMMAND="history -a; history -n"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
alias u='history -n'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# use arrow up and down to search start with command. about command, check on man readline
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w:\u@\h\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias wd='cd $WORKDIR'
alias ls='ls -G'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# fabic complete from http://foobar.lu/wp/2012/03/20/custom-bash-completion-for-fabric-tasks/
function _fab_complete() {
    local cur
    if [ -f "fabfile.py" ]; then
cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(fab -F short -l)" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.
        return 1
    fi
} 

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    complete -o nospace -F _fab_complete fab
    complete -W "$(teamocil --list)" teamocil
fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#git
# if [ -f /etc/bash_completion.d/git-completion.bash ]; then

#     . /etc/bash_completion.d/git-completion.bash;

# fi

# export GIT_PS1_SHOWDIRTYSTATE=1

# export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]\$(__git_ps1 ' %s')\[\033[01;34m\] \$\[\033[00m\] "

# export PS1="\[\033[G\]$PS1"

# Django 
#. ~/Scripts/django_bash_completion
# Devtodo
# . /usr/share/devtodo/contrib/devtodo.bash-completion
# source /usr/share/doc/devtodo/examples/scripts.sh
# TODO_OPTIONS="--timeout --summary"

# devtodocd ()
# {
# 	builtin cd "$@"
# 	RV=$?
# 	[ $RV = 0 -a -r .todo ] && devtodo ${TODO_OPTIONS}
# 	return $RV
# }

# devtodopushd ()
# {
# 	builtin pushd "$@"
# 	RV=$?
# 	[ $RV = 0 -a -r .todo ] && devtodo ${TODO_OPTIONS}
# 	return $RV
# }

# devtodopopd ()
# {
# 	builtin popd "$@"
# 	RV=$?
# 	[ $RV = 0 -a -r .todo ] && devtodo ${TODO_OPTIONS}
# 	return $RV
# }

# alias cd='devtodocd'
# Run todo initially upon login
# devtodo ${TODO_OPTIONS}

# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
# Perform mkdir and cd using a single command
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# Use “shopt -s cdspell” to automatically correct mistyped directory names on cd
shopt -s cdspell
#shopt -s autocd # will automatically cd if only a dir is given
shopt -s cdable_vars # will let you cd into a variable

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# virtualenv
export WORKON_HOME=$HOME/ws/venv
source /usr/local/bin/virtualenvwrapper.sh
# http://blog.arongriffis.com/post/dynamic-virtualenvwrapper
#source ~/.bashrc.virtualenvwrapper

# virtualenv aliases
# http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --distribute'
alias v.mk_withsitepackages='mkvirtualenv --system-site-packages'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'
alias v.ll='pip freeze -l'
alias v.a='source env/bin/activate'
# pip should only run if there is a virtualenv currently activated
# export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/download_cache
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

export LANG=en_US.utf8
export LC_ALL=en_US.UTF-8
# export TZ='Asia/Shanghai'
# export PATH=/usr/local/sbin:~/.local/bin:/usr/local/mysql/bin:/Applications/Android\ Studio.app/sdk/platform-tools:~/App/google_appengine:$PATH
export WORKDIR=~/ws/
#add perl lib path for moudles install by user
#export PERL5LIB=/home/too/path/to
export PERL_MM_USE_DEFAULT=1  #CPAN auto install prerequistes
#export LD_LIBRARY_PATH=/home/too/Downloads/oci/ic  #oracle
#export TNS_ADMIN=/home/too/Downloads/oci/ic  #oracle
#export ORACLE_HOME=/home/too/Downloads/oci/ic  #oracle
# use CDPATH, can cd subdir in anywhere.
export CDPATH='.:~:/Users/too/ws'
# export PYTHONPATH='/home/too/ws/django/django-debug-toolbar'
export AUTOSSH_DEBUG=DEBUG
export AUTOSSH_LOGFILE=~/.autohssh.log

# readline variables and bindings
#bind 'set keymap vi'
#bind 'set editing-mode vi'
# bind 'set mark-directories on'
# bind 'set mark-symlinked-directories on'
# bind 'set page-completions off'
# bind 'set show-all-if-ambiguous on'
# bind 'set visible-stats on'
# bind 'set completion-query-items 9001'

# let Ctrl-s work, to disable XON/XOFF flow control
stty -ixon

# boot services script
# ~/Scripts/dropbox.py start
# rescuetime_linux_uploader > /dev/null 2>&1 &

# https://github.com/milkbikis/powerline-shell   show git info in bash prompt.
function _update_ps1()
{
    export PS1="$(~/Scripts/powerline-shell.py --cwd-only $? 2> /dev/null)"
    # export PS1="$(~/Scripts/powerline-shell.py --cwd-max-depth 3 $? 2> /dev/null)"
}
# export PROMPT_COMMAND="history -a; _update_ps1"

# Run Django management commands
# Assumes project directory is symlinked as `src` in the root of the virtualenv
function dmc(){
    cd src
    python manage.py $1
    cd ..
}

function cfab(){
    cd env
    bin/fab $1
    cd ..
}

function cjson(){
    curl -H "Cookie:opus_session=$1" -k $2 |python -m json.tool|pygmentize -l json
}

function manswitch()
{ man -P "less -p \"^ +$2\"" $1; }

export EDITOR='vim'
# export ALTERNATE_EDITOR=vim EDITOR=emacsclient VISUAL=emacsclient
export TERM=xterm-256color


# https://github.com/wting/autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export HOWDOI_SEARCH_ENGINE=bing
