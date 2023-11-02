{
  description = "My Home Manager Configuration";

  inputs = {
    tree-sitter-kak.url = "github:enricozb/tree-sitter.kak";
    panrun.url = "github:lugarun/panrun";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, tree-sitter-kak, panrun, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            panrun = panrun.packages.${system}.panrun;
          })
          (final: prev: {
            inherit tree-sitter-kak;
            ripgrep-all = prev.ripgrep;
          })
        ];
      };
  in {
    homeConfigurations."lukas" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.home-manager
      ];
    };
  };
}
