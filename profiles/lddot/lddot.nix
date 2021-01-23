let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  name = "lddot";
  src = pkgs.fetchFromGitHub {
    owner = "jwilk";
    repo = "lddot";
    rev = "5123236358e81d78ab5ad5193099af2d5a4db57b";
    sha256 = "0i3ry462h9kxa74m656lyi3vf63sqyc7zb68q7kw88zwdfr6ih09";
  };
}
