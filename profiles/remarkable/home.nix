{ pkgs, ... }:
let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  home.packages = [
    pkgs.gnome3.nautilus
    pkgs.rmapi
    pkgsUnstable.rmview
  ];
}
