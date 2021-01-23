{ pkgs, ... }:
let
  taskwarrior = import ./default.nix ;
in {
  home.packages = [
    taskwarrior
  ];
}
