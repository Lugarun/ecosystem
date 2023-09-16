{ config, lib, pkgs, ... }:

{
  config = {
    home.packages = [ pkgs.fasd pkgs.w3m pkgs.direnv pkgs.ripgrep-all ];
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      autocd = true;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      plugins = [
        {
          name = "forgit";
          file = "forgit.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/wfxr/forgit";
            rev = "8ca463b5c69e95ed100dd66e1134427319cf407c";
          };
        }
      ];
    };
    programs.dircolors.enable = true;
    programs.dircolors.enableZshIntegration = true;
    programs.direnv.enable = true;
    programs.direnv.enableZshIntegration = true;
    programs.direnv.nix-direnv.enable = true;
    programs.fzf.enableZshIntegration = true;

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
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

    programs.eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
  };
}
