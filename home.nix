{ pkgs, ... }:

{
  imports = [
    ./modules/alacritty.nix
    ./modules/bash/bash.nix
    ./modules/zsh.nix
    ./modules/chromium.nix
    ./modules/calendar/calendar.nix
    ./modules/colors.nix
    ./modules/ecosystem_path.nix
    ./modules/mail.nix
    ./modules/kakoune/kakoune.nix
    ./modules/git.nix
    ./modules/tmux/tmux.nix
    ./modules/xmonad/xmonad.nix
    ./modules/zathura.nix
  ];

  # Home-manager setup
  programs.home-manager.enable = true;
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";
  home.stateVersion = "20.09";


  home.packages = [
      pkgs.dconf # for gtk
      pkgs.dtach
      pkgs.emojipick
      pkgs.xclip
      pkgs.threema-desktop
      pkgs.bat
      pkgs.exa
      pkgs.tab-rs
      pkgs.lutris
      pkgs.element-desktop
      pkgs.gvfs
      pkgs.cinnamon.nemo
      pkgs.nixfmt
      pkgs.dstask
      pkgs.dvtm
      pkgs.abduco
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
      pkgs.xournal
      pkgs.killall
      pkgs.unstable.zotero # TODO currently manual: install/set zotfile directory and other addons, all configurration is manual
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
      pkgs.unstable.gotktrix
      pkgs.gnumake
      pkgs.jq
      ((pkgs.emacsPackagesFor pkgs.emacsNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm epkgs.pyenv-mode ]))
      pkgs.sqlite
      pkgs.gcc
      pkgs.unstable.helix
      pkgs.dracula-theme
      pkgs.taskspooler
      ];

  home.sessionVariables.DSTASK_GIT_REPO = "/home/lukas/projects/task";

  gtk = {
      enable = true;
      theme = {
          package = pkgs.dracula-theme;
          name="Dracula";
          };
      iconTheme = {
          package = pkgs.dracula-theme;
          name = "Dracula";
          };
      };
  home.sessionVariables.GTK_THEME = "Dracula";

  programs.htop = {
    enable = true;
  };

  #home.file.".local/bin/killabduco" = {
  #  source = ./killabduco;
  #  executable = true;
  #};
  #home.file.".local/bin/myabduco" = {
  #  source = ./myabduco;
  #  executable = true;
  #};
  #home.file.".local/bin/fzfabduco" = {
  #  source = ./fzfabduco;
  #  executable = true;
  #};
  #home.file.".local/bin/remote-push" = {
  #  source = ./remote-push;
  #  executable = true;
  #};
  #home.file.".local/bin/remote-pull" = {
  #  source = ./remote-pull;
  #  executable = true;
  #};

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "restart-xmonad" = "xmonad --restart";
    };
  };
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "qt";
  services.gpg-agent.defaultCacheTtl = 7200;
  programs.password-store.enable = true;

}
