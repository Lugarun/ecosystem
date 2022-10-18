{ pkgs, ... }:
{
  config = {
    programs.tmux = {
      enable = true;
      plugins = [
        pkgs.tmuxPlugins.sidebar
        pkgs.tmuxPlugins.yank
        pkgs.tmuxPlugins.battery
        pkgs.tmuxPlugins.cpu
        pkgs.tmuxPlugins.fingers
        pkgs.tmuxPlugins.extrakto
        pkgs.tmuxPlugins.continuum
      ];
      extraConfig = ''
      ${builtins.readFile ./tmux.conf}
    '';
    };
  };
}
