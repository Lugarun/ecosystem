{ config, lib, pkgs, ... }:

{
  config = {
    home.packages = [ pkgs.fasd pkgs.w3m pkgs.direnv pkgs.ripgrep-all ];
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
    programs.direnv.nix-direnv.enable = true;
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        format = "$all\${custom.tab}\${custom.kakoune}$line_break$jobs$battery$time$status$shell$character";
        custom = {
          tab = {
            description = "The current tab in the tab terminal multiplexer";
            command = "tab --starship";
            when = "tab --starship";
            shell = ["sh"];
            style = "bold blue";
          };
          kakoune = {
            symbol = "🐈";
            command = "kcr prompt";
            when = "kcr prompt";
            shell = ["bash"];
            description = "The current Kakoune session and client";
            style = "green";
            format = "[$symbol $output]($style)";
          };
        };
      };
    };
  };
}
