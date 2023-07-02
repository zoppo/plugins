# NVM {{{
if zdefault -t ':zoppo:plugin:node:nvm' enable 'no'; then
  function {
    typeset -g NVM_DIR
    if [ -z "${NVM_DIR-}" ]; then
      zdefault -s ':zoppo:plugin:node:nvm' path NVM_DIR "$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    fi
    export NVM_DIR

    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    if plugins:load-if-enabled 'completion'; then
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    fi
  }
fi
# }}}

# npm Completion {{{
if zdefault -t ':zoppo:plugin:node:npm' enable 'yes'; then
  function {
    local cache
    zdefault -s ':zoppo:plugin:node:npm' cache cache "$(path:cache)/npm.zsh"

    if is-callable npm; then
      if [[ "$commands[npm]" -nt "$cache" || ! -s "$cache" ]]; then
        npm completion >! "$cache" &> /dev/null
      fi

      source "$cache"
    fi
  }
fi
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
