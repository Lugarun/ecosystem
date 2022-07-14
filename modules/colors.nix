{ lib, ... }:
let
  color = (name:
    (lib.mkOption {
      description = "${name}";
      type = lib.types.str;
    }));
  stdDark = {
    foreground = "#c5c8c6";
    background = "#1d1f21";
    cursorColor = "#c5c8c6";
    color0 = "#282a2e";
    color8 = "#373b41";
    color1 = "#a54242";
    color9 = "#cc6666";
    color2 = "#8c9440";
    color10 = "#b5bd68";
    color3 = "#de935f";
    color11 = "#f0c674";
    color4 = "#5f819d";
    color12 = "#81a2be";
    color5 = "#85678f";
    color13 = "#b294bb";
    color6 = "#5e8d87";
    color14 = "#8abeb7";
    color7 = "#707880";
    color15 = "#c5c8c6";
  };
  gotham = {
    foreground = "#98d1ce";
    background = "#0a0f14";
    cursorColor = "#98d1ce";
    color0 = "#0a0f14";
    color8 = "#10151b";
    color1 = "#c33027";
    color9 = "#d26939";
    color2 = "#26a98b";
    color10 = "#081f2d";
    color3 = "#edb54b";
    color11 = "#245361";
    color4 = "#195465";
    color12 = "#093748";
    color5 = "#4e5165";
    color13 = "#888ba5";
    color6 = "#33859d";
    color14 = "#599caa";
    color7 = "#98d1ce";
    color15 = "#d3ebe9";
  };
in
{
  options.ecosystem = {
    colors = lib.mkOption {
      description =
        "The colors that should be used wherever possible to theme the os.";
      type = lib.types.submodule {
        options = {
          background = color "background";
          foreground = color "foreground";
          cursorColor = color "cursorColor";
          color0 = color "color0";
          color1 = color "color1";
          color2 = color "color2";
          color3 = color "color3";
          color4 = color "color4";
          color5 = color "color5";
          color6 = color "color6";
          color7 = color "color7";
          color8 = color "color8";
          color9 = color "color9";
          color10 = color "color10";
          color11 = color "color11";
          color12 = color "color12";
          color13 = color "color13";
          color14 = color "color14";
          color15 = color "color15";
        };
      };
      default = gotham;
    };
  };
}
