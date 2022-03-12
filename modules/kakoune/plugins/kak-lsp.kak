# kak-lsp
# ─────────────────────────
eval %sh{kak-lsp --kakoune --session $kak_session}
set global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp|haskell|bash) %{
  map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
  lsp-enable-window
  lsp-auto-hover-enable
  lsp-auto-hover-insert-mode-disable
  set-option window lsp_hover_anchor true

}

