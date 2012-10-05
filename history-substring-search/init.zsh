source-relative 'external/zsh-history-substring-search.zsh'

# Options {{{
if zstyle -t ':zoppo:plugin:history-substring-search' case-sensitive; then
  unset HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS
fi

if ! zstyle -t ':zoppo:plugin:history-substring-search' color; then
  unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
else
  zstyle -s ':zoppo:plugin:history-substring-search:colors' found color
  [ $color ] && HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="$color"

  zstyle -s ':zoppo:plugin:history-substring-search:colors' not-found color
  [ $color ] && HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="$color"

  unset color
fi
# }}}

# Key Bindings {{{
if [[ -n $key_info ]]; then
  # EMACS
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # EMACS and vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done
fi
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
