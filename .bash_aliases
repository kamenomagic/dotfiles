echo "Sourcing bash_aliases..."
echo "Setting aliases..."

alias a='tmux a || tmux'
alias s='sudo'
alias d='docker'
alias g='git'
j() {
    clear
    if type exa >/dev/null 2>&1; then exa -alh; else ls -alh; fi
    git branch --color=always 2> /dev/null
    git status 2> /dev/null
    git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%d %s" --color=always 2> /dev/null | head -n 3
}
alias k='fd'
alias l='rg'

alias c='code'
alias ll='ls -al'


#Bashrc Helpers
update_dotfiles() {
  pushd ~
  echo "Updating dotfiles..."
  url='git@github.com:kamenomagic/dotfiles.git'
  dotfiles="$HOME/dotfiles"
  if [ -d "$dotfiles" ]; then
    pushd "$dotfiles" 
    git pull
    popd
  else
    git clone "$url"
  fi
  bash ./dotfiles/create_simlinks.sh
  popd
}

with_ssh_key() {
  ssh-agent bash -c "ssh-add $1; ${@:2}"
}

refresh_ssh() {
  if [ -e ~/dotfiles/.ssh_config ]; then
    cat ~/dotfiles/.ssh_config 2> /dev/null > ~/.ssh/config
  fi
}

xkeymap() {
  setxkbmap -option ctrl:nocaps 2> /dev/null
}

#Expo, poetry
function hotwatch {
  while inotifywait -r -e close_write $1; do eval "$2"; touch `find . -type f | grep "$3\$"`; done;
}
function hotwatchyarn {
  hotwatch $1 "yarn add $1" ".js";
}
function hotwatchpoetry {
  echo "poetry remove `echo $1 | awk -F/ '{print $NF}'` && poetry add $1"
  package=`echo $1 | awk -F/ '{print $NF}'` 
  hotwatch $1 "poetry remove $package && poetry add $1" ".py";
}
function hotwatchpytest {
  hotwatch ./ "poetry run pytest" ""
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
function gadc { gad && goc -m "$1" && j; } # git blurb
function gush { git add . && git commit -m "$1" && git push && j; } # git blurb

git config --global pager.branch false

#Poetry
alias pun='poetry run'

#Windows/WSL
alias ps="powershell.exe -Command"
alias pspython="ps 'C:\\\\Users\\sjaco\\AppData\\Local\\Programs\\Python\\Python39\\python.exe'"
alias pspoetry="ps 'C:\\\\Users\\sjaco\\AppData\\Roaming\\Python\\Scripts\\poetry.exe'"
alias pspyinstaller="ps 'C:\\\\Users\\sjaco\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\pyinstaller.exe'"

#Docker
alias dc='docker-compose'
alias sdc='sudo docker-compose'
alias dm='docker-machine'

alias bex='bundle exec'

#Terraform
alias tf='terraform'

#Kubernetes
function kelp { cat $HOME/.bash_aliases | grep 'kube blurb'; } # kube blurb
alias ku='kubectl' # kube blurb
alias kue='ku get events --sort-by=".metadata.creationTimestamp"' # kube blurb
alias kua='ku apply -f' # kube blurb
alias kuc='ku create -f' # kube blurb
alias kucr='ku create' # kube blurb
alias kude='ku delete' # kube blurb
alias kud='ku describe' # kube blurb
alias kupa='ku patch' # kube blurb
alias kug='ku get' # kube blurb
alias kuj='ku get all' # kube blurb
alias kux='ku exec' # kube blurb
alias kul='ku logs' # kube blurb
alias kuproxy='ku proxy' # kube blurb
alias kufig='ku config' # kube blurb
alias kussh='docker run -it --rm --privileged --pid=host justincormack/nsenter1' # kube blurb
alias kulocal='kufig use-context docker-desktop' # kube blurb
alias nl0='nl -v 0'
function kuspace { kufig set-context --current --namespace="$1"; } # kube blurb
function kugetcontextindexbyname { kufig get-contexts | nl0 | grep $1 | awk '{print $1}'; }
function kugetcontextnamebyindex { kufig get-contexts | nl0 | awk -v i=$1 '$1 == i {print $3}'; }
function kutext { # kube blurb
  kufig get-contexts | nl0; # kube blurb
  read -n 1 -p "Select a context (number): " contextIndex; # kube blurb
  echo ""
  defaultContextIndex=`kugetcontextindexbyname docker-desktop`; # kube blurb
  contextIndex=${contextIndex:-$defaultContextIndex}; # kube blurb
  contextName=`kugetcontextnamebyindex $contextIndex` # kube blurb
  echo "kufig use-context $contextName"; # kube blurb
  kufig use-context $contextName; # kube blurb
} # kube blurb
function kupdateconfig { aws eks update-kubeconfig --name channels-email --profile eks-deploy-user-$1; } # kube blurb
function kutoken { aws eks get-token --cluster-name channels-email --profile "eks-deploy-user-$1" | jq -r .status.token; } # kube blurb
alias kurl='sensible-browser http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default' # kube blurb
function  kut { kutoken $1 | clip.exe; } # kube blurb
function kup { kupdateconfig $1 && kut $1 && kurl $1; kuproxy; } # kube blurb

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
ipconfig=`ipconfig.exe 2> /dev/null`
wslipconfig=`echo "$ipconfig" | sed -n '/WSL/,$p'`
export WINDOWS_IP=`echo "$ipconfig" | grep -Pom 1 '^\s*IPv4.*:\s\K(?!172)(.*)'`
export WSL_IP=`echo "$wslipconfig" | grep -Pom 1 '^\s*IPv4.*:\s\K172(.*)'`

export PATH=~/bin:/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export EDITOR=vim
export TERM=screen-256color

update_dotfiles
j
