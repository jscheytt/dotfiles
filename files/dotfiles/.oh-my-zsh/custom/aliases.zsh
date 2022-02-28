alias aliases='${=EDITOR} $ZSH_CUSTOM/aliases.zsh'
alias bcop='bundle exec rubocop -a'
alias bfg='java -jar ~/Applications/bfg-1.13.0.jar'
alias bym='bundle install && yarn install && rails db:migrate && rails data:migrate'
alias date-iso='date -u +"%FT%TZ"'
alias extstat="find . -type f -name '*.*' -not -iwholename '*.svn*' -not -iwholename '*.git*' -print | sed 's/.*\.//' | sort | uniq -c | sort -r"
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias functions='${=EDITOR} $ZSH_CUSTOM/functions.sh'
alias git-prune-remote-deleted-branches='git remotely-deleted-branches | xargs git branch -d'
alias gpi='git push -u origin HEAD'
alias k9cf='nvim "/Users/josia.scheytt/Library/Application Support/k9s/config.yml"'
alias k9l="k9s info | grep Logs | awk '{ print \$2 }' | sed -e $'s#\033\[[;0-9]*m##g' | xargs ${=EDITOR}"
alias k='kubectl'
alias ll='exa -la'
alias myip='curl -s https://api.ipify.org | xargs'
alias nd='nvim -d'
alias nv='nvim'
alias nvo="nvim -s <(printf 'B3jo2jojJo')"
alias php53='docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:5.3.29-cli'
alias rdam='rails data:migrate'
alias ssh-config='${=EDITOR} ~/.ssh/config'
alias tfgraph='terraform graph -draw-cycles | dot -Tsvg > graph.svg'
alias tfmt='tf fmt'
alias y2j='ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load(STDIN.read))"'
alias weekly-reports='bat "$HOME"/Documents/mbio/reports/*'

source ${0:a:h}/functions.sh
