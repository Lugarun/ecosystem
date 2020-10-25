{ pkgs, ... }:
{
  home.packages = [ pkgs.fasd pkgs.w3m ];
  programs.bash = {
      enable = true;
      initExtra = ''
       ${builtins.readFile ./bashrc}
      '';
  };
}
