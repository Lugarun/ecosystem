{ config, lib, pkgs, ... }:

{
  config = {
    home.packages = [
      pkgs.git-crypt
    ];
    programs.git = {
      enable = true;
      userName = "Lukas Schmidt";
      userEmail= "lfschmidt.me@gmail.com";
      extraConfig = {
        status.showUntrackedFiles= "all";
      };
    };
    programs.lazygit.enable = true;
  };
}
