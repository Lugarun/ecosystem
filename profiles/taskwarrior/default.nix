with import <nixpkgs>{ };

rustPlatform.buildRustPackage rec {
  pname = "taskwarrior-tui";
  version = "v0.9.5";

  src = fetchFromGitHub {
    owner = "kdheepak";
    repo = pname;
    rev = version;
    # Get the sha256 via `nix-prefetch-git --url https://github.com/kdheepak/taskwarrior-tui --rev v0.9.5`
    sha256 = "1348ypjphm5f46civbrcxbbahwwl2j47z1hg8ndq1cg2bh5wb8kg";
  };

  checkPhase = "";

  # at first, set `cargoSha256 = lib.fakeSha256`, and try to build. Nix will say it wanted
  # sha256:0000...0000, but instead it got `sha256:blahblah`. Use `sha256:blahblah` for `cargoSha256`
  cargoSha256 = "sha256:1s8hj23i4q5a6z08yp28922hx2a7acck44m509jc82d5bvygn5c1";

  meta = with stdenv.lib; {
    description = "A terminal user interface for taskwarrior";
    homepage = "https://github.com/kdheepak/taskwarrior-tui";
    license = licenses.mit;
  };
}
