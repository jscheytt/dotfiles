#!/usr/bin/env bash

function aws-unassume-role() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}

function aws-resync-mfa() {
  local username=${1:?'Username is 1st parameter'}
  local code1=${2:?'Code 1 is 2nd parameter'}
  local code2=${3:?'Code 2 is 3nd parameter'}
  aws iam resync-mfa-device --user-name "$username" --serial-number \
    "$(aws iam list-mfa-devices --user-name "$username" | jq -r '.MFADevices[0].SerialNumber')" \
    --authentication-code1 "$code1" --authentication-code2 "$code2"
}

function clear-cache() {
  local variant="$1"
  case "$variant" in
    kubelogin) local filepath="$HOME"/.kube/cache/oidc-login;;
    docker) local filepath="$HOME"/.docker/config.json;;
    *) echo "Variant not recognized!" && (exit 1) && true;;
  esac
  rm -rf "$filepath"
}

function dirdiff() {
  dir1="$1"
  dir2="$2"
  nvim -d <(ls -R "$dir1" | sed "s#$dir1/##g") <(ls -R "$dir2" | sed "s#$dir2/##g")
}

function dki() {
  # docker kill container by image name
  docker kill "$(docker ps -qf "ancestor=$1")"
}

function dust() {
  du -sch "$@" | sort -hr
}

function doru() {
  docker run -it --volume="$PWD":/"$(basename "$PWD")" --workdir=/"$(basename "$PWD")" "$@"
}

function ecr-login() {
  aws ecr get-login-password \
    | docker login --username AWS --password-stdin \
      "$(aws sts get-caller-identity | jq -r '.Account')".dkr.ecr.eu-central-1.amazonaws.com
}

function free-port() {
  local port="$1"
  sudo lsof -nP -i4TCP:"$port" | grep LISTEN | awk '{print $2}' | xargs kill -9
}

# See https://stackoverflow.com/a/62397081/6435726
function git-get-default-branch() {
  local git_dir="$1"
  local git_cmd="git -C $git_dir"
  git-remote-verify "$git_dir"

  # Pull if default branch was changed on remote
  $(echo $git_cmd) remote set-head origin -a > /dev/null

  # Get local default branch
  $(echo $git_cmd) rev-parse --abbrev-ref origin/HEAD | xargs -I {} basename {}
}
export -f git-get-default-branch > /dev/null

# Remove local branches that were deleted on the remote
function git-prune-local-branches() {
  local git_dir="$1"
  default_branch="$(git-get-default-branch "$git_dir")"
  local git_cmd="git -C $git_dir"
  git-remote-verify "$git_dir"

  echo -e "\nPruning local branches that were deleted on the remote for $git_dir ..."
  # Remove local references to branches that were deleted on the remote branch
  $(echo $git_cmd) remote prune origin
  # Switch to the default branch
  $(echo $git_cmd) switch "$default_branch" &> /dev/null
  # Delete all merged branches apart from the default branch (and some special branches)
  $(echo $git_cmd) branch --merged "$default_branch" \
    | grep -vE "(develop|quality|master|main|$default_branch)\$"
    # | xargs $(echo $git_cmd) branch -d
}
export -f git-prune-local-branches > /dev/null

function git-remote-verify() {
  local git_dir="$1"
  local git_cmd="git -C $git_dir"
  if [[ ! $($(echo $git_cmd) remote -v) ]]; then
    echo -e "\nNo remote present for ${git_dir}. Skipping ..."
    exit 0
  fi
}
export -f git-remote-verify > /dev/null

function git-prune-local-branches-all() {
  make -f "${0:a:h}"/Makefile branches.prune.all
}
function jqsort() {
  jq -S '.' "$1" | sponge "$1"
}

function kdebug() {
  local variant="${1:-shell}"
  # First, clean up in case connection was lost previously
  kubectl delete pod/"tmp-$variant"
  kubectl wait --for=delete pod/"tmp-$variant"
  case "$variant" in
    awscli) local opts='--image=woahbase/alpine-awscli -- /bin/bash';;
    shell) local opts='--image=nicolaka/netshoot -- /bin/bash';;
    mysql) local opts='--image=imega/mysql-client -- /bin/sh';;
    kubectl) local opts='--image=bitnami/kubectl:1.19 -- /bin/sh';;
    *) echo "Variant not recognized!" && (exit 1) && true;;
  esac
  local namespace="$2"
  if [ -n "$namespace" ]; then opts="-n $namespace $opts"; fi
  kubectl run "tmp-$variant" --rm -i --tty $(echo $opts)
  kubectl wait --for=delete pod/"tmp-$variant"
}

# kubectl rollout wait
function krowt() {
  local deployment_name="$1"
  local timeout="${2:-20m}"
  if kubectl rollout status deploy "$deployment_name" -w --timeout="$timeout"; then
    say -v Lee "Deployment rollout has finished"
  else
    say -v Lee "Waiting for Deployment rollout has timed out"
  fi
}

function mas_install() {
  local app_name="${1:?'Parameter #1 is app name'}"
  mas search "$app_name" \
    | head -n1 \
    | awk -F ' ' '{print $1}' \
    | xargs -I {} mas install {}
}

function pathogen() {
  cd "$HOME"/.vim_runtime/my_plugins
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
  mas upgrade
  brew bundle dump -f --mas --file "$HOME"/Documents/dotfiles/Brewfile
  # Git pull
  gitup -t -1 -p "$HOME"/Documents
  # Neovim plugins
  nv +'PlugUpgrade' +'PlugUpdate --sync' +'qa'
  # oh-my-zsh
  "$ZSH/tools/upgrade.sh"
  omz changelog
}

function yp() {
  yq e . "$1" -j | jq -C . | less -R
}
