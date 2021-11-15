{ pkgs, ... }:
{
  programs.broot.enable = true;
  programs.broot.enableZshIntegration = true;
  programs.dircolors.enable = true;
  programs.dircolors.enableZshIntegration = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.settings = {
    add_newline = false;
    line_break.disabled = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true; # allow terminal to track current working dir
    defaultKeymap = "vicmd";
  };


}
