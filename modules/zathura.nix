{ config, lib, pkgs, ... }:

{
  imports = [
    ./colors.nix
  ];
  config = {
    programs.zathura = {
      enable = true;
      extraConfig = ''
        set selection-clipboard clipboard
        set recolor "true"

        set completion-bg "${config.ecosystem.colors.background}"
        set completion-fg "${config.ecosystem.colors.foreground}"
        set completion-group-bg "${config.ecosystem.colors.background}"
        set completion-group-fg "${config.ecosystem.colors.color3}"
        set completion-highlight-bg "${config.ecosystem.colors.foreground}"
        set completion-highlight-fg "${config.ecosystem.colors.background}"

        set recolor-lightcolor "${config.ecosystem.colors.background}"
        set recolor-darkcolor "${config.ecosystem.colors.foreground}"
        set default-bg "${config.ecosystem.colors.background}"

        set inputbar-bg "${config.ecosystem.colors.background}"
        set inputbar-fg "${config.ecosystem.colors.foreground}"
        set notification-bg "${config.ecosystem.colors.background}"
        set notification-fg "${config.ecosystem.colors.foreground}"
        set notification-error-bg "${config.ecosystem.colors.color1}"
        set notification-error-fg "${config.ecosystem.colors.foreground}"
        set notification-warning-bg "${config.ecosystem.colors.color1}"
        set notification-warning-fg "${config.ecosystem.colors.foreground}"
        set statusbar-bg "${config.ecosystem.colors.background}"
        set statusbar-fg "${config.ecosystem.colors.foreground}"
        set index-bg "${config.ecosystem.colors.background}"
        set index-fg "${config.ecosystem.colors.foreground}"
        set index-active-bg "${config.ecosystem.colors.foreground}"
        set index-active-fg "${config.ecosystem.colors.background}"
        set render-loading-bg "${config.ecosystem.colors.background}"
        set render-loading-fg "${config.ecosystem.colors.foreground}"

        set window-title-home-tilde true
        set statusbar-basename true
        set selection-clipboard clipboard
      '';
     };
  };
}
