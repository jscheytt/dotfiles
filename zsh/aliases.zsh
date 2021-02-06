alias aliases='${=EDITOR} $ZSH_CUSTOM/aliases.zsh'
alias bcop='bundle exec rubocop -a'
alias bfg='java -jar ~/Applications/bfg-1.13.0.jar'
alias bppg="docker run --rm --name tf-postgres -e POSTGRES_DB='pipelines' -e POSTGRES_USER='test_user' -e POSTGRES_PASSWORD='test_user_password' -p 5432:5432 postgres:11"
alias bym='bundle install && yarn install && rails db:migrate && rails data:migrate'
alias cz='git cz'
alias ecr-login='aws --profile prod ecr get-login-password | docker login --username AWS --password-stdin ***REMOVED***.dkr.ecr.eu-central-1.amazonaws.com'
alias extstat="find . -type f -name '*.*' -not -iwholename '*.svn*' -not -iwholename '*.git*' -print | sed 's/.*\.//' | sort | uniq -c | sort -r"
alias j2y='ruby -ryaml -rjson -e "puts YAML.dump(JSON.parse(STDIN.read))"'
alias ll='exa -la'
alias myip='curl -s https://api.ipify.org'
alias php53='docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:5.3.29-cli'
alias rdam='rails data:migrate'
alias ssh-config='${=EDITOR} ~/.ssh/config'
alias suite-container='docker ps -lqf name=app_suitecrm'
alias suite-db-local='docker exec -it $(docker ps -qf name=mariadb_1) mysql -u bn_suitecrm bitnami_suitecrm'
alias suite-ssh='docker exec -it $(suite_container) env TERM=xterm-256color /bin/bash'
alias t3log='$EDITOR /Volumes/Transline/Transact/3.7.0/customers/transline/dirs/log/$(date +%Y-%m-%e)/transact.log'
alias tfgraph='terraform graph -draw-cycles | dot -Tsvg > graph.svg'
alias tfmt='tf fmt'
alias vim='nvim'
alias vimdiff='nvim -d'
alias y2j='ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load(STDIN.read))"'

function aws-assume-role() {
  profile="$1"
  if [ "$profile" = "dev" ]; then local account_id="***REMOVED***"; fi
  if [ "$profile" = "prod" ]; then local account_id="***REMOVED***"; fi
  temp_role=$(aws sts assume-role --role-arn "arn:aws:iam::${account_id}:role/development-admin" --role-session-name "jsc")
  export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs)
  export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs)
  export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs)
  env | grep -i AWS_
}
function aws-unassume-role() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}
function bpbuild() {
  # Run in repo root dir to automatically get the Dockerfile
  image="$1"
  shift
  docker build --memory=1g --memory-swap=1g -t "$image" . "$@"
}
function bpdebug() {
  # Run after bpbuild or from existing image
  image="$1"
  shift
  workdir="$(basename $PWD)"
  docker run -it \
    "$@" \
    --volume="$PWD":/"$workdir" \
    --workdir=/"$workdir" \
    --memory=4g \
    --memory-swap=4g \
    --memory-swappiness=0 \
    "$image"
}
function dirdiff() {
  dir1="$1"
  dir2="$2"
  vimdiff <(ls -R "$dir1" | sed "s#$dir1/##g") <(ls -R "$dir2" | sed "s#$dir2/##g")
}
function dust() {
  du -hs "$@" | sort -hr
}
function kpf() {
  kubectl port-forward pod/$(kubectl get po -l "$1" -o jsonpath="{.items[0].metadata.name}") $2
}
function kex() {
  local selector="$1"
  shift
  local entrypoint=${@:-/bin/bash}
  kubectl exec -it $(kubectl get po -l "$selector" -o jsonpath="{.items[0].metadata.name}") -- $entrypoint
}
function parseYaml() {
  yq e . "$1" -j | jq -C . | less -R
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
  echo -e "\n\n## brew"
  brew upgrade
  brew upgrade --cask
  brew bundle dump -f --file ~/Documents/ecosystem/dotfiles/Brewfile
  echo -e "\n\n## git"
  cd ~/Documents
  mu up --all
  mu pull origin master --no-edit -q
  cd -
  echo -e "\n\n## helm"
  AWS_PROFILE=prod helm repo update
  echo -e "\n\n## vim"
  upgrade_vim
  echo -e "\n\n## npm"
  npm outdated -g --depth=0
  npm update -g
  echo -e "\n\n## joplin"
  joplin sync
  echo -e "\n\n## oh_my_zsh"
  omz update
}
function upgrade_vim() {
  OLD_PWD=$PWD
  cd ~/.vim_runtime
  git restore .
  git clean -f
  git pull --rebase
  python update_plugins.py
  cd my_plugins
  find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
  cd $OLD_PWD
}
