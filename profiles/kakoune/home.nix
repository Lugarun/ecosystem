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
  kakoune-idris = import ./kak-kakoune-idris.nix { pkgs = pkgs; };
in {
  home.packages = [
    (pkgs.wrapKakoune pkgs.kakoune-unwrapped {
      configure = { plugins = [
        tagbar
        kak-kakboard
        pkgs.kakounePlugins.kak-powerline
        pkgs.kakounePlugins.kak-fzf
        kakoune-idris
      ]; };
    })
    pkgs.fzy
    pkgs.fd
    pkgs.universal-ctags
    pkgs.xdotool

    pkgs.kak-lsp
    pkgs.python38Packages.python-language-server
    pkgs.glow

    pkgs.xsel
    pkgs.fasd
    pkgs.nix-linter
    pkgs.nixpkgs-fmt
    pkgs.nodejs # for idris
    (pkgs.nerdfonts.override {
      fonts = [ "DejaVuSansMono" ];})
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."kak/kakrc".source = ./kakrc;
  xdg.configFile."kak/plugins".source = ./plugins;

  xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
  ${builtins.readFile ./kak-lsp.toml}
  '';

}
