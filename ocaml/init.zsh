if zdefault -t ':zoppo:plugin:ocaml:opam' enable 'yes'; then
  function {
    typeset -g OPAMROOT
    if [ -z "${OPAMROOT-}" ]; then
      zdefault -s ':zoppo:plugin:ocaml:opam' root OPAMROOT "${HOME}/.opam"
    fi
    export OPAMROOT


    if is-command opam; then
      local switch
      zdefault -s ':zoppo:plugin:ocaml:opam' switch switch 'default'

      eval "$(command opam env --switch="${switch}")"
    fi
  }
fi

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
