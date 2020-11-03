{ pkgs?import <nixpkgs> {}, ... }:
let
  kak-prelude = import ./kak-prelude.nix { pkgs = pkgs; };
in pkgs.stdenv.mkDerivation {
 name = "kak-connect";
 version = "2020-10-26";

 src = pkgs.fetchFromGitHub {
   owner = "alexherbo2";
   repo = "connect.kak";
   rev = "12577666359ec38c1adcb78ced570944f7da7f9a";
   sha256 = "0c7bslrwhnqrk1apd243w4lvs3hh11fvplb0abi5wpkghcd8byd5";
 };

 dontBuild = true;
 propagatedBuildInputs = [ kak-prelude ];

 installPhase = ''
   mkdir -p  $out/share/kak/autoload/plugins/connect $out/bin
   cp "bin/kak-shell" $out/bin
   cp "bin/kak-desktop" $out/bin
   cp -r rc $out/share/kak/autoload/plugins/connect
 '';
 meta = with pkgs.stdenv.lib;
 {
   description = "Kakoune connect to terminal";
   homepage = "https://github.com/alexherbo2/connect.kak";
   licence = licenses.unlicense;
   platform = platforms.all;
 };
}
