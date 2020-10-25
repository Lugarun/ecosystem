{ config, pkgs, lib, ... }:

{
  imports = [
    ./profiles/zathura/home.nix
    ./profiles/alacritty/home.nix
    ./profiles/colors/home.nix
    ./profiles/tmux/home.nix
    ./profiles/xmonad/home.nix
    ./profiles/bash/home.nix
    ./profiles/firefox/home.nix
    ./profiles/git/home.nix
    ./profiles/kakoune/home.nix
  ];

  # Home-manager setup
  programs.home-manager.enable = true;
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";
  home.stateVersion = "20.09";


  home.packages = [
      pkgs.tree
      pkgs.wesnoth
      pkgs.htop
      pkgs.nmap
      pkgs.ncpamixer
      pkgs.bashmount
      pkgs.pandoc
      pkgs.docker
      pkgs.discord
      pkgs.teams
      pkgs.youtube-dl
      pkgs.spotify
      pkgs.wpgtk
      pkgs.syncthing
      pkgs.unzip
      pkgs.udisks
      pkgs.zathura
      pkgs.ghc
      ];

  gtk = {
      enable = true;
      theme = {
          package =pkgs.arc-theme;
          name="Arc-Dark";
          };
      iconTheme = {
          package = pkgs.paper-icon-theme;
          name = "Paper";
          };
      };

  services.syncthing.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "curses";
  programs.password-store.enable = true;

}
