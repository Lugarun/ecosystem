{ config, ... }:
{
  programs.zathura = {
   enable = true;
   extraConfig = ''
     set selection-clipboard clipboard
     set recolor "true"
     
     set completion-bg "${config.colors.background}"
     set completion-fg "${config.colors.foreground}"
     set completion-group-bg "${config.colors.background}"
     set completion-group-fg "${config.colors.color3}"
     set completion-highlight-bg "${config.colors.foreground}"
     set completion-highlight-fg "${config.colors.background}"
     
     set recolor-lightcolor "${config.colors.background}"
     set recolor-darkcolor "${config.colors.foreground}"
     set default-bg "${config.colors.background}"
     
     set inputbar-bg "${config.colors.background}"
     set inputbar-fg "${config.colors.foreground}"
     set notification-bg "${config.colors.background}"
     set notification-fg "${config.colors.foreground}"
     set notification-error-bg "${config.colors.color1}"
     set notification-error-fg "${config.colors.foreground}"
     set notification-warning-bg "${config.colors.color1}"
     set notification-warning-fg "${config.colors.foreground}"
     set statusbar-bg "${config.colors.background}"
     set statusbar-fg "${config.colors.foreground}"
     set index-bg "${config.colors.background}"
     set index-fg "${config.colors.foreground}"
     set index-active-bg "${config.colors.foreground}"
     set index-active-fg "${config.colors.background}"
     set render-loading-bg "${config.colors.background}"
     set render-loading-fg "${config.colors.foreground}"
     
     set window-title-home-tilde true
     set statusbar-basename true
     set selection-clipboard clipboard
   '';
   };
}
