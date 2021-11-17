{ config, pkgs, ... }:

{
  imports = [
    ./profiles/zathura/home.nix
    ./profiles/alacritty/home.nix
    ./profiles/kitty/home.nix
    ./profiles/colors/home.nix
    ./profiles/tmux/home.nix
    ./profiles/xmonad/home.nix
    ./profiles/bash/home.nix
    ./profiles/zsh/home.nix
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
      pkgs.dstask
      pkgs.bpytop
      pkgs.dateutils
      pkgs.remind
      pkgs.wyrd
      pkgs.texlive.combined.scheme-full
      pkgs.sqlite
      pkgs.fzf
      pkgs.ripgrep
      pkgs.obs-studio
      pkgs.gnome3.gnome-screenshot
      pkgs.zoom-us
      pkgs.zip
      pkgs.blueberry
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
      pkgs.unzip
      pkgs.udisks
      pkgs.mplayer
      pkgs.gnumake
      pkgs.jq
      ];

  home.sessionVariables.DSTASK_GIT_REPO = "/home/lukas/projects/task";

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

  programs.htop = {
    enable = true;
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
