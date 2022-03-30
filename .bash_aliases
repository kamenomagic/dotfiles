echo "Sourcing bash_aliases..."
echo "Setting aliases..."

alias a='tmux a'
alias s='sudo'
alias d='docker'
alias g='git'
j() {
    clear
    if type exa >/dev/null 2>&1; then exa -alh; else ls -alh; fi
    git branch --color=always 2> /dev/null
    git status 2> /dev/null
    git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%d %s" --color=always 2> /dev/null | head -n 10
}
alias k='fd'
alias l='rg'

alias c='code'
alias ll='ls -al'

#Bashrc Helpers
pull_bash_aliases() {
  echo "Pulling bash_aliases..."
  s=`curl -k -s -m 3 -o ~/.bash_aliases_temp https://github.com/kamenomagic/dotfiles/bash_aliases`
  if [ -e ~/.bash_aliases_temp ]; then
      cmp --silent ~/.bash_aliases ~/.bash_aliases_temp || (mv ~/.bash_aliases_temp ~/.bash_aliases && source ~/.bash_aliases)
  fi
  rm ~/.bash_aliases_temp 2> /dev/null
}

with_ssh_key() {
  ssh-agent bash -c "ssh-add $1; ${@:2}"
}

refresh_ssh() {
  if [ -e ~/.ssh_config ]; then
    cat ~/.ssh_config 2> /dev/null > ~/.ssh/config
  fi
}

xkeymap() {
  setxkbmap -option ctrl:nocaps 2> /dev/null
}

#Git
function gelp { cat $HOME/.bash_aliases | grep 'git blurb'; } # git blurb
function ga { git add "$@" && j; } # git blurb
function gad { git add . && j; } # git blurb
function gam { git commit --amend "$@" && j; } # git blurb
function goc { git commit "$@" && j; } # git blurb
function gec { git checkout "$@" && j; } # git blurb
function gus { git push "$@" && j; } # git blurb
function gul { git pull "$@" && j; } # git blurb
function gin { git init "$@" && j; } # git blurb
function gef { git fetch "$@" && j; } # git blurb
function gid { git diff "$@" && j; } # git blurb
function gosh { git show "$@" && j; } # git blurb
function germ { git merge "$@" && j; } # git blurb
function gerb { git rebase "$@" && j; } # git blurb
function gers { git reset "$@" && j; } # git blurb
function gast { git status "$@" && j; } # git blurb
function glog { git log "$@" && j; } # git blurb
function glone { git clone "$@" && j; } # git blurb
function gush { git add . && git commit -m "$1" && git push && j; } # git blurb

git config --global pager.branch false

#Docker
alias dc='docker-compose'
alias sdc='sudo docker-compose'
alias dm='docker-machine'

alias bex='bundle exec'

#Values
echo "Setting colored text shortcuts..."
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

black() { echo -e $BLACK"$@"$NORMAL; }
red() { echo -e $RED"$@"$NORMAL; }
green() { echo -e $GREEN"$@"$NORMAL; }
yellow() { echo -e $YELLOW"$@"$NORMAL; }
blue() { echo -e $BLUE"$@"$NORMAL; }
pink() { echo -e $PINK"$@"$NORMAL; }
cyan() { echo -e $CYAN"$@"$NORMAL; }
white() { echo -e $WHITE"$@"$NORMAL; }

echo "Setting terminal and autocomplete settings..."
_ssh() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

bindkey -v
bindkey '^R' history-incremental-search-backward

complete -F _ssh ssh
set -o vi

echo "Setting environment variables..."
export PATH=~/synchronicity/bin:~/bin:/opt/arduino:/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export EDITOR=vim
export TERM=screen-256color

url='https://github.com/kamenomagic/dotfiles'
echo "Pulling vimrc..."; curl "$url/vimrc" -k -m1 -s -o ~/.vimrc
echo "Pulling tmux.conf..."; curl "$url/tmux.conf" -k -m1 -s -o ~/.tmux.conf
echo "Pulling ssh_config..."; curl "$url/ssh_config" -k -m1 -s -o ~/.ssh_config
echo "Pulling vrapperrc..."; curl "$url/vrapperrc" -k -m1 -s -o ~/.vrapperrc
j
