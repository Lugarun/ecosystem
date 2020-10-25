{ pkgs, ... }:
{
  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.dmenu
    pkgs.alacritty
  ];
  xsession.enable = true;
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ./xmonad.hs;
}
