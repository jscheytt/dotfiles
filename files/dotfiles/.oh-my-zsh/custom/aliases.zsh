alias aliases='${=EDITOR} $ZSH_CUSTOM/aliases.zsh'
alias cat='bat'
alias bym='bundle install && yarn install && rails db:migrate && rails data:migrate'
alias date-iso='date -u +"%FT%TZ"'
alias date-alphanum='date -u +"%Y%m%dT%H%M%SZ"'
alias extstat="find . -type f -name '*.*' -not -iwholename '*.svn*' -not -iwholename '*.git*' | sed 's/.*\.//' | sort | uniq -c | sort -r"
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias functions='${=EDITOR} $ZSH_CUSTOM/functions.sh'
alias httpyac="docker run -it -v ${PWD}:/data ghcr.io/anweber/httpyac:latest"
alias k9cf='nvim "/Users/josia.scheytt/Library/Application Support/k9s/config.yml"'
alias k9l="k9s info | grep Logs | awk '{ print \$2 }' | sed -e $'s#\033\[[;0-9]*m##g' | xargs ${=EDITOR}"
alias ll='exa -la'
alias mkdocs='docker run --rm -it -v ${PWD}:/docs -p 8000:8000 squidfunk/mkdocs-material'
alias myip='curl -s https://api.ipify.org | xargs'
alias nd='nvim -d'
alias nv='nvim'
alias ssh-config='${=EDITOR} ~/.ssh/config'
alias ssh='/usr/bin/ssh'
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfgraph='terraform graph -draw-cycles | dot -Tsvg > graph.svg'

# Global
alias -g k='kubectl'
alias -g W='| wc -l'
alias -g C='| pbcopy'

source ${0:a:h}/functions.sh
