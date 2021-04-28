{ pkgs?import <nixpkgs> {}, ... }:
pkgs.stdenv.mkDerivation {
  name = "kak-tagbar";
  version = "2021-04-28";

  src = pkgs.fetchFromGitHub {
    owner = "andreyorst";
    repo = "tagbar.kak";

    rev = "6ed0ebba91211f0bbc4c3aac0f6fe6cf82d019d1";
    sha256 = "0h985x62dwjpcl0zxsns5f6pr67i3zghi7w19qziy0ibf72g54bh";
  };

  propagatedBuildInputs = [
    pkgs.universal-ctags
    ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/kak/autoload/plugins/tagbar
    cp -r rc/tagbar.kak $out/share/kak/autoload/plugins/tagbar/tagbar.kak
  '';

  meta = with pkgs.stdenv.lib;
  {
    description = "Kakoune Tagbar";
    homepage = "https://github.com/andreyorst/tagbar";
    platform = platforms.all;
  };
}
