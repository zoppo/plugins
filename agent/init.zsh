# SSH Agent {{{
if is-callable ssh-agent; then
  function agent:ssh:start {
    local env="$1"
    local -a identities

    if [[ -s "$env" ]]; then
      source "$env" &> /dev/null

      if is-callable pgrep; then
        (( ${$(pgrep -U "$USER" ssh-agent):-0} == SSH_AGENT_PID )) && return 0
      else
        ps -ef | grep -q " $SSH_AGENT_PID .* ssh-agent$" && return 0
      fi
    fi

    # start ssh-agent and setup the environment
    ssh-agent >! "$env"
    chmod 600 "$env"
    source "$env" &> /dev/null

    # load identities
    zstyle -a ':zoppo:plugin:agent:ssh' identities identities

    if (( $#identities > 0 )); then
      ssh-add "$HOME/.ssh/${^identities[@]}"
    else
      ssh-add
    fi

    export SSH_AGENT_PID
    export SSH_AUTH_SOCK
  }

  if zdefault -t ':zoppo:plugin:agent:ssh' enable 'yes'; then
    if zstyle -t ':zoppo:plugin:agent:ssh' forwarding && [[ -n "$SSH_AUTH_SOCK" ]]; then
      # add a nifty symlink for screen/tmux if agent forwarding
      [[ -L "$SSH_AUTH_SOCK" ]] || ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-$USER-screen
    else
      agent:ssh:start "$HOME/.ssh/environment-$HOST"
    fi
  fi
fi
# }}}

# GPG Agent {{{
if is-callable gpg-agent; then
  function agent:gpg:start {
    local env="$1"

    if [[ -s "$env" ]]; then
      source "$env" &> /dev/null

      if is-callable pgrep; then
        (( ${$(pgrep -U "$USER" gpg):-0} == SSH_AGENT_PID )) && return 0
      else
        ps -ef | grep -q " $SSH_AGENT_PID .* gpg-agent$" && return 0
      fi
    fi

    gpg-agent --enable-ssh-support --daemon --write-env-file "$env" &> /dev/null

    chmod 600 "$env"
    source "$env" &> /dev/null

    export GPG_AGENT_INFO
    export GPG_TTY="$(tty)"
  }

  if zdefault -t ':zoppo:plugin:agent:gpg' enable 'no'; then
    agent:gpg:start "$HOME/.gnupg/gpg-agent.env"
  fi
fi
# }}}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
