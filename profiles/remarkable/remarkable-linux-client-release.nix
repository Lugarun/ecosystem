let
  pkgs = import <nixpkgs> {};
in
  pkgs.qt5.callPackage ./remarkable-linux-client.nix {}


