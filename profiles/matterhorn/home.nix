{ pkgs, ... }:
let
    aspell = pkgs.aspellWithDicts (d: [d.en]);
in {
  home.packages = [
    aspell
    pkgs.matterhorn
  ];

  xdg.configFile."matterhorn/config.ini".source = ./config.ini;

}
