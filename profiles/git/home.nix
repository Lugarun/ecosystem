{ pkgs, ... }:
{
  home.packages = [
    pkgs.lazygit
    pkgs.git-crypt
  ];
  programs.git = {
    enable = true;
    userName = "Lukas Schmidt";
    userEmail= "lfschmidt.me@gmail.com";
  };
}
