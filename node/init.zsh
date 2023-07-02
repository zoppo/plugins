# NVM {{{
if zdefault -t ':zoppo:plugin:node:nvm' enable 'no'; then
  function {
    typeset -g NVM_DIR
    if [ -z "${NVM_DIR-}" ]; then
      zdefault -s ':zoppo:plugin:node:nvm' path NVM_DIR "$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    fi
    export NVM_DIR

    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    local prefix="$(npm config get prefix)"

    if [ "$(nvm current)" = system ] && is-command npm; then
      typeset -gU path
      path=("$prefix"/bin(/N) $path)
    fi

    typeset -g NODE_PATH
    NODE_PATH="${prefix}/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
    export NODE_PATH

    eval "nvm() {
${functions[nvm]}
typeset -g NODE_PATH
NODE_PATH=\"\$(nvm_strip_path \"\${NODE_PATH}\" /lib/node_modules)\"
hash -r
if is-command npm; then
  NODE_PATH=\"\$(npm config get prefix)/lib/node_modules\${NODE_PATH:+:\$NODE_PATH}\"
fi
export NODE_PATH
}"

    if plugins:load-if-enabled 'completion'; then
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    fi
  }
elif zdefault -t ':zoppo:plugin:node:npm' enable 'yes'; then
  function {
    local prefix="$(npm config get prefix)"

    if is-command npm; then
      typeset -gU path
      path=("$prefix"/bin(/N) $path)
    fi

    typeset -g NODE_PATH
    NODE_PATH="${prefix}/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
    export NODE_PATH
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
