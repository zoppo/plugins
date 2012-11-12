if [[ ! -S '/tmp/.X11-unix/X0' ]]; then
  return
fi

: ${DISPLAY:=:0.0}
: ${XAUTHORITY:=$HOME/.Xauthority}

if [[ ! -e "$(path:cache)/X" ]] || \
   [[ "${ZDOTDIR:-$HOME}/.zopporc" -nt "$(path:cache)/X" ]] || \
   [[ '/tmp/.X11-unix/X0'          -nt "$(path:cache)/X" ]] \
then
  touch "$(path:cache)/X"
else
  return
fi

if zstyle -t ':zoppo:plugin:X:screen' saver; then
  xscreensaver &> /dev/null &!
elif zstyle -s ':zoppo:plugin:X:screen' saver saver; then
  case "$saver" in
    *) ;;
  esac

  unset saver
fi

if zstyle -s ':zoppo:plugin:X:screen:redshift' location location; then
  redshift -l "$longitude" &> /dev/null &!
fi

if zstyle -s ':zoppo:plugin:X:keyboard' language language; then
  setxkbmap "$language"
  unset language
fi

if zstyle -s ':zoppo:plugin:X:keyboard' input input; then
  case "$input" in
    ibus) ibus-daemon --xim &> /dev/null &! ;;
  esac

  unset input
fi

if zstyle -t ':zoppo:plugin:X:keyboard' auto-repeat 'no'; then
  xset r off
elif zstyle -s ':zoppo:plugin:X:keyboard' auto-repeat rate; then
  xset r rate ${=rate}
  unset rate
fi

if [[ -r "$HOME/.Xmodmap" ]]; then
  xmodmap "$HOME/.Xmodmap"
fi

zstyle -s ':zoppo:plugin:X:mouse' acceleration acceleration
zstyle -s ':zoppo:plugin:X:mouse' threshold threshold
  if [[ -n "$acceleration" || -n "$threshold" ]]; then
    xset m "${acceleration:-0}" "$threshold"
  fi
unset acceleration threshold

if zstyle -s ':zoppo:plugin:X:mouse' unclutter idle; then
  if [[ "$idle" == <-> ]]; then
    unclutter -root -visibile -idle $idle &> /dev/null &!
  else
    unclutter -root -visible &> /dev/null &!
  fi

  unset idle
fi

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
