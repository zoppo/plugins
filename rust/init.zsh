if zdefault -t ':zoppo:plugin:rust:cargo' enable 'yes'; then
  function {
    typeset -g CARGO_HOME
    if [ -z "${CARGO_HOME-}" ]; then
      zdefault -s ':zoppo:plugin:rust:cargo' home CARGO_HOME "${HOME}/.cargo"
    fi
    export CARGO_HOME

    typeset -gU path
    path=("$CARGO_HOME"/bin(/N) $path)

    if [ -f "${CARGO_HOME}/env" ]; then
      source "${CARGO_HOME}/env"
    fi
  }
fi

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
