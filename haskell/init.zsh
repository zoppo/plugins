# ghcup Support {{{
if zdefault -t ':zoppo:plugin:haskell:ghcup' enable 'no'; then
  function {
    typeset -gU path
    typeset -g GHCUP_USE_XDG_DIRS GHCUP_INSTALL_BASE_PREFIX

    setopt LOCAL_OPTIONS EXTENDED_GLOB BARE_GLOB_QUAL

    if zdefault -t ':zoppo:plugin:haskell:ghcup' xdg 'yes'; then
      GHCUP_USE_XDG_DIRS=true
      export GHCUP_USE_XDG_DIRS
      unset GHCUP_INSTALL_BASE_PREFIX

      path=("${XDG_BIN_HOME:-"${HOME}/.local/bin"}"(/N) $path)
    else
      unset GHCUP_USE_XDG_DIRS

      GHCUP_INSTALL_BASE_PREFIX="${GHCUP_INSTALL_BASE_PREFIX:-"${HOME}"}"
      zdefault -s ':zoppo:plugin:haskell:ghcup' home \
        GHCUP_INSTALL_BASE_PREFIX "${GHCUP_INSTALL_BASE_PREFIX}"
      export GHCUP_INSTALL_BASE_PREFIX

      path=("${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/bin"(/N) $path)
    fi

  }
fi
# }}}

# Path Settings {{{
function {
  typeset -gU path manpath

  setopt LOCAL_OPTIONS EXTENDED_GLOB BARE_GLOB_QUAL

  if [[ -d "$HOME/.cabal" ]]; then
    path=($HOME/.cabal/bin(/N) $path)
    manpath=($HOME/.cabal/man(/N) $manpath)
  elif [[ -d "$HOME/Library/Haskell" ]]; then
    path=($HOME/Library/Haskell/bin(/N) $path)
    manpath=($HOME/Library/Haskell/man(/N) $manpath)
  fi
}
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
