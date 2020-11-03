{ pkgs?import <nixpkgs> {}, ... }:
pkgs.stdenv.mkDerivation {
 name = "kak-explore";
 version = "2020-11-02";

 src = pkgs.fetchFromGitHub {
   owner = "alexherbo2";
   repo = "explore.kak";
   rev = "e15cfa47e50f60f4a395b3a42abeba41b0cc2d0b";
   sha256 = "12asq5x02lkdd8qpd859c06g2p87abgj6vi49fdk96qgzdb7h336";
 };

 dontBuild = true;

 installPhase = ''
   mkdir -p $out/share/kak/autoload/plugins/explore
   cp -r rc $out/share/kak/autoload/plugins/explore
 '';
 meta = with pkgs.stdenv.lib;
 {
   description = "Kakoune explore";
   homepage = "https://github.com/alexherbo2/explore.kak";
   licence = licenses.unlicense;
   platform = platforms.all;
 };
}
