#!/bin/bash
# Claude Code status line: model (effort) | ctx | 5h | 7d | Jira issue | MRs
export PATH="/opt/homebrew/bin:$PATH"
input=$(cat)
q() { echo "$input" | jq -r "$1 // empty"; }
c() { printf '\033[%sm%s\033[0m' "$1" "$2"; }

# Usage percentage colored green/yellow/red by threshold, plus a dim detail.
pct() {
  [ -z "$2" ] && return
  local p color=32
  p=$(printf '%.0f' "$2")
  [ "$p" -ge 50 ] && color=33
  [ "$p" -ge 80 ] && color=31
  printf '%s %s' "$1" "$(c "$color" "$p%")"
  [ -n "$3" ] && printf ' %s' "$(c 2 "$3")"
}
# Token count as 68k / 1.0M.
tok() { awk -v n="$1" 'BEGIN { if (n >= 1e6) printf "%.1fM", n/1e6; else printf "%.0fk", n/1e3 }'; }

out=()
add() { [ -n "$1" ] && out+=("$1"); }

model=$(q '.model.display_name')
effort=$(q '.effort.level')
[ -n "$model" ] && add "$(c 36 "$model")${effort:+ $(c 2 "($effort)")}"

used=$(q '.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
size=$(q '.context_window.context_window_size')
add "$(pct ctx "$(q '.context_window.used_percentage')" "${used:+$(tok "$used")/$(tok "$size")}")"

reset5=$(q '.rate_limits.five_hour.resets_at')
reset7=$(q '.rate_limits.seven_day.resets_at')
add "$(pct 5h "$(q '.rate_limits.five_hour.used_percentage')" "${reset5:+↻$(date -r "$reset5" +%H:%M)}")"
add "$(pct 7d "$(q '.rate_limits.seven_day.used_percentage')" "${reset7:+↻$(date -r "$reset7" '+%a %H:%M')}")"

cwd=$(q '.workspace.current_dir')
[ -z "$cwd" ] && cwd=$(q '.cwd')
branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)
if [ -n "$branch" ]; then
  jira=$(echo "$branch" | grep -oE '[A-Z][A-Z0-9]+-[0-9]+' | head -n1)
  [ -n "$jira" ] && add "$(c 35 "$jira")"

  # MR lookup cached 5 min per repo+branch; refresh runs in background.
  key=$(printf '%s|%s' "$cwd" "$branch" | cksum | cut -d' ' -f1)
  cache="${TMPDIR:-/tmp}/claude-statusline-mr-$key"
  if [ -z "$(find "$cache" -mmin -5 2>/dev/null)" ]; then
    touch "$cache" # claim the refresh so parallel renders don't stampede
    (
      cd "$cwd" 2>/dev/null || exit 0
      r=$(timeout 20 glab mr list --source-branch "$branch" -F json 2>/dev/null |
        jq -r 'if length == 0 then "" elif length == 1 then "!\(.[0].iid)" else "\(length) MRs" end' 2>/dev/null)
      printf '%s' "$r" >"$cache.tmp" && mv "$cache.tmp" "$cache"
    ) >/dev/null 2>&1 &
    disown 2>/dev/null
  fi
  mr=$(cat "$cache" 2>/dev/null)
  [ -n "$mr" ] && add "$(c 34 "$mr")"
fi

res=""
sep=$(c 2 ' | ')
for s in "${out[@]}"; do res="${res:+$res$sep}$s"; done
printf '%s\n' "$res"
