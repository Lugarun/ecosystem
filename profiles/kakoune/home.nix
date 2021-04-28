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
  kak-kakboard = import ./kak-kakboard.nix { pkgs = pkgs; };
  tagbar = import ./tagbar.nix { pkgs = pkgs; };
  pkgs-unstable = import <nixpkgs-unstable> {};
  kak-overlay = final: prev: {
    kakoune = pkgs-unstable.kakoune.override {
      plugins = [
        tagbar
        kak-kakboard
        final.kakounePlugins.kak-powerline
        final.kakounePlugins.kak-fzf
      ];
    };
  };
in {
  home.packages = [
    pkgs.kakoune
    pkgs.fzy
    pkgs.fd
    pkgs.universal-ctags

    pkgs.kak-lsp
    pkgs.glow

    pkgs.xsel
    pkgs.fasd
    pkgs.nix-linter
    pkgs.nixpkgs-fmt
    (pkgs.nerdfonts.override {
      fonts = [ "DejaVuSansMono" ];})
  ];

  nixpkgs.overlays = [
    kak-overlay
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."kak/kakrc".source = ./kakrc;
  xdg.configFile."kak/plugins".source = ./plugins;

  xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
  ${builtins.readFile ./kak-lsp.toml}
  '';

}
