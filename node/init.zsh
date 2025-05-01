# NVM {{{
if zdefault -t ':zoppo:plugin:node:nvm' enable 'no'; then
  function {
    typeset -g NVM_DIR
    if [ -z "${NVM_DIR-}" ]; then
      NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    fi
    if [ -z "${NVM_DIR-}" ]; then
      zdefault -s ':zoppo:plugin:node:nvm' path NVM_DIR "${NVM_DIR}"
    fi
    export NVM_DIR

    if [ -s "$NVM_DIR/nvm.sh" ]; then 
      . "$NVM_DIR/nvm.sh"

      if zdefault -t ':zoppo:plugin:node:modules' enable 'yes' && is-command npm; then
        if [ "$(nvm current)" = system ]; then
          typeset -gU path
          path=("$prefix"/bin(/N) $path)
        fi

        typeset -g NODE_PATH
        NODE_PATH="$(cd ~ && command npm config get prefix)/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
        export NODE_PATH

        eval "nvm() {
  ${functions[nvm]}
  typeset -g NODE_PATH
  NODE_PATH=\"\$(nvm_strip_path \"\${NODE_PATH}\" /lib/node_modules)\"
  hash -r
  if is-command npm; then
    NODE_PATH=\"\$(functions[nvm:loadrc]=''; cd ~ && command npm config get prefix)/lib/node_modules\${NODE_PATH:+:\$NODE_PATH}\"
  fi
  export NODE_PATH
  }"
      fi
    elif zdefault -t ':zoppo:plugin:node:modules' enable 'yes' && is-command npm; then
      typeset -gU path
      path=("$prefix"/bin(/N) $path)

      typeset -g NODE_PATH
      NODE_PATH="$(cd ~ && command npm config get prefix)/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
      export NODE_PATH
    fi

    if plugins:load-if-enabled 'completion'; then
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    fi
  }

  autoload -U add-zsh-hook
  function nvm:loadrc {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd nvm:loadrc
  nvm:loadrc
elif zdefault -t ':zoppo:plugin:node:modules' enable 'yes' && is-command npm; then
  function {
    typeset -gU path
    path=("$prefix"/bin(/N) $path)

    typeset -g NODE_PATH
    NODE_PATH="$(cd ~ && command npm config get prefix)/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
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

if zdefault -t ':zoppo:plugin:node:modules' enable 'yes'; then
  function {
    typeset -g NPM_PACKAGES
    zdefault -s ':zoppo:plugin:node:modules' path NPM_PACKAGES "${HOME}/.node_modules"
    export NPM_PACKAGES

    if ! [ -d "${NPM_PACKAGES}/bin" ]; then
      mkdir -p "${NPM_PACKAGES}/bin"
    fi

    typeset -gU path
    path=("${NPM_PACKAGES}"/bin(/N) $path)

    typeset -g NODE_PATH
    NODE_PATH="${NPM_PACKAGES}/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
    export NODE_PATH
  }
fi

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
