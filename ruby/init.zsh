# RVM {{{
function {
  local script
  zdefault -s ':zoppo:plugin:ruby:rvm' path script "$HOME/.rvm/scripts/rvm"

  # warn if auto-name-dirs is enabled and disable it
  if options:is-enabled 'auto-name-dirs'; then
    warn 'zoppo: RVM does not work with auto-name-dirs enabled, disabling' 1>&2

    options:disable 'auto-name-dirs'
  fi

  source "$script"
}
# }}}

# rbenv {{{
function {
  local binary
  zdefault -s ':zoppo:plugin:ruby:rbenv' path binary "$HOME/.rbenv/bin/rbenv"

  if ! is-callable rbenv; then
    path=("$(dirname "$binary")" $path)
  fi

  if is-callable rbenv; then
    eval "$(rbenv init - zsh)"
  fi
}
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
