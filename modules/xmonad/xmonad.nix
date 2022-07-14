{ pkgs, config, ... }:
{
  config = {
    home.packages = [
      pkgs.networkmanager_dmenu
      pkgs.dmenu
      pkgs.i3lock
      pkgs.dunst
      pkgs.acpi
      pkgs.pamixer
    ];
    xsession.enable = true;
    xsession.windowManager.xmonad.enable = true;
    xsession.windowManager.xmonad.enableContribAndExtras = true;
    xsession.windowManager.xmonad.config = ./xmonad.hs;

    services.picom = {
      enable = true;
      blur = true;
      inactiveDim = "0.2";
    };

    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome3.adwaita-icon-theme;
      };
      settings = {
        global = {
          geometry = "0x0-20+20";
          indicate_hidden = "yes";
          shrink = "no";
          separator_height = 0;
          padding = 10;
          horizontal_padding = 10;
          frame_width = 2;
          sort = "no";
          transparency = 1;
          font = "Monospace 8";
          markup = "full";
          format = "%s\n%b";
          word_wrap = "yes";
          ignore_newline = "no";
          icon_position = "left";
          max_icon_size = 32;
        };
        urgency_low = {
          background = "#262628";
          foreground = "#ABABA4";
          frame_color = "#262628";
        };
        urgency_normal = {
          background = "#262628";
          foreground = "#ABABA4";
          frame_color = "#262628";
        };
        urgency_critical = {
          background = "#262628";
          foreground = "#ABABA4";
          frame_color = "#262628";
        };
      };
    };

    services.screen-locker = {
      enable = true;
      lockCmd = "\${pkgs.i3lock}/bin/i3lock -n -c 000000";
    };

    services.random-background = {
      enable = true;
      enableXinerama = true;
      imageDirectory = "%h/projects/ecosystem/wallpapers";
      interval = "1h";
    };

    # run autorandr -c to trigger the setting
    programs.autorandr = {
      enable = true;
      profiles = {
        "jasnah" = {
          fingerprint = {
            "eDP" = "00ffffffffffff0006af3d4000000000211c0104a51f1178039b85925659902920505400000001010101010101010101010101010101143780b87038244010103e0035ae10000018000000000000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30342e30200a0097";
          };
          config = {
            "eDP" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
            };
          };
        };
        "jasnah-dual" = {
          fingerprint = {
            "HDMI-A-0" = "00ffffffffffff0004721803ccdf27342a17010380331d782a6275a3554fa027125054b30c00714f818081c081009500b300d1c00101023a801871382d40582c4500fd1e1100001e000000fd00324c1e5011000a202020202020000000ff004c58314141303033343231300a000000fc00416365722048323336484c0a20014c02031a7147010312131f1004230907078301000065030c001000023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000180000000000000000000000000000000000000000000000000000000000e5";
            "eDP" = "00ffffffffffff0006af3d4000000000211c0104a51f1178039b85925659902920505400000001010101010101010101010101010101143780b87038244010103e0035ae10000018000000000000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30342e30200a0097";
          };
          config = {
            "HDMI-A-0" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
            };
            "eDP" = {
              enable = true;
              primary = false;
              position = "0x1080";
              mode = "1920x1080";
            };
          };
        };
        "jasnah-dual-wide" = {
          fingerprint = {
            "HDMI-A-0" = "00ffffffffffff001e6df676ee3705000b1c010380502278eaca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a01df02031ef12309070749100403011f13595a128301000067030c00100038409f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000ff003831314e54524c41313939380a0000000000000024";
            "eDP" = "00ffffffffffff0006af3d4000000000211c0104a51f1178039b85925659902920505400000001010101010101010101010101010101143780b87038244010103e0035ae10000018000000000000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30342e30200a0097";
          };
          config = {
            "HDMI-A-0" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "3440x1440";
            };
            "eDP" = {
              enable = true;
              primary = false;
              position = "1180x1440";
              mode = "1920x1080";
            };
          };
        };
      };
    };
  };
}
