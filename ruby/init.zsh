zdefault -s ':zoppo:plugin:ruby:rvm' path z_rvm_path "$HOME/.rvm/scripts/rvm"
zdefault -s ':zoppo:plugin:ruby:rbenv' path z_rbenv_path "$HOME/.rbenv/bin/rbenv"

if [[ -s "$z_rvm_path" ]]; then # if RVM exists, load it
  # warn if auto-name-dirs is enabled and disable it
  if options:is-enabled 'auto-name-dirs'; then
    print 'zoppo: RVM does not work with auto-name-dirs enabled, disabling' 1>&2

    options:disable 'auto-name-dirs'
  fi

  source $z_rvm_path
elif [[ -s "$z_rbenv_path" ]]; then # if there's a local rbenv
  path=("$(dirname "$z_rbenv_path")" $path)

  eval "$(rbenv init - zsh)"
elif (( $+commands[rbenv] )); then # if there's a system rbenv
  eval "$(rbenv init - zsh)"
fi

unset z_{rvm,rbenv}_path

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
