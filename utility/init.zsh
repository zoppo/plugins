options:enable 'correct'

# ZSH utilities {{{
if zdefault -t ':zoppo:plugin:utility:zsh' enable 'yes'; then
  functions:autoload ztodo
  functions:autoload zed
  functions:autoload zcalc

  functions:autoload zmv
  alias zcp='zmv -C'
  alias zln='zmv -L'

  functions:autoload zargs
fi
# }}}

# GNU utilities {{{
if zstyle -t ':zoppo:plugin:utility:gnu' enable; then
  function {
    local prefix
    local -a binaries
    local cmd

    zdefault -s ':zoppo:plugin:utility:gnu' prefix prefix 'g'
    zdefault -a ':zoppo:plugin:utility:gnu' binaries binaries \
      '[' 'base64' 'basename' 'cat' 'chcon' 'chgrp' 'chmod' 'chown' \
      'chroot' 'cksum' 'comm' 'cp' 'csplit' 'cut' 'date' 'dd' 'df' \
      'dir' 'dircolors' 'dirname' 'du' 'echo' 'env' 'expand' 'expr' \
      'factor' 'false' 'fmt' 'fold' 'groups' 'head' 'hostid' 'id' \
      'install' 'join' 'kill' 'link' 'ln' 'logname' 'ls' 'md5sum' \
      'mkdir' 'mkfifo' 'mknod' 'mktemp' 'mv' 'nice' 'nl' 'nohup' 'nproc' \
      'od' 'paste' 'pathchk' 'pinee' 'pr' 'printenv' 'printf' 'ptx' \
      'pwd' 'readlink' 'realpath' 'rm' 'rmdir' 'runcon' 'seq' 'sha1sum' \
      'sha224sum' 'sha256sum' 'sha384sum' 'sha512sum' 'shred' 'shuf' \
      'sleep' 'sort' 'split' 'stat' 'stty' 'sum' 'sync' 'tac' 'tail' \
      'tee' 'test' 'timeout' 'touch' 'tr' 'true' 'truncate' 'tsort' \
      'tty' 'uname' 'unexpand' 'uniq' 'unlink' 'uptime' 'users' 'vdir' \
      'wc' 'who' 'whoami' 'yes' \
      \
      'addr2line' 'ar' 'c++filt' 'elfedit' 'nm' 'objcopy' 'objdump' \
      'ranlib' 'readelf' 'size' 'strings' 'strip' \
      \
      'find' 'locate' 'oldfind' 'updatedb' 'xargs' \
      \
      'libtool' 'libtoolize' \
      \
      'getopt' 'grep' 'indent' 'sed' 'tar' 'time' 'units' 'which'

    for cmd in "$binaries[@]"; do
      is-callable "$prefix$cmd" && continue
      is-callable "$cmd" || continue

      eval "function $cmd {
        $prefix$cmd \"$@\"
      }"
    done
  }
fi
# }}}

# ls {{{
if zstyle -t ':zoppo:plugin:utility:ls' color; then
  if ! zstyle -T ':zoppo:plugin:utility:ls' colors; then
    zstyle -s ':zoppo:plugin:utility:ls' colors LS_COLORS

    export LS_COLORS
  elif is-callable 'dircolors'; then
    if [[ -s "$HOME/.dircolors" ]]; then
      eval "$(dircolors "$HOME/.dircolors")"
    else
      eval "$(dircolors)"
    fi
  fi

  if utility:is-gnu; then
    alias+ ls '--color=auto'
  else
    alias+ ls '-G'
  fi
else
  alias+ ls '-F'
fi
# }}}

# grep {{{
if zstyle -t ':zoppo:plugin:utility:grep' color; then
  export GREP_OPTIONS="$GREP_OPTIONS --color=auto"

  zstyle -s ':zoppo:plugin:utility:grep' highlight-color GREP_COLOR
  zstyle -s ':zoppo:plugin:utility:grep' colors GREP_COLORS

  export GREP_COLOR GREP_COLORS
fi
# }}}

# Disable Correction {{{
function {
  local programs
  local program

  zdefault -a ':zoppo:plugin:utility' no-correct programs \
    'ack' 'cd' 'cp' 'ebuild' 'gcc' 'gist' 'grep' 'heroku' 'ln' 'man' 'mkdir' 'mv' 'mysql' 'rm'

  for program ("$programs[@]")
    alias "$program"="nocorrect $program"
}
# }}}

# Disable Globbing {{{
function {
  local programs
  local program

  zdefault -a ':zoppo:plugin:utility' no-glob programs \
    'fc' 'find' 'ftp' 'history' 'locate' 'rake' 'rsync' 'scp' 'sftp'

  for program ("$programs[@]")
    alias "$program"="noglob $program"
}
# }}}

# Enable Interactive {{{
function {
  local programs
  local program

  zdefault -a ':zoppo:plugin:utility' interactive programs \
    'cp' 'ln' 'mv' 'rm'

  for program ("$programs[@]")
    alias+ "$program" '-i'
}

# }}}

# Directory Stuff {{{
alias+ mkdir '-p'
alias md='mkdir'

function mcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

alias mkdcd='mcd'

function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}
# }}}

# Mac OS X Everywhere {{{
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
else
  alias o='xdg-open'
  alias get='wget --continue --progress=bar --timestamping'

  if is-callable xclip; then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif is-callable xsel; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

alias copy='pbc'
alias paste='pbp'
# }}}

# sprunge.us {{{
if is-callable curl && is-callable cat; then
  alias sprunge="curl -F'sprunge=<-' sprunge.us"

  function sprunger {
    (( $+1 )) || {
      print "USAGE: ${0:t} <file>" >&2
      return 1
    }

    print "${${${:-"$(cat "$1" | sprunge)"}%%*( )}##*( )}"
  }
fi
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
