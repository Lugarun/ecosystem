# set-option global tagbar_sort false
# set-option global tagbar_size 40
# set-option global tagbar_display_anon false
hook global WinSetOption filetype=tagbar %{
  remove-highlighter window/wrap
  # you can also disable rendering whitespaces here, line numbers, and
  # matching characters
}

hook global WinSetOption filetype=(c|cpp|rust|sh|python|haskell|markdown|latex) %{
    tagbar-enable
}
