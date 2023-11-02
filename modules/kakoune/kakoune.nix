# --------------------------------------------------
# Kakoune plugins are handled by nix
# these files are loaded into '../share/kak/kakrc'
# relative to the binary kak which get's loaded by kak

# --------------------------------------------------
# Actual configuration is done in the kakrc, this should
# be fairly small, if anything gets too big, split
# it off into a plugin

# --------------------------------------------------
# The configuration for the plugins is done in the plugin
# folder that gets sourced by kakrc

{ pkgs, ... }:
let
  tagbar = import ./tagbar.nix { pkgs = pkgs; };
  kakpipe = import ./kakpipe.nix { pkgs = pkgs; };
  kak-kakpipe = import ./kak-kakpipe.nix { pkgs = pkgs; };
  kak-tree-sitter = pkgs.callPackage ./kak-tree-sitter.nix { };
in {
  config = {
    home.packages = [
      pkgs.tree-sitter-kak
      (pkgs.wrapKakoune pkgs.kakoune-unwrapped {
        configure = { plugins = [
          tagbar
          kak-kakpipe
          pkgs.kakounePlugins.kakboard
          pkgs.kakounePlugins.kakoune-rainbow
        ]; };
      })
      pkgs.kakoune-cr
      pkgs.guile
      pkgs.fzy
      pkgs.fd
      pkgs.universal-ctags
      pkgs.xdotool

      kak-tree-sitter
      pkgs.tree-sitter
      pkgs.tree-sitter-grammars.tree-sitter-markdown
      pkgs.kak-lsp
      pkgs.panrun
      kakpipe
      pkgs.parallel
      pkgs.nodePackages_latest.pyright
      pkgs.rnix-lsp
      pkgs.glow

      pkgs.socat # for remote editing
  
      pkgs.xsel
      pkgs.fasd
      pkgs.nixpkgs-fmt
      pkgs.nodejs # for idris
      pkgs.nil
      pkgs.nodePackages_latest.bash-language-server
      pkgs.nodePackages_latest.yaml-language-server
    ];
    home.sessionVariables = {
      EDITOR = "kak";
    };
  
    fonts.fontconfig.enable = true;
  
    xdg.configFile."kak/kakrc".source = ./kakrc;
    xdg.configFile."kak/plugins".source = ./plugins;
  
    xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
    ${builtins.readFile ./kak-lsp.toml}
    '';
  };
}
