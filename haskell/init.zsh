# Path Settings {{{
function {
  typeset -gU path manpath

  setopt LOCAL_OPTIONS EXTENDED_GLOB

  # prepend Cabal per user directories to PATH/MANPATH
  if [[ "$OSTYPE" == darwin* ]]; then
    path=($HOME/Library/Haskell/bin(/N) $path)
    manpath=($HOME/Library/Haskell/man(/N) $manpath)
  else
    path=($HOME/.cabal/bin(/N) $path)
    manpath=($HOME/.cabal/man(/N) $manpath)
  fi
}
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
