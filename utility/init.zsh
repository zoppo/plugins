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

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  alias ls="${aliases[ls]:-ls} -F"
fi

if zstyle -t ':zoppo:plugin:utility:grep' color; then
  export GREP_OPTIONS="$GREP_OPTIONS --color=auto"

  zstyle -s ':zoppo:plugin:utility:grep' highlight-color GREP_COLOR
  zstyle -s ':zoppo:plugin:utility:grep' colors GREP_COLORS

  export GREP_COLOR GREP_COLORS
fi

alias md='mkdir'

function mcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

alias mkdcd='mcd'

function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
