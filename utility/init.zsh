if zstyle -t ':zoppo:plugin:utility:ls' color; then
  if ! zstyle -T ':zoppo:plugins:utility:ls' colors; then
    zstyle -s ':zoppo:plugins:utility:ls' colors LS_COLORS

    export LS_COLORS
  else
    if is-callable 'dircolors'; then
      if [[ -s "$HOME/.dircolors" ]]; then
        eval "$(dircolors "$HOME/.dircolors")"
      else
        eval "$(dircolors)"
      fi
    fi
  fi

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  alias ls="${aliases[ls]:-ls} -F"
fi

if zstyle -t ':zoppo:plugins:utility:grep' color; then
  export GREP_OPTIONS="$GREP_OPTIONS --color=auto"

  zstyle -s ':zoppo:plugins:utility:grep' highlight-color GREP_COLOR
  zstyle -s ':zoppo:plugins:utility:grep' colors GREP_COLORS

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
