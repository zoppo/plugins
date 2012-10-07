if zstyle -t ':zoppo:plugin:utility:ls' color; then
  if ! zstyle -T ':zoppo:plugin:utility:ls' colors; then
    zstyle -s ':zoppo:plugin:utility:ls' colors LS_COLORS

    export LS_COLORS
  elif is-callable 'dircolors'; then
    if [[ -s "$HOME/.dircolors" ]]; then
      eval "$(dircolors "$HOME/.dircolors")"
    else
      eval "$(dircolors)"
    fi
  fi

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  alias ls="${aliases[ls]:-ls} -F"
fi

if zstyle -t ':zoppo:plugin:utility:grep' color; then
  export GREP_OPTIONS="$GREP_OPTIONS --color=auto"

  zstyle -s ':zoppo:plugin:utility:grep' highlight-color GREP_COLOR
  zstyle -s ':zoppo:plugin:utility:grep' colors GREP_COLORS

  export GREP_COLOR GREP_COLORS
fi

alias md='mkdir'

function mcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

alias mkdcd='mcd'

function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
