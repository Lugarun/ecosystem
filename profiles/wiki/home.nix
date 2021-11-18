{ pkgs, ... }:
let
  emanote-open = (import ./emanote-open.nix) pkgs;
in {
  home.packages = [
    emanote-open
  ];
}
