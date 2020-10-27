{ pkgs, ... }:
{
  home.packages = [ pkgs.fasd pkgs.w3m pkgs.direnv ];
  programs.bash = {
      enable = true;
      initExtra = ''
       ${builtins.readFile ./bashrc}
      '';
  };
}
