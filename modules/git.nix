{ config, lib, pkgs, ... }:

{
  config = {
    home.pakages = [
      pkgs.lazygit
      pkgs.git-crypt
    ];
    programs.git = {
      enable = true;
      userName = "Lukas Schmidt";
      userEmail= "lfschmidt.me@gmail.com";
    };
  };
}
