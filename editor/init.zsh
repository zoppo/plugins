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
  'Backspace' '^?'
  'Delete'    '^[[3~'
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
for key ("${(k)key_info[@]}"); do
  if [[ -z "$key_info[$key]" ]]; then
    print 'zoppo: one or more keys are non-bindable' >&2
    unset key{,_info}
    return 1
  fi
done
unset key
# }}}

# allow command line editing in an external editor
editor:load edit-command-line
editor:load self-insert url-quote-magic

# Key Bindings {{{

# reset the bindings to defaults
bindkey -d

for mode ('emacs' 'vi:insert'); do
  editor:${mode}:bind "$key_info[Home]" beginning-of-line
  editor:${mode}:bind "$key_info[End]" end-of-line

  editor:${mode}:bind "$key_info[Insert]" overwrite-mode
  editor:${mode}:bind "$key_info[Delete]" delete-char
  editor:${mode}:bind "$key_info[Backspace]" backward-delete-char

  editor:${mode}:bind "$key_info[Left]" backward-char
  editor:${mode}:bind "$key_info[Right]" forward-char

  # bind <S-Tab> to go to the previous menu item
  editor:${mode}:bind "$key_info[BackTab]" reverse-menu-complete

  if zdefault -t ':zoppo:plugin:editor' dot-expansion 'yes'; then
    editor:${mode}:bind '.' expand-dot-to-parent-directory-realpath
  fi
done
unset mode

# EMACS {{{
for key in "$key_info[Escape]"{B,b}
  editor:emacs:bind "$key" emacs-backward-word
unset key

for key in "$key_info[Escape]"{F,f}
  editor:emacs:bind "$key" emacs-forward-word
unset key

editor:emacs:bind "$key_info[Escape]$key_info[Left]" emacs-backward-word
editor:emacs:bind "$key_info[Escape]$key_info[Right]" emacs-forward-word

# kill to the beginning of the line
for key in "$key_info[Escape]"{K,k}
  editor:emacs:bind "$key" backward-kill-line
unset key

editor:emacs:bind "$key_info[Escape]_" redo

# search previous character
editor:emacs:bind "$key_info[Control]X$key_info[Control]B" vi-find-prev-char

# match bracket
editor:emacs:bind "$key_info[Control]X$key_info[Control]]" vi-match-bracket

# edit command in an external editor
editor:emacs:bind "$key_info[Control]X$key_info[Control]E" edit-command-line

if editor:is-loaded history-incremental-pattern-search-backward; then
  editor:emacs:bind "$key_info[Control]R" history-incremental-pattern-search-backward
  editor:emacs:bind "$key_info[Control]S" history-incremental-pattern-search-forward
else
  editor:emacs:bind "$key_info[Control]R" history-incremental-search-backward
  editor:emacs:bind "$key_info[Control]S" history-incremental-search-forward
fi
# }}}

# vi {{{

# edit command in an external editor.
editor:vi:normal:bind 'v' edit-command-line

# undo/redo
editor:vi:normal:bind 'u' undo
editor:vi:normal:bind "$key_info[Control]R" redo

# switch to command mode
editor:vi:insert:bind 'jk' vi-cmd-mode
editor:vi:insert:bind 'kj' vi-cmd-mode

if editor:is-loaded history-incremental-pattern-search-backward; then
  editor:vi:normal:bind '?' history-incremental-pattern-search-backward
  editor:vi:normal:bind '/' history-incremental-pattern-search-forward
else
  editor:vi:normal:bind '?' history-incremental-search-backward
  editor:vi:normal:bind '/' history-incremental-search-forward
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
  vi|vim) bindkey -v ;;
esac
unset mode
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
