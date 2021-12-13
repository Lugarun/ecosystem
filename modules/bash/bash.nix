{ config, lib, pkgs, ... }:

{
  config = {
    home.packages = [ pkgs.fasd pkgs.w3m pkgs.direnv ];
    programs.bash = {
      enable = true;
      initExtra = ''
        ${builtins.readFile ./bashrc}
        unset __HM_SESS_VARS_SOURCED
        . "/etc/profiles/per-user/lukas/etc/profile.d/hm-session-vars.sh"
      '';
    };
    programs.dircolors.enable = true;
    programs.direnv.enable = true;
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
