{ pkgs, ... }:
let
  zlinks = import ./zlinks.nix { pkgs = pkgs; };
in {
  home.packages = [
    zlinks
  ];
}
