# Kakoune.cr
# ─────────────────────────
evaluate-commands %sh{
  kcr init kakoune
}

define-command -override fzf-files %{
  connect tmux-terminal-vertical bash -c %{
    fzf --preview 'bat {}' | xargs kcr edit --
  }
}

define-command -override fzf-buffers %{
  connect tmux-terminal-vertical bash -c %{
    kcr get --raw --value buflist | fzf --preview 'kcr cat --raw {}' | xargs kcr send buffer --
  }
}

define-command -override fzf-grep %{
  connect tmux-terminal-vertical bash -c %{
    kcr fzf grep
  }
}

define-command -override fzf-remote %{
  connect tmux-terminal-vertical bash -c %{
    fzf_remote | xargs kcr edit --
  }
}

define-command -override fzf-git-history %{
  connect tmux-terminal-vertical bash -c %{
    fzf_git_history | cut -d: -f-2 | xargs git show | kcr edit -
  }
}
