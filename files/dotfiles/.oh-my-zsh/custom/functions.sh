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
	kubelogin) local filepath="$HOME"/.kube/cache/oidc-login ;;
	docker) local filepath="$HOME"/.docker/config.json ;;
	*) echo "Variant not recognized!" && (exit 1) && true ;;
	esac
	rm -rf "$filepath"
}

# Inspect Docker image without pulling.
function dii() {
	local name="$1"
  docker buildx imagetools inspect --format "{{json .}}" "$name"
}

# Get ID of running Docker container by name filter
function drid() {
	local name="$1"
	docker ps --latest --filter name="$name" --format "{{.ID}}"
}

function dirdiff() {
	dir1="$1"
	dir2="$2"
	# shellcheck disable=SC2012
	nvim -d <(ls -R "$dir1" | sed "s#$dir1/##g") <(ls -R "$dir2" | sed "s#$dir2/##g")
}

# Shortcut for diff.kustomize target
function dfku() {
	local filepath="$1"
	make diff.kustomize diff_source="$filepath" | diff-so-fancy
}

# Docker Pull-Forward (pull locally and push to another registry)
function dpf() {
	local source_tag="$1"
	local target_tag="$2"
	docker pull "$source_tag"
	docker tag "$source_tag" "$target_tag"
	docker push "$target_tag"
}

function dki() {
	# docker kill container by image name
	docker kill "$(docker ps -qf "ancestor=$1")"
}

function dust() {
	du -sch "$@" | sort -hr
}

# Create a Kubernetes .dockerconfigjson and output it to stdout
function dockerconfigjson() {
	local docker_registry="${1}"
	local docker_registry_username="${2}"
	local docker_registry_password="${3}"
	kubectl create secret docker-registry irrelevant \
		--docker-server="${docker_registry}" \
		--docker-username="${docker_registry_username}" \
		--docker-password="${docker_registry_password}" \
		--dry-run=client \
		-o=yaml |
		grep ".dockerconfigjson: " |
		awk '{print $2}' |
		base64 --decode
}

function doru() {
	docker run --rm -it --volume="$PWD":/workspace --workdir=/workspace "$@"
}

function ecr-login() {
	aws ecr get-login-password |
		docker login --username AWS --password-stdin \
			"$(aws sts get-caller-identity | jq -r '.Account')".dkr.ecr.eu-central-1.amazonaws.com
}

function free-port() {
	local port="$1"
	sudo lsof -nP -i4TCP:"$port" | grep LISTEN | awk '{print $2}' | xargs kill -9
}

# Execute a Git command on all Git repositories
# $1: Path with Git repositories in subdirectories
# Rest of parameters: Git command (e.g. "status")
function git-xargs() {
	local filepath="$1"
	# shellcheck disable=SC2116
	gitup --depth -1 "$filepath" --exec "git $(echo "${@:2}")"
}

function jqsort() {
	jq -S '.' "$1" | sponge "$1"
}

function kdebug() {
	local variant="${1:-alpine}"
	# First, clean up in case connection was lost previously
	kubectl delete pod/"tmp-$variant"
	kubectl wait --for=delete pod/"tmp-$variant"
	case "$variant" in
	alpine) local opts='--image=alpine:3' ;;
	awscli) local opts='--image=woahbase/alpine-awscli -- /bin/bash' ;;
	azure-cli) local opts='--image=mcr.microsoft.com/azure-cli -- /bin/sh' ;;
	mysql) local opts='--image=imega/mysql-client -- /bin/sh' ;;
	postgres) local opts='--image=postgres:alpine -- /bin/sh' ;;
	kubectl) local opts='--image=bitnami/kubectl -- /bin/sh' ;;
	*) echo "Variant not recognized!" && (exit 1) && true ;;
	esac
	local namespace="$2"
	if [ -n "$namespace" ]; then opts="-n $namespace $opts"; fi
	# shellcheck disable=SC2046,SC2116,SC2086
	kubectl run "tmp-$variant" --rm -i --tty $(echo $opts)
	kubectl wait --for=delete pod/"tmp-$variant"
}

# Kubectl Debug for containers without a Shell
function kds() {
	local labels="$1"
	local image="${2:-alpine:3}"
	kubectl debug -it --image="$image" "$(kubectl get po -l="$labels" -o=name | head -n1)"
}

# kubectl rollout wait
function krowt() {
	local deployment_name="$1"
	local timeout="${2:-20m}"
	if kubectl rollout status deploy "$deployment_name" -w --timeout="$timeout"; then
		say-english "Deployment rollout has finished"
	else
		say-english "Waiting for Deployment rollout has timed out"
	fi
}

# Find App Store app by substring and uninstall
function mas-uninstall-lucky() {
	local app_name="${1:?'Parameter #1 is app name'}"
	mas list |
		grep -i "$app_name" |
		awk '{print $1}' |
		xargs -I {} mas uninstall {}
}

# Open NeoVim as notepad
function nvo() {
	\cat <<EOF | nvim -s -
:NERDTreeFromBookmark scratch.md
Go
EOF
}

# Simulate native Buildpacks experience by hooking into the lifecycle
function pack_build() {
	local builder="${1}"
	shift
	docker run --volume="$PWD":/workspace --workdir=/workspace "$builder" /cnb/lifecycle/creator "$@"
}

# Replace pattern with replacement in multiple files recursively.
function replace_in_files() {
	local pattern="$1"
	local replacement="$2"
	local file_extensions="$3"
	find -E . -type f -regex ".*\.(${file_extensions})" \
		-exec sed -i '' -E "s#${pattern}#${replacement}#g" {} \;
}

# Rename a file and change all its references in files.
function rename_replace_in_files() {
	local source_filepath="$1"
	local target_filepath="$2"
	local file_extensions="$3"
	mkdir -p "$(dirname "$target_filepath")"
	mv "$source_filepath" "$target_filepath"
	replace_in_files "$source_filepath" "$target_filepath" "$file_extensions"
}

# Use English voice and reduce volume
# Needs "Lee" macOS voice - I think you have to download this manually
function say-english() {
	say -v Lee "[[volm 0.3]] $1"
}

# Find all cloned repos with a configured remote (so not just inited), then run fetch all.
function update_repos_with_remote() {
	echo "INFO: Updating local Git repos ..."
	git config --global --unset-all maintenance.repo || true
	gfind "$HOME/Documents" -name HEAD \
		-not -path "$HOME/Documents/archive/*" \
		-not -path "$HOME/Documents/experiments/*" \
		-execdir sh -c \
		'test -d refs/remotes -a -d objects && find refs/remotes -mindepth 1 -maxdepth 1 | read' \; \
		-printf %h\\n |
		xargs -I {} git config --global --add maintenance.repo {}
	git for-each-repo --config=maintenance.repo fetch
	# Remove entries again so we don't leak customer specifics
	git config --global --unset-all maintenance.repo || true
	echo "INFO: Finished updating local Git repos"
}

function upgrade() {
	# Homebrew
	HOMEBREW_NO_ENV_HINTS=1 brew upgrade
	mas upgrade
	brew bundle dump --force --file "$HOME/Documents/personal/dotfiles/Brewfile"
	# Neovim plugins
	nvim --headless +'PlugUpgrade' +'PlugInstall' +'PlugUpdate --sync' +'qa'
	# oh-my-zsh
	"$ZSH/tools/upgrade.sh"
	omz changelog
	# Local Git clones
	update_repos_with_remote
}

function yp() {
	yq "$1" -o=json | jq -C . | less -R
}
