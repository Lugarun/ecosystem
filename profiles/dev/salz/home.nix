{ pkgs, ... }:
{
  home.packages = [
    pkgs.kubectl
    pkgs.cabal2nix # https://github.com/Gabriel439/haskell-nix
    pkgs.nix-prefetch-git
    pkgs.cabal-install
  ];

  home.file.".kube/config".source = ../../secrets/config;
}
