##
## git.kak by lenormf
#
##

# http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Faces that highlight text that overflows the following limits:
#   - title: 50 characters
#   - body: 72 characters
set-face global GitOverflowTitle yellow
set-face global GitOverflowBody yellow

hook -group git-commit-highlight global WinSetOption filetype=git-(commit|rebase) %{
    add-highlighter window/git-commit-highlight/ regex "^\h*[^#\s][^\n]{71}([^\n]+)" 1:GitOverflowBody
    add-highlighter window/git-commit-highlight/ regex "\A[\s\n]*[^#\s][^\n]{49}([^\n]+)" 1:GitOverflowTitle
}

# create an if for conditional parsing
# ─────────────────────────
define-command -docstring "if <condition> <expression> [else [if <condition>] <expression>]: if statement that accepts shell-valid condition string" \
if -params 2.. %{ evaluate-commands %sh{
    while [ true ]; do
        condition="[ $1 ]"
        if [ -n "$3" ] && [ "$3" != "else" ]; then
            printf "%s\n" "fail %{if: unknown operator '$3'}"
        elif [ $# -eq 3 ]; then
            printf "%s\n" "fail %{if: wrong argument count}"
        elif eval $condition; then
            [ -n "${2##*&*}" ] && arg="$2" || arg="$(printf '%s' "$2" | sed 's/&/&&/g')"
            printf "%s\n" "evaluate-commands %& $arg &"
        elif [ $# -eq 4 ]; then
            [ -n "${4##*&*}" ] && arg="$4" || arg="$(printf '%s' "$4" | sed 's/&/&&/g')"
            printf "%s\n" "evaluate-commands %& $arg &"
        elif [ $# -gt 4 ]; then
            if [ "$4" = "if" ]; then
                shift 4
                continue
            else
                printf "%s\n" "fail %{if: wrong argument count}"
            fi
        fi
        exit
    done
}}


# Git diff sidebar
# ─────────────────────────

if %[ "$(command git status 2>/dev/null)" ] %{
  hook global WinCreate .* %{ git show-diff }
  hook global BufWritePost .* %{ git show-diff }
  hook global ModeChange insert:normal %{ git show-diff }
}
