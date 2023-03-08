require-module kakpipe

define-command -override -params 1.. -docstring "my make" mmake %{
    kakpipe -S -- make %arg{@}
}

define-command -override -params 1.. -docstring "remote pueue" rpueue %{
    kakpipe -S -- pueue -p remote --color=always %arg{@}
}
