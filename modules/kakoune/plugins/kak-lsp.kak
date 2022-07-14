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

hook global WinSetOption filetype=python %{
    set-option window lintcmd %{
      run() {
        poetry run pylint --msg-template='{path}:{line}:{column}: {category}: {msg_id}: {msg} ({symbol})' "$1" | awk -F: 'BEGIN { OFS=":" } { if (NF == 6) { $3 += 1; print } }'; } && parallel "run; poetry run flake8 --filename='*' --format='%%(path)s:%%(row)d:%%(col)d: error: %%(text)s' --ignore=E121,E123,E126,E226,E24,E704,W503,W504,E501,E221,E127,E128,E129,F405; poetry run mypy --show-column-numbers" :::
        }
}
