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

  cargoLock = {
    lockFile = ./kakpipe.Cargo.lock;
    outputHashes = {
      "kak-0.1.2" = "sha256-RhtHQkC9yCSJtr/kbC5c9MavbL79acrsiEGXyoAST8U=";
      "yew-ansi-0.1.0" = "sha256-dSaEzqiOon+OqCZKQudzLRNP+Iv97kC+XZcTElKNrzs=";
    };
  };

  meta = with pkgs.stdenv.lib; {
    description = "Kakpipe Executable";
    homepage = "https://git.itsufficient.me/rust/kakpipe";
    platform = platforms.all;
  };
}
