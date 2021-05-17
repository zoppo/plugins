source-relative 'external/zsh-autosuggestions.zsh'

typeset -ga ZSH_AUTOSUGGEST_STRATEGY
zdefault -a ':zoppo:plugin:autosuggestions' strategy ZSH_AUTOSUGGEST_STRATEGY \
  'history' 'completion'

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
zdefault -s ':zoppo:plugin:autosuggestions' highlight ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE \
  'fg=8'

typeset -g ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX
zdefault -s ':zoppo:plugin:autosuggestions:widgets' prefix ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX \
  'autosuggest-orig-'

typeset -ga ZSH_AUTOSUGGEST_CLEAR_WIDGETS
zdefault -a ':zoppo:plugin:autosuggestions:widgets' clear ZSH_AUTOSUGGEST_CLEAR_WIDGETS \
  'history-search-forward' \
  'history-search-backward' \
  'history-beginning-search-forward' \
  'history-beginning-search-backward' \
  'history-substring-search-up' \
  'history-substring-search-down' \
  'up-line-or-beginning-search' \
  'down-line-or-beginning-search' \
  'up-line-or-history' \
  'down-line-or-history' \
  'accept-line' \
  'copy-earlier-word'

typeset -ga ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
zdefault -a ':zoppo:plugin:autosuggestions:widgets' accept ZSH_AUTOSUGGEST_ACCEPT_WIDGETS \
  'forward-char' \
  'end-of-line' \
  'vi-forward-char' \
  'vi-end-of-line' \
  'vi-add-eol'

typeset -ga ZSH_AUTOSUGGEST_EXECUTE_WIDGETS
zdefault -a ':zoppo:plugin:autosuggestions:widgets' execute ZSH_AUTOSUGGEST_EXECUTE_WIDGETS

typeset -ga ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
zdefault -a ':zoppo:plugin:autosuggestions:widgets' partial-accept ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS \
  'forward-word' \
  'emacs-forward-word' \
  'vi-forward-word' \
  'vi-forward-word-end' \
  'vi-forward-blank-word' \
  'vi-forward-blank-word-end' \
  'vi-find-next-char' \
  'vi-find-next-char-skip'

typeset -ga ZSH_AUTOSUGGEST_IGNORE_WIDGETS
zdefault -a ':zoppo:plugin:autosuggestions:widgets' ignore ZSH_AUTOSUGGEST_IGNORE_WIDGETS \
  'orig-*' \
  'beep' \
  'run-help' \
  'set-local-history' \
  'which-command' \
  'yank' \
  'yank-pop' \
  'zle-*'

typeset -g ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME
zdefault -s ':zoppo:plugin:autosuggestions' pty-name ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME \
  'zsh_autosuggest_completion_pty'

typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE
if zstyle -t ':zoppo:plugin:autosuggestions:buffer' max-size; then
  zstyle -s ':zoppo:plugin:autosuggestions:buffer' max-size ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE
fi

typeset -g ZSH_AUTOSUGGEST_USE_ASYNC
if zdefault -t ':zoppo:plugin:autosuggestions' async 'yes'; then
  ZSH_AUTOSUGGEST_USE_ASYNC=true
fi

typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND
if zdefault -t ':zoppo:plugin:autosuggestions' manual-rebind 'no'; then
  ZSH_AUTOSUGGEST_MANUAL_REBIND=true
fi

typeset -g ZSH_AUTOSUGGEST_HISTORY_IGNORE
zstyle -s ':zoppo:plugin:autosuggestions:history' ignore ZSH_AUTOSUGGEST_HISTORY_IGNORE

typeset -g ZSH_AUTOSUGGEST_COMPLETION_IGNORE
zstyle -s ':zoppo:plugin:autosuggestions:completion' ignore ZSH_AUTOSUGGEST_COMPLETION_IGNORE

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
