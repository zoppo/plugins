functions:autoload add-zsh-hook

function terminal:precmd:title {
  if zstyle -t ':zoppo:plugin:terminal' auto-title; then
    terminal:title-with-path
  fi
}

function terminal:preexec:title {
  if zstyle -t ':zoppo:plugin:terminal' auto-title; then
    terminal:title-with-command "$2"
  fi
}

add-zsh-hook precmd terminal:precmd:title
add-zsh-hook preexec terminal:preexec:title

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
