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
  nord = let
    nord0  = "#2E3440";
    nord1  = "#3B4252";
    nord2  = "#434C5E";
    nord3  = "#4C566A";
    nord4  = "#D8DEE9";
    nord5  = "#E5E9F0";
    nord6  = "#ECEFF4";
    nord7  = "#8FBCBB";
    nord8  = "#88C0D0";
    nord9  = "#81A1C1";
    nord10 = "#5E81AC";
    nord11 = "#BF616A";
    nord12 = "#D08770";
    nord13 = "#EBCB8B";
    nord14 = "#A3BE8C";
    nord15 = "#B48EAD";
  in {
    foreground =   nord4;
    background =   nord0;
    cursorColor =  nord4;
    color0 = nord1;
    color1 = nord11;
    color2 = nord14;
    color3 = nord13;
    color4 = nord9;
    color5 = nord15;
    color6 = nord8;
    color7 = nord5;
    color8 = nord3;
    color9 = nord11;
    color10 = nord14;
    color11 = nord13;
    color12 = nord9;
    color13 = nord15;
    color14 = nord7;
    color15 = nord6;
  };
  dracula = {
    foreground = "#F8F8F2";
    background = "#282A36";
    cursorColor = "#E6E6E6";
    color0 =     "#000000";
    color8 =     "#4D4D4D";
    color1 =     "#FF5555";
    color9 =     "#FF6E67";
    color2 =     "#50FA7B";
    color10 =    "#5AF78E";
    color3 =     "#F1FA8C";
    color11 =    "#F4F99D";
    color4 =     "#BD93F9";
    color12 =    "#CAA9FA";
    color5 =     "#FF79C6";
    color13 =    "#FF92D0";
    color6 =     "#8BE9FD";
    color14 =    "#9AEDFE";
    color7 =     "#BFBFBF";
    color15 =    "#E6E6E6";
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
  defaultDark = {
    foreground  = "#d0d0d0";
    background = "#151515";
    cursorColor = "#d0d0d0";
    color0 = "#151515";
    color8 = "#505050";
    color1 = "#ac4142";
    color9 = "#ac4142";
    color2 = "#90a959";
    color10 = "#90a959";
    color3 = "#f4bf75";
    color11 = "#f4bf75";
    color4 = "#6a9fb5";
    color12 = "#6a9fb5";
    color5 = "#aa759f";
    color13 = "#aa759f";
    color6 = "#75b5aa";
    color14 = "#75b5aa";
    color7 = "#d0d0d0";
    color15 = "#f5f5f5";
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
      default = dracula;
    };
  };
}
