zdefault -s ':zoppo:plugin:rvm' path zoppo_rvm_path "${HOME}/.rvm/scripts/rvm"

[[ -s "$zoppo_rvm_path" ]] && source "$zoppo_rvm_path"

unset zoppo_rvm_path

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
