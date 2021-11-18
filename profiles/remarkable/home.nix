{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome3.nautilus
    pkgs.rmapi
  ];
}
