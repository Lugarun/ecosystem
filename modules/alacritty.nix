{ config, ... }:
{
  imports = [
    ./colors.nix
  ];
  config = {
    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 8;
        window.opacity = 0.9;
        colors = {
          primary = {
            background = config.ecosystem.colors.background;
            foreground = config.ecosystem.colors.foreground;
          };
          normal = {
            black = config.ecosystem.colors.color0;
            red = config.ecosystem.colors.color1;
            green = config.ecosystem.colors.color2;
            yellow  = config.ecosystem.colors.color3;
            blue = config.ecosystem.colors.color4;
            magenta = config.ecosystem.colors.color5;
            cyan = config.ecosystem.colors.color6;
            white = config.ecosystem.colors.color7;
          };
          bright = {
            black = config.ecosystem.colors.color8;
            red = config.ecosystem.colors.color9;
            green = config.ecosystem.colors.color10;
            yellow  = config.ecosystem.colors.color11;
            blue = config.ecosystem.colors.color12;
            magenta = config.ecosystem.colors.color13;
            cyan = config.ecosystem.colors.color14;
            white = config.ecosystem.colors.color15;
          };
        };
      };
    };
  };
}
