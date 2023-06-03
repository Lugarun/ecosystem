{ pkgs?import <nixpkgs> {}, ... }:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "kakpipe";
  version = "0.5.7";

  src = pkgs.fetchFromGitHub {
    owner = "eburghar";
    repo = pname;
    rev = version;
    sha256 = "VjR6Kfbmdjv/tjYue40QP8pnvG3X+lRHwI7ERLvO9xM=";
  };

  cargoSha256 = "vn2fX9DqhX6N5/BQ64rk0CWdAxGQCZZwMYzDBEWMwGU=";
  # cargoLock = {
  #   lockFile = ./cargo.lock;
  #   outputHashes = {
  #     "kak-0.1.2" = "RhtHQkC9yCSJtr/kbC5c9MavbL79acrsiEGXyoAST8U=";
  #     "yew-ansi-0.1.0" = "dSaEzqiOon+OqCZKQudzLRNP+Iv97kC+XZcTElKNrzs=";
  #   };
  # };

  meta = with pkgs.stdenv.lib; {
    description = "Kakpipe Executable";
    homepage = "https://git.itsufficient.me/rust/kakpipe";
    platform = platforms.all;
  };
}
