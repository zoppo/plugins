Autosuggestions
===============
Loads and configures tab completion from [zsh-autosuggestions][1] project.

Completion Options
------------------
Autosuggest strategy

    zstyle -a ':zoppo:plugin:autosuggestions' strategy \
        'history' 'completion'

Hightlight style

    zstyle -s ':zoppo:plugin:autosuggestions' highlight \
        'fg=8'

Autosuggest original widget prefix

    zstyle -s ':zoppo:plugin:autosuggestions:widgets' prefix \
        'autosuggest-orig-'

Autosuggest clear widgets

    zstyle -a ':zoppo:plugin:autosuggestions:widgets' clear \
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

Autosuggest accept widgets

    zstyle -a ':zoppo:plugin:autosuggestions:widgets' accept \
        'forward-char' \
        'end-of-line' \
        'vi-forward-char' \
        'vi-end-of-line' \
        'vi-add-eol'

Autosuggest execute widgets

    zstyle -a ':zoppo:plugin:autosuggestions:widgets' execute

Autosuggest partial accept widgets

    zstyle -a ':zoppo:plugin:autosuggestions:widgets' partial-accept \
        'forward-word' \
        'emacs-forward-word' \
        'vi-forward-word' \
        'vi-forward-word-end' \
        'vi-forward-blank-word' \
        'vi-forward-blank-word-end' \
        'vi-find-next-char' \
        'vi-find-next-char-skip'

Autosuggest ignore widgets

    zstyle -a ':zoppo:plugin:autosuggestions:widgets' ignore \
        'orig-*' \
        'beep' \
        'run-help' \
        'set-local-history' \
        'which-command' \
        'yank' \
        'yank-pop' \
        'zle-*'

Autosuggest completion pty name

    zstyle -s ':zoppo:plugin:autosuggestions' pty-name \
        'zsh_autosuggest_completion_pty'

Autosuggest buffer max size

    zstyle -s ':zoppo:plugin:autosuggestions:buffer' max-size

Autosuggest use async

    zstyle -t ':zoppo:plugin:autosuggestions' async 'yes'

Autosuggest manual rebind

    zstyle -t ':zoppo:plugin:autosuggestions' manual-rebind 'no'

Autosuggest history ignore

    zstyle -s ':zoppo:plugin:autosuggestions:history' ignore

Autosuggest completion ignore

    zstyle -s ':zoppo:plugin:autosuggestions:completion' ignore


[1]: https://github.com/zsh-users/zsh-autosuggestions
