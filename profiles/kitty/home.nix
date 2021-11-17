{ pkgs, config, ... } :
{
  home.packages = [ pkgs.kitty ];
  home.file.".config/kitty/kitty.conf".text = ''
  background ${config.colors.background}
  foreground ${config.colors.foreground}
  color0 ${config.colors.color0}
  color1 ${config.colors.color1}
  color2 ${config.colors.color2}
  color3 ${config.colors.color3}
  color4 ${config.colors.color4}
  color5 ${config.colors.color5}
  color6 ${config.colors.color6}
  color7 ${config.colors.color7}
  color8 ${config.colors.color8}
  color9 ${config.colors.color9}
  color10 ${config.colors.color10}
  color11 ${config.colors.color11}
  color12 ${config.colors.color12}
  color13 ${config.colors.color13}
  color14 ${config.colors.color14}
  color15 ${config.colors.color15}
  background_opacity 0.5
  enable_audio_bell no
  '';
}
