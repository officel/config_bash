# .dotfiles/alias

# command
alias ls='ls --group-directories-first'
alias ll='ls -l'
alias lla='ls -al'
alias tree='tree --charset unicode -aNI ".git|node_modules|.terraform"'
alias myip='curl -s inet-ip.info'
alias mypath='echo $PATH | tr ":" "\n"'
alias diff='diff --exclude=.terraform --exclude=.git'
alias greps='grep -v -e '\''^\s*#'\'' -e '\''^\s*$'\'''
alias curlh='curl -D - -s -o /dev/null -sSL'
alias pwgen='pwgen -c -n -B -1'
alias fullpath='find `pwd` -maxdepth 1 -name'
alias expenv='export $(grep -v "^#" .env | xargs)'

alias aq='aqua'
alias aqcd="cd ${XDG_CONFIG_HOME:-$HOME/.config}/aqua/"
alias aqgi='aqua generate -i -o $AQUA_GLOBAL_CONFIG'
alias aqia='aqua install --all'
alias aqli='aqua list --installed --all | sort'
alias aqup='aqua update'

# ansible
alias ansible-playbook='TZ="Asia/Tokyo" ANSIBLE_LOG_PATH=logs/ansible_$(date "+%Y%m%d%H%M%S").log ansible-playbook'
alias ansible-groups='ansible-inventory --list | jq -r "keys | .[]"'

# aws cli with jq
alias aec2='aws ec2 describe-instances | jq -r '"'"'.Reservations|sort_by(.Instances[].Tags[]|select(.Key == "Name").Value)| .[].Instances[]|[(.Tags[]|select(.Key == "Name").Value), .InstanceId, .PrivateIpAddress, .State.Name] | @tsv'"'"''
alias aec2start='aws ec2 start-instances --instance-ids'
alias aec2stop='aws ec2 stop-instances --instance-ids'
alias aw='aws sts get-caller-identity || (aws sso login --profile default && aws sts get-caller-identity)'
alias awclear='rm -f ~/.aws/*/cache/*'
alias awc='rm -f ~/.aws/*/cache/*; aws sso login --profile default && aws sts get-caller-identity'

# aws-vault
alias av='aws-vault'
alias avc='aws-vault clear'
alias ave='aws-vault exec'
alias avls='aws-vault list'
#gitignore で終わる行を ignore してみた

# aws-vault & terraform
alias avta='aws-vault exec ${AWS_PROFILE:-default} -- terraform apply'
alias avte='aws-vault exec ${AWS_PROFILE:-default} -- terraform init --upgrade && aws-vault exec ${AWS_PROFILE:-default} -- terraform fmt && aws-vault exec ${AWS_PROFILE:-default} -- terraform plan'
alias avto='aws-vault exec ${AWS_PROFILE:-default} -- terraform output'
alias avtp='aws-vault exec ${AWS_PROFILE:-default} -- terraform plan'
alias avts='aws-vault exec ${AWS_PROFILE:-default} -- terraform state'

# boundary
alias b='boundary'

# docker
alias     d='docker'
alias   dce='docker container exec -it'
alias dclog='docker container logs'
alias dcrun='docker container run -itd --rm'

alias  dps='docker ps'
alias dpss="docker ps | awk 'NR <= 1; NR > 1 { print \$0 | \"sort -k7 -V\" };'"
alias   ds='docker stop'

alias al2='docker container run -itd --rm -e "TZ=Asia/Tokyo" --name al2 amazonlinux'
alias alpinx='docker container run -itd --rm -v `pwd`:/usr/share/nginx/html -p 8081:80 -e "TZ=Asia/Tokyo" --name alpinx nginx:alpine'
alias alpython='docker container run --rm -it -d -e "TZ=Asia/Tokyo" --name alpython python:alpine'
alias jekyll='docker container run -itd --rm -v `pwd`:/srv/jekyll:Z -e "TZ=Asia/Tokyo" --name jekyll jekyll/jekyll jekyll'

alias dc='docker compose'
alias dcd='docker compose down'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcr='docker compose run'

# git
alias g='git'
alias ga='git add ":!\!\!*"'  # :! は除外設定。 !! で始まるファイルを add しない
alias gau='git add -u ":!\!\!*"'
alias gb='git branch'
alias gba='git branch -a'
alias gcan='git commit --amend --no-edit'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gcl='git config --list'
alias gcs='git config --show-origin --show-scope --list'
alias gdc='git diff --cached'
alias gdi='git diff'
alias gdn='git diff --name-only'
alias gds='git diff --stat'
alias gf='git fetch --prune'
alias gg='git grep -i -P'
alias glogs='git log -S'
alias gp='git plog -10'
alias gpa='git plog --all -10'
alias gpr='git pr'
alias gr='git fetch --prune --all && git checkout origin/HEAD && git plog --all -10 && git status'
alias gs='git switch -d origin/HEAD'
alias gss='git show --stat'
alias gst='git status --short --branch'
alias cr='cd "$(git rev-parse --show-toplevel)"'

# k8s use kubecolor
alias k='kubecolor'
alias kubectl='kubecolor'
alias ka='kubectl apply'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgn='kubectl get node -o wide'
alias kgp='kubectl get pod'
alias kgx='kubectl get all,pv,pvc,job,ing'
alias kgpa='kubectl get pod -A'
alias kgtn='kubectl get node -o wide; kubectl top node'
alias kdrainf='kubectl drain --ignore-daemonsets --delete-local-data'

alias stern='kubectl stern'

# taskfile.dev
alias t='task'

# terraform
alias tf='terraform'
alias tfa='terraform apply'
alias tfe='terraform init --upgrade && terraform fmt && terraform plan'
alias tff='terraform fmt'
alias tfi='terraform init'
alias tfiu='terraform init --upgrade'
alias tfir='terraform init -reconfigure'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfs='terraform state'
alias tfv='terraform version'
