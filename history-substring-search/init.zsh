plugins:require 'editor' || return 1
plugins:require 'history' || return 1

source-relative 'external/zsh-history-substring-search.zsh'

# Options {{{
if zstyle -t ':zoppo:plugin:history-substring-search' case-sensitive; then
  unset HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS
fi

if ! zstyle -t ':zoppo:plugin:history-substring-search' color; then
  unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
else
  if ! zstyle -T ':zoppo:plugin:history-substring-search:colors' found; then
    zstyle -s ':zoppo:plugin:history-substring-search:colors' found \
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
  fi

  if ! zstyle -T ':zoppo:plugin:history-substring-search:colors' not-found; then
    zstyle -s ':zoppo:plugin:history-substring-search:colors' not-found \
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND
  fi
fi
# }}}

# Key Bindings {{{
if [[ -n $key_info ]]; then
  editor:emacs:bind "$key_info[Control]P" history-substring-search-up
  editor:emacs:bind "$key_info[Control]N" history-substring-search-down

  # vi
  editor:vi:normal:bind 'k' history-substring-search-up
  editor:vi:normal:bind 'j' history-substring-search-down

  # EMACS and vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done
fi
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
