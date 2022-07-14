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
    };
    programs.lazygit.enable = true;
  };
}
