{ pkgs, ... }:
let
  emanote-open = import ./emanote-open.nix;
in {
  home.packages = [
    emanote-open
  ];
}
