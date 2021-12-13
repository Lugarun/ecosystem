{ config, lib, pkgs, ... }:

{
  # TODO Requires manual imperative handling of doom install and updates
  imports = [
    ../git.nix
    ../bash/bash.nix
    ../ecosystem_path.nix
  ];

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
    home.sessionPath = [ "$HOME/.emacs.d/bin" ];
    home.sessionVariables = {
      EDITOR = "emacs";
      DOOMDIR = config.ecosystem.config_paths.baseDir + /modules/emacs/doom;
    };
  };
}
