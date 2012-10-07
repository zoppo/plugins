if terminal:is-dumb; then
  return 1
fi

# Key Info {{{
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'   '\C-'
  'Escape'    '\e'
  'Meta'      '\M-'
  'Backspace' "^?"
  'Delete'    "^[[3~"
  'F1'        "$terminfo[kf1]"
  'F2'        "$terminfo[kf2]"
  'F3'        "$terminfo[kf3]"
  'F4'        "$terminfo[kf4]"
  'F5'        "$terminfo[kf5]"
  'F6'        "$terminfo[kf6]"
  'F7'        "$terminfo[kf7]"
  'F8'        "$terminfo[kf8]"
  'F9'        "$terminfo[kf9]"
  'F10'       "$terminfo[kf10]"
  'F11'       "$terminfo[kf11]"
  'F12'       "$terminfo[kf12]"
  'Insert'    "$terminfo[kich1]"
  'Home'      "$terminfo[khome]"
  'PageUp'    "$terminfo[kpp]"
  'End'       "$terminfo[kend]"
  'PageDown'  "$terminfo[knp]"
  'Up'        "$terminfo[kcuu1]"
  'Left'      "$terminfo[kcub1]"
  'Down'      "$terminfo[kcud1]"
  'Right'     "$terminfo[kcuf1]"
  'BackTab'   "$terminfo[kcbt]"
)

# do not bind any keys if there are empty values in $key_info
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    print 'zoppo: one or more keys are non-bindable' >&2
    unset key{,_info}
    return 1
  fi
done
unset key
# }}}

# allow command line editing in an external editor
editor:load 'edit-command-line'

zle -N expand-dot-to-parent-directory-realpath
zdefault ':zoppo:plugin:editor' dot-expansion 'yes'

# Key Bindings {{{
bindkey -d

for mode in 'emacs' 'viins'; do
  bindkey -M "$mode" "$key_info[Home]" beginning-of-line
  bindkey -M "$mode" "$key_info[End]" end-of-line

  bindkey -M "$mode" "$key_info[Insert]" overwrite-mode
  bindkey -M "$mode" "$key_info[Delete]" delete-char
  bindkey -M "$mode" "$key_info[Backspace]" backward-delete-char

  bindkey -M "$mode" "$key_info[Left]" backward-char
  bindkey -M "$mode" "$key_info[Right]" forward-char

  # bind <S-Tab> to go to the previous menu item
  bindkey -M "$mode" "$key_info[BackTab]" reverse-menu-complete

  if zstyle -t ':zoppo:plugin:editor' dot-expansion; then
    bindkey -M "$mode" '.' expand-dot-to-parent-directory-realpath
  fi
done
unset mode

# EMACS {{{
for key in "$key_info[Escape]"{B,b}
  bindkey -M emacs "$key" emacs-backward-word

for key in "$key_info[Escape]"{F,f}
  bindkey -M emacs "$key" emacs-forward-word

bindkey -M emacs "$key_info[Escape]$key_info[Left]" emacs-backward-word
bindkey -M emacs "$key_info[Escape]$key_info[Right]" emacs-forward-word

# kill to the beginning of the line
for key in "$key_info[Escape]"{K,k}
  bindkey -M emacs "$key" backward-kill-line

bindkey -M emacs "$key_info[Escape]_" redo

# search previous character
bindkey -M emacs "$key_info[Control]X$key_info[Control]B" vi-find-prev-char

# match bracket
bindkey -M emacs "$key_info[Control]X$key_info[Control]]" vi-match-bracket

# edit command in an external editor
bindkey -M emacs "$key_info[Control]X$key_info[Control]E" edit-command-line

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M emacs "$key_info[Control]R" \
    history-incremental-pattern-search-backward
  bindkey -M emacs "$key_info[Control]S" \
    history-incremental-pattern-search-forward
fi
# }}}

# vi {{{

# edit command in an external editor.
bindkey -M vicmd "v" edit-command-line

# undo/redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "$key_info[Control]R" redo

# switch to command mode
bindkey -M viins "jk" vi-cmd-mode
bindkey -M viins "kj" vi-cmd-mode

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M vicmd "?" history-incremental-pattern-search-backward
  bindkey -M vicmd "/" history-incremental-pattern-search-forward
else
  bindkey -M vicmd "?" history-incremental-search-backward
  bindkey -M vicmd "/" history-incremental-search-forward
fi
# }}}

# }}}

# Beep Setting {{{
if zstyle -t ':zoppo:plugin:editor' beep; then
  setopt BEEP
else
  unsetopt BEEP
fi
# }}}

# Editor Mode {{{
zdefault -s ':zoppo:plugin:editor' mode mode 'emacs'
case "$mode" in
  emacs) bindkey -e ;;
  vi|vim|viins) bindkey -v ;;
esac
unset mode
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
