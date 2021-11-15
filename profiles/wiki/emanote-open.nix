let
  pkgs = import <nixpkgs-unstable> {};
in pkgs.stdenv.mkDerivation {
  name = "emanote-open";
  src = ./.;
  buildInputs = [
    (pkgs.haskellPackages.ghcWithPackages (p: [p.relude p.errors]))
  ];
  buildPhase = ''
    ghc emanote-open.hs
  '';
  installPhase = ''
    mkdir -p "$out/bin"
    cp ./emanote-open "$out/bin"
  '';
}
