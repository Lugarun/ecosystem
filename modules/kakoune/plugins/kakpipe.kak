require-module kakpipe

define-command -override -params 1.. -docstring "my make" mmake %{
    kakpipe -S -- make %arg{@}
}
