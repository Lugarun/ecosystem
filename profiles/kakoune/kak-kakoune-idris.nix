{ pkgs?import <nixpkgs> {}, ... }:
pkgs.stdenv.mkDerivation {
 name = "kak-kakoune-idris";
 version = "2021-06-21";

 src = pkgs.fetchFromGitHub {
   owner = "stoand";
   repo = "kakoune-idris";

   rev = "1acdfb5d89e3951ae4bdf4a5fa2377b36448083d";
   sha256 = "06qny8790j9d7vjs0pfyw71xvc6hmkjl8ssi483mbwbxs0zv6j9r";
 };

 dontBuild = true;

  propagatedBuildInputs = [
    pkgs.idris2
    pkgs.nodejs
    ];

 installPhase = ''
   mkdir -p $out/share/kak/autoload/plugins/idris
   cp -r idris.kak $out/share/kak/autoload/plugins/idris
   mkdir -p $out/share/kak/
   cp -r *.js $out/share/kak/autoload/plugins/idris
 '';
 meta = with pkgs.stdenv.lib;
 {
   description = "Kakoune Idris";
   homepage = "https://github.com/stoand/kakoune-idris";
   platform = platforms.all;
 };
}
