{ pkgs, ... }:
let
  pkgs-unstable = import <nixpkgs-unstable> {};
  microsoft-edge-overlay = final: prev: {
    microsoft-edge-dev = prev.callPackage ./microsoft-edge-dev.nix { };
  };
in {
  home.packages = [
    pkgs.microsoft-edge-dev
  ];

  nixpkgs.overlays = [
    microsoft-edge-overlay
  ];
}
