# Kakoune.cr
# ─────────────────────────
evaluate-commands %sh{
  kcr init kakoune
}

define-command -override fzf-files %{
  connect terminal bash -c %{
    fd --type f --strip-cwd-prefix --color=always --follow --hidden --exclude .git | fzf --ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}' | xargs kcr edit --
  }
}

define-command -override fzf-files-git %{
  connect terminal bash -c %{
    fd --type f --strip-cwd-prefix --color=always --follow | fzf --ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}' | xargs kcr edit --
  }
}

define-command -override fzf-buffers %{
  connect terminal bash -c %{
    kcr get --raw --value buflist | fzf --preview 'kcr cat --raw {}' | xargs kcr send buffer --
  }
}

define-command -override fzf-grep %{
  connect terminal bash -c %{
    kcr fzf grep
  }
}

define-command -override fzf-remote %{
  connect terminal bash -c %{
    fzf_remote | xargs kcr edit --
  }
}

define-command -override fzf-git-history %{
  connect terminal bash -c %{
    fzf_git_history | cut -d: -f-2 | xargs git show | kcr edit -
  }
}
