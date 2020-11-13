{ pkgs, ... }:
let
  bandwidth-blame = import ./bandwidth-blame.nix { pkgs = pkgs; };
in {
  home.packages = [
    bandwidth-blame
  ];
}
