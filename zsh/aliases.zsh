alias aliases='${=EDITOR} $ZSH_CUSTOM/aliases.zsh'
alias bcop='bundle exec rubocop -a'
alias bfg='java -jar ~/Applications/bfg-1.13.0.jar'
alias bppg="docker run --rm --name tf-postgres -e POSTGRES_DB='pipelines' -e POSTGRES_USER='test_user' -e POSTGRES_PASSWORD='test_user_password' -p 5432:5432 postgres:11"
alias bspec='bundle exec rescue rspec'
alias cz='git cz'
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up'
alias drab='docker-compose run --rm app bundle'
alias extstat="find . -type f -not -iwholename '*.svn*' -not -iwholename '*.git*' | sed 's/.*\.//' | sort | uniq -c | sort -r"
alias j2y='ruby -ryaml -rjson -e "puts YAML.dump(JSON.parse(STDIN.read))"'
alias jo='joplin'
alias kc='kubectl'
alias ll='exa -la'
alias myip='curl -s https://api.ipify.org'
alias ssh-config='${=EDITOR} ~/.ssh/config'
alias suite_container='docker ps -lqf name=app_suitecrm'
alias suite_db_local='docker exec -it $(docker ps -qf name=mariadb_1) mysql -u bn_suitecrm bitnami_suitecrm'
alias suite_ssh='docker exec -it $(suite_container) env TERM=xterm-256color /bin/bash'
alias t3log='$EDITOR /Volumes/Transline/Transact/3.7.0/customers/transline/dirs/log/$(date +%Y-%m-%e)/transact.log'
alias tbdev="docker-compose run --rm -p 3000:3000 -e RAILS_ENV=development app bundle exec rails s -p 3000 -b '0.0.0.0'"
alias tf='terraform'
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
  local entrypoint="${2:-/bin/bash}"
  kubectl exec -it $(kubectl get po -l "$selector" -o jsonpath="{.items[0].metadata.name}") -- "$entrypoint"
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
function tbs() {
  # Takes about 11 min
  docker-compose run --rm app curl elasticsearch:9200 # wait for OK status
  docker-compose run --rm app bundle install
  docker-compose run --rm app yarn install
  docker-compose run --rm app bundle exec rake db:setup
  docker-compose run --rm app bundle exec rake db:schema:load
  docker-compose run --rm app bundle exec rake db:seed
  docker-compose run --rm app bundle exec rake demo_data:generate
  docker-compose run --rm app bundle exec rake tasks_samples:generate
  docker-compose run --rm app bundle exec rake db:reindex_elasticsearch
}
function upgrade() {
  echo -e "## git"
  cd ~/Documents
  mu up --all
  mu pull origin master --no-edit -q
  cd -
  echo -e "\n\n## helm"
  AWS_PROFILE=prod helm repo update
  echo -e "\n\n## vim"
  upgrade_vim
  echo -e "\n\n## oh_my_zsh"
  upgrade_oh_my_zsh
  echo -e "\n\n## brew"
  brew upgrade
  brew cask upgrade
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
