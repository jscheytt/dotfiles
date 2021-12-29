alias aliases='${=EDITOR} $ZSH_CUSTOM/aliases.zsh'
alias bcop='bundle exec rubocop -a'
alias bfg='java -jar ~/Applications/bfg-1.13.0.jar'
alias bym='bundle install && yarn install && rails db:migrate && rails data:migrate'
alias extstat="find . -type f -name '*.*' -not -iwholename '*.svn*' -not -iwholename '*.git*' -print | sed 's/.*\.//' | sort | uniq -c | sort -r"
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias gpi='git push -u origin HEAD'
alias k='kubectl'
alias k9l="k9s info | grep Logs | awk '{ print \$2 }' | sed -e $'s#\033\[[;0-9]*m##g' | xargs vim"
alias ll='exa -la'
alias myip='curl -s https://api.ipify.org | xargs'
alias php53='docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:5.3.29-cli'
alias rdam='rails data:migrate'
alias ssh-config='${=EDITOR} ~/.ssh/config'
alias tfgraph='terraform graph -draw-cycles | dot -Tsvg > graph.svg'
alias tfmt='tf fmt'
alias vim='nvim'
alias vimdiff='nvim -d'
alias vn="vim -s <(printf 'B3jo2jojJo')"
alias y2j='ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load(STDIN.read))"'

function aws-unassume-role() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}
function aws-resync-mfa() {
  local username=${1:?'Username is 1st parameter'}
  local code1=${2:?'Code 1 is 2nd parameter'}
  local code2=${3:?'Code 2 is 3nd parameter'}
  aws iam resync-mfa-device --user-name $username --serial-number $(aws iam list-mfa-devices --user-name $username | jq -r '.MFADevices[0].SerialNumber') --authentication-code1 $code1 --authentication-code2 $code2
}
function dirdiff() {
  dir1="$1"
  dir2="$2"
  vimdiff <(ls -R "$dir1" | sed "s#$dir1/##g") <(ls -R "$dir2" | sed "s#$dir2/##g")
}
function dki() {
  # docker kill container by image name
  docker kill $(docker ps -qf "ancestor=$1")
}
function dust() {
  du -sch "$@" | sort -hr
}
function poru() {
  # podman run -it --rm --mount type=bind,source="$PWD",target=/"$(basename $PWD)" --workdir=/"$(basename $PWD)" "$@"
  podman run -it --rm "$@"
}
function ecr-login() {
  aws ecr get-login-password \
    | docker login --username AWS --password-stdin \
      $(aws sts get-caller-identity | jq -r '.Account').dkr.ecr.eu-central-1.amazonaws.com
}
function free-port() {
  local port="$1"
  sudo lsof -nP -i4TCP:"$port" | grep LISTEN | awk '{print $2}' | xargs kill -9
}
function jqsort() {
  jq -S '.' "$1" | sponge "$1"
}
function kdebug() {
  local variant="${1:-shell}"
  case "$variant" in
    shell) local opts='--image=nicolaka/netshoot -- /bin/bash';;
    mysql) local opts='--image=imega/mysql-client -- /bin/sh';;
    kubectl) local opts='--image=bitnami/kubectl:1.19 -- /bin/sh';;
    *) echo "Variant not recognized!" && (exit 1) && true;;
  esac
  local namespace="$2"
  if [ -n "$namespace" ]; then opts="-n $namespace $opts"; fi
  # alias kdebug='kubectl run tmp-shell --rm -i --tty --overrides='"'"'{ "apiVersion": "v1", "spec": { "hostNetwork": true } }'"'"' --image=nicolaka/netshoot -- /bin/bash'
  kubectl run "tmp-$variant" --rm -i --tty $(echo $opts)
  kubectl wait --for=delete pod/"tmp-$variant"
}
function kex() {
  local app_name="$1"
  shift
  local entrypoint=${@:-/bin/bash}
  pod_name=$(kubectl get po -l "app=$app_name" -o jsonpath="{.items[0].metadata.name}") || \
    pod_name=$(kubectl get po -l "app.kubernetes.io/name=$app_name" -o jsonpath="{.items[0].metadata.name}")
  kubectl exec -it "$pod_name" -- $(echo $entrypoint)
}
function mas_install() {
  local app_name="${1:?'Parameter #1 is app name'}"
  mas install $(mas search $app_name | head -n1 | awk -F ' ' '{print $1}')
}
function pathogen() {
  cd ~/.vim_runtime/my_plugins
  git clone --recurse-submodules "$1"
  cd -
}
function rdbs() {
  bundle exec rails db:migrate:reset
  bundle exec rails db:seed
}
function upgrade() {
  # Homebrew
  brew upgrade
  brew upgrade --cask
  mas upgrade
  brew bundle dump -f --mas --file ~/Documents/dotfiles/Brewfile
  # Git pull
  gitup -t -1 ~/Documents
  # Other upgrades
  upgrade_vim
  "$ZSH/tools/upgrade.sh"
  omz changelog
}
function upgrade_vim() {
  local vim_dir=~/.vim_runtime
  git -C "$vim_dir" restore .
  git -C "$vim_dir" clean -fd
  git -C "$vim_dir" pull --rebase
  pyenv shell $(cat ~/Documents/dotfiles/.python-version)
  pip install requests
  python "$vim_dir"/update_plugins.py
  pyenv shell -
  gitup "${vim_dir}/my_plugins"
}
function yp() {
  yq e . "$1" -j | jq -C . | less -R
}
