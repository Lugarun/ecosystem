{ pkgs, ... }:
let
  ide = import ./ide.nix { pkgs = pkgs; };
in 
{
  home.packages = [
    ide
  ];
  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.sidebar
      pkgs.tmuxPlugins.yank
      pkgs.tmuxPlugins.battery
      pkgs.tmuxPlugins.cpu
      pkgs.tmuxPlugins.fingers
    ];
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}
    '';
  };
}
