{ pkgs?import <nixpkgs> {}, ... }:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "kakpipe";
  version = "0.5.7";

  src = pkgs.fetchFromGitHub {
    owner = "eburghar";
    repo = pname;
    rev = version;
    sha256 = "VjR6Kfbmdjv/tjYue40QP8pnvG3X+lRHwI7ERLvO9xM=";
  };

  cargoHash = "sha256-vn2fX9DqhX6N5/BQ64rk0CWdAxGQCZZwMYzDBEWMwGU=";

  meta = with pkgs.stdenv.lib; {
    description = "Kakpipe Executable";
    homepage = "https://git.itsufficient.me/rust/kakpipe";
    platform = platforms.all;
  };
}
