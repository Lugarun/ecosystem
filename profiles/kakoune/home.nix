{ pkgs, ... }:
{
  home.packages = [
    pkgs.kak-lsp
    pkgs.fasd
  ];

  programs.kakoune = {
      enable = true;
      extraConfig = ''
        ${builtins.readFile ./kakrc}
          '';
      };

  xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
  ${builtins.readFile ./kak-lsp.toml}
  '';

}
