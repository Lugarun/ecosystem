{ pkgs, ... }:
{
  home.packages = [
    pkgs.kak-lsp
    pkgs.fasd
    pkgs.kakoune-config
    pkgs.kakoune
    pkgs.nix-linter
    #pkgs.ccls
    pkgs.nixpkgs-fmt
    (pkgs.nerdfonts.override {
      fonts = [ "DejaVuSansMono" ];})
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."kak/kakrc".source = ./kakrc;
  xdg.configFile."kak/autoload/plugins".source = ./plugins;
  xdg.configFile."kak/autoload/lint".source = ./lint;
  xdg.configFile."kak/autoload/default".source =
    "${pkgs.kakoune-unwrapped}/share/kak/rc";

  xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
  ${builtins.readFile ./kak-lsp.toml}
  '';

}
