{ pkgs?import <nixpkgs> {}, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "kak-kakpipe";
  version = "0.5.7";

  src = pkgs.fetchFromGitHub {
    owner = "eburghar";
    repo = "kakpipe";
    rev = version;
    sha256 = "VjR6Kfbmdjv/tjYue40QP8pnvG3X+lRHwI7ERLvO9xM=";
  };

  propagatedBuildInputs = [
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/kak/autoload/plugins/kakpipe
    cp -r rc/kakpipe.kak $out/share/kak/autoload/plugins/kakpipe/kakpipe.kak
  '';

  meta = with pkgs.stdenv.lib;
  {
    description = "Kakoune Kakpipe Plugin";
    homepage = "https://git.itsufficient.me/rust/kakpipe";
    platform = platforms.all;
  };
}
