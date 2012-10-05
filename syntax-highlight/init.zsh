zstyle -t ':zoppo:plugin:highlight' color || return 1

source "${0:h:a}/external/zsh-syntax-highlighting.zsh"

zdefault -a ':zoppo:plugin:highlight' highlighters ZSH_HIGHLIGHT_HIGHLIGHTERS \
  'main' 'brackets' 'pattern' 'cursor' 'root'

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
