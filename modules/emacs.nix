{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  options.ecosystem.syncthing = {
    configDir = lib.mkOption {
      type = lib.types.path;
      default = /home/lukas/projects/emacs;
      description = ''
        Dir containing emacs config.
      '';
    };
  };

  config = {
    home.packages = [
      pkgs.emacs
      pkgs.ripgrep
      pkgs.coreutils
      pkgs.fd
      pkgs.clang

      pkgs.nixfmt
      pkgs.graphviz
    ];
  };
}
