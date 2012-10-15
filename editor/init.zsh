if terminal:is-dumb; then
  return 1
fi

# set wordchars
zdefault -s ':zoppo:plugin:editor' wordchars WORDCHARS '*?_-.[]~&;!#$%^(){}<>'

editor:keys:load
editor:load edit-command-line
editor:load self-insert url-quote-magic

# Key Bindings {{{
bindkey -d # reset the bindings to defaults

for mode ('emacs' 'vi:insert'); do
  editor:${mode}:bind 'Insert' overwrite-mode
  editor:${mode}:bind 'Delete' delete-char
  editor:${mode}:bind 'Backspace' backward-delete-char

  if zdefault -t ':zoppo:plugin:editor' dot-expansion 'yes'; then
    editor:${mode}:bind '.' expand-dot-to-parent-directory-realpath
  fi
done
unset mode

for mode ('emacs' 'vi:insert' 'vi:normal'); do
  editor:${mode}:bind 'Home' beginning-of-line
  editor:${mode}:bind 'End' end-of-line

  editor:${mode}:bind 'Left' backward-char
  editor:${mode}:bind 'Right' forward-char

  editor:${mode}:bind 'Up' up-line-or-history
  editor:${mode}:bind 'Down' down-line-or-history

  editor:${mode}:bind 'PageUp' up-line-or-history
  editor:${mode}:bind 'PageDown' down-line-or-history

  # bind <S-Tab> to go to the previous menu item
  editor:${mode}:bind 'BackTab' reverse-menu-complete
done
unset mode

# Dumb Terminals {{{
for mode ('emacs' 'vi:insert' 'vi:normal'); do
  editor:${mode}:bind "^[[H" beginning-of-line
  editor:${mode}:bind "^[[1~" beginning-of-line
  editor:${mode}:bind "^[OH" beginning-of-line

  editor:${mode}:bind "^[[F"  end-of-line
  editor:${mode}:bind "^[[4~" end-of-line
  editor:${mode}:bind "^[OF" end-of-line

  editor:${mode}:bind '^?' backward-delete-char
  editor:${mode}:bind "^[[3~" delete-char
  editor:${mode}:bind "^[3;5~" delete-char
  editor:${mode}:bind "\e[3~" delete-char
done
# }}}

# EMACS {{{
for key in 'Escape+'{B,b}
  editor:emacs:bind "$key" emacs-backward-word
unset key

for key in 'Escape+'{F,f}
  editor:emacs:bind "$key" emacs-forward-word
unset key

editor:emacs:bind Escape+Left emacs-backward-word
editor:emacs:bind Escape+Right emacs-forward-word

# kill to the beginning of the line
for key in 'Escape+'{K,k}
  editor:emacs:bind "$key" backward-kill-line
unset key

editor:emacs:bind 'Escape+_' redo

# search previous character
editor:emacs:bind 'Control+X Control+B' vi-find-prev-char

# match bracket
editor:emacs:bind 'Control+X Control+]' vi-match-bracket

# edit command in an external editor
editor:emacs:bind 'Control+X Control+E' edit-command-line

if editor:is-loaded history-incremental-pattern-search-backward; then
  editor:emacs:bind 'Control+R' history-incremental-pattern-search-backward
  editor:emacs:bind 'Control+S' history-incremental-pattern-search-forward
else
  editor:emacs:bind 'Control+R' history-incremental-search-backward
  editor:emacs:bind 'Control+S' history-incremental-search-forward
fi
# }}}

# vi {{{

# edit command in an external editor.
editor:vi:normal:bind 'v' edit-command-line

# undo/redo
editor:vi:normal:bind 'u' undo
editor:vi:normal:bind 'Control+R' redo

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
