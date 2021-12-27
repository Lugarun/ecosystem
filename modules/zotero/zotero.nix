{ config, lib, pkgs, ... }:
let
  zotero-watch = pkgs.callPackage ./zotero-watch.nix { };
in {
  config = {
    home.packages = [
      pkgs.rmapi
      pkgs.zotero-remarkable
    ];
    systemd.user.services.zotero-remarkable = {
      Unit = {
        Description = "Sync zotero files with the remarkable tablet.";
        After = [ "network.target" ];
      };
      Install = {
        WantedBy =  [ "default.target" ];
      };
      Service = {
        ExecStart = "${zotero-watch}/bin/zotero-watch /home/lukas/projects/zotfile Zotfile";
      };
    };
  };
}
