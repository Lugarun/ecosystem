{ config, pkgs, lib, ... }:

{
  imports = [
    # ./profiles/emacs/home.nix
    ./profiles/zathura/home.nix
    ./profiles/taskwarrior/home.nix
    ./profiles/alacritty/home.nix
    ./profiles/colors/home.nix
    ./profiles/tmux/home.nix
    ./profiles/xmonad/home.nix
    ./profiles/bash/home.nix
    ./profiles/zsh/home.nix
    ./profiles/firefox/home.nix
    ./profiles/git/home.nix
    ./profiles/kakoune/home.nix
    ./profiles/secrets/home.nix
    ./profiles/mopidy/home.nix
    ./profiles/matterhorn/home.nix
    ./profiles/wiki/home.nix
    ./profiles/bandwidth-blame/home.nix
    ./profiles/chromium/home.nix
    ./profiles/remarkable/home.nix
    ./profiles/dev/salz/home.nix
  ];

  # Home-manager setup
  programs.home-manager.enable = true;
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";
  home.stateVersion = "20.09";


  home.packages = [
      pkgs.obs-studio
      pkgs.gnome3.gnome-screenshot
      pkgs.zoom-us
      pkgs.zip
      pkgs.blueberry
      pkgs.kdeApplications.okular
      pkgs.simplescreenrecorder
      pkgs.sxiv
      pkgs.imv
      pkgs.gnome3.eog
      pkgs.vlc
      pkgs.bc
      pkgs.youtubeDL
      pkgs.xournal
      pkgs.killall
      pkgs.zotero
      pkgs.restic
      pkgs.openconnect
      pkgs.scrot
      pkgs.usbutils
      pkgs.pciutils
      pkgs.spotify-tui
      pkgs.tree
      pkgs.entr
      pkgs.wesnoth
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
      pkgs.mplayer
      pkgs.steam
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

  programs.htop = {
    enable = true;
    vimMode = true;
    showProgramPath = false;
  };

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "restart-xmonad" = "xmonad --restart";
    };
  };
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "qt";
  programs.password-store.enable = true;

}
