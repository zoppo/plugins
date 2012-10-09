zdefault -s ':zoppo:plugin:python:pythonz' path z_pythonz_path "$HOME/.pythonz/bin/pythonz"
zdefault -s ':zoppo:plugin:python:virtualenv' path z_virtualenv_path "$HOME/.virtualenvs"

# prepend PEP 370 per user site packages directory, which defaults to
# ~/Library/Python on Mac OS X and ~/.local elsewhere, to PATH/MANPATH
if [[ "$OSTYPE" == darwin* ]]; then
  path=($HOME/Library/Python/*/bin(N) $path)
  manpath=($HOME/Library/Python/*/{,share/}man(N) $manpath)
else
  path=($HOME/.local/bin $path)
  manpath=($HOME/.local/{,share/}man(N) $manpath)
fi

if [[ -s $z_pythonz_path ]]; then
  path=("$z_pythonz_path" $path)
fi

if (( $+commands[virtualenvwrapper_lazy.sh] )); then
  export WORKON_HOME="$z_virtualenv_path"
  export VIRTUAL_ENV_DISABLE_PROMPT=1

  source "$commands[virtualenvwrapper_lazy.sh]"
fi

unset z_{pythonz,virtualenv}_path

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
