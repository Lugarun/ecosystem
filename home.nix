{ config, pkgs, lib, ... }:

let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};

  foreground = "#c5c8c6";
  background = "#1d1f21";
  cursorColor = "#c5c8c6";
  color0 = "#282a2e";
  color8 = "#373b41";
  color1 = "#a54242";
  color9 = "#cc6666";
  color2 = "#8c9440";
  color10 = "#b5bd68";
  color3 = "#de935f";
  color11 = "#f0c674";
  color4 = "#5f819d";
  color12 = "#81a2be";
  color5 = "#85678f";
  color13 = "#b294bb";
  color6 = "#5e8d87";
  color14 = "#8abeb7";
  color7 = "#707880";
  color15 = "#c5c8c6";

#  color0 = "#04020b";
#  color1 = "#2e3568";
#  color2 = "#47346a";
#  color3 = "#90327a";
#  color4 = "#384f87";
#  color5 = "#4e6897";
#  color6 = "#c228b6";
#  color7 = "#a4bdcf";
#  color8 = "#728490";
#  color9 = "#2e3568";
#  color10 = "#47346a";
#  color11 = "#90327a";
#  color12 = "#384f87";
#  color13 = "#4e6897";
#  color14 = "#c228b6";
#  color15 = "#a4bdcf";
#  background = "#04020b";
#  foreground = "#a4bdcf";
#  cursorColor = "#a4bdcf";

in {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = [
      pkgs.htop
      pkgs.lazygit
      pkgs.dmenu
      pkgs.kakoune
      pkgs.wpgtk
      pkgs.syncthing
      pkgs.kitty
      pkgs.unzip
      pkgs.udisks
      pkgs.zathura
      ];


  programs.firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [dark-night-mode];
      profiles = {
          myprofile = {
              settings = {
                  "general.smoothScroll" = false;
                  };
              };
          };
      };

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

  programs.git = {
      enable = true;
      userName = "Lukas Schmidt";
      userEmail= "lfschmidt.me@gmail.com";
      
      };

  programs.kakoune = {
      config = {
          autoReload = "yes";
          };

      };

  home.file.".config/kitty/kitty.conf".text = ''
  background ${background}
  foreground ${foreground}
  color0 ${color0}
  color1 ${color1}
  color2 ${color2}
  color3 ${color3}
  color4 ${color4}
  color5 ${color5}
  color6 ${color6}
  color7 ${color7}
  color8 ${color8}
  color9 ${color9}
  color10 ${color10}
  color11 ${color11}
  color12 ${color12}
  color13 ${color13}
  color14 ${color14}
  color15 ${color15}
  background_opacity 0.5
  '';

  programs.tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
      set -sg escape-time 25
      set-window-option -g mode-keys vi

      set-option -g prefix C-g

      set -g mouse on


      '';
      };

  services.syncthing.enable = true;
  programs.password-store.enable = true;

#  xsession.enable = true;
#  xsession.windowManager.xmonad.enable = true;
#  xsession.windowManager.xmonad.config = '/home/lukas/.config/nixpkgs/xmonad.hs';

}
