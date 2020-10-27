{ pkgs, ... }:
{
  home.packages = [
    pkgs.aspell
    pkgs.matterhorn
  ];

  xdg.configFile."matterhorn./config.ini".source = ./config.ini;

}
