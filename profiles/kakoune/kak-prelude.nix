{ pkgs?import <nixpkgs> {}, ... }:
pkgs.stdenv.mkDerivation {
 name = "kak-prelude";
 version = "2020-11-02";

 src = pkgs.fetchFromGitHub {
   owner = "alexherbo2";
   repo = "prelude.kak";
   rev = "f1e0f4d5cb62a36924e3f8ba6824d6aed8c19d23";
   sha256 = "1pncr8azqvl2z9yvzhc68p1s9fld8cvak8yz88zgrp5ypx2cxl8c";
 };

 dontBuild = true;

 installPhase = ''
   mkdir -p $out/share/kak/autoload/plugins/prelude
   cp -r rc $out/share/kak/autoload/plugins/prelude
 '';
 meta = with pkgs.stdenv.lib;
 {
   description = "Kakoune prelude";
   homepage = "https://github.com/alexherbo2/prelude.kak";
   licence = licenses.unlicense;
   platform = platforms.all;
 };
}
