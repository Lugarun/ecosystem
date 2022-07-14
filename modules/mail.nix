{ config, lib, pkgs, ... }:

let
  cfg = config.ecosystem.mail;
in {
  # TODO Requires manual imperative handling of doom install and updates
  imports = [
    ./git.nix
    ./bash/bash.nix
    ./ecosystem_path.nix
  ];

  options.ecosystem.mail = {
    maildir = lib.mkOption {
      type = lib.types.path;
      default = /home/lukas/.mail;
    };
  };

  config = {
    home.packages = [
      pkgs.mu
      pkgs.isync
      pkgs.offlineimap
      pkgs.davmail
      pkgs.nixfmt

      pkgs.zeromq
      pkgs.libtool
      (pkgs.aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    ];

    accounts.email = {
      maildirBasePath = builtins.toString cfg.maildir;
      accounts = {
        Gmail = {
          address = "lfschmidt.me@gmail.com";
          userName = "lfschmidt.me@gmail.com";
          flavor = "gmail.com";
          passwordCommand = "${pkgs.pass}/bin/pass email/Gmail/lfschmidt.me_app";
          primary = true;
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" "[Gmail]*" ];
          };
          realName = "Lukas Schmidt";
          msmtp.enable = true;
          mu.enable = true;
          neomutt.enable = true;
        };
        Uwaterloo = {
          address = "lfschmid@uwaterloo.ca";
          userName = "lfschmid@uwaterloo.ca";
          aliases = [ "lfschmidt@uwaterloo.ca" ];
          passwordCommand = "${pkgs.pass}/bin/pass School/watiam";
          flavor = "plain";
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" ];
            extraConfig.account = {
              AuthMechs = "LOGIN";
            };
          };
          imap = {
            host = "localhost";
            port = 1143;
            tls.enable = false;
          };
          realName = "Lukas Schmidt";
          msmtp = {
            enable = true;
            extraConfig = {
              auth = "login";
            };
          };
          smtp = {
            host = "localhost";
            port = 1025;
            tls.enable = false;
          };
          mu.enable = true;
          neomutt.enable = true;
        };
      };
    };

    programs = {
      msmtp.enable = true;
      mbsync.enable = true;
      mu.enable = true;
      neomutt = {
        enable = true;
        vimKeys = true;
        sidebar = {
          enable = true;
        };
      };
    };

    # Need to run mu init -m $maildir once before you can begin
    systemd.user.services.mbsync = {
      Unit = { Description = "mbsync mailbox synchronization"; };
      Service = {
        Type = "oneshot";
        ExecStart =
          "${pkgs.isync}/bin/mbsync --all";
        ExecStop = "${pkgs.mu}/bin/mu index";
        Environment = "PASSWORD_STORE_DIR=/home/lukas/.local/share/password-store";
      };
    };

    systemd.user.timers.mbsync = {
      Unit = { Description = "mbsync mailbox synchronization"; };
      Timer = {
        OnCalendar = "*:0/15";
        Unit = "mbsync.service";
      };
      Install = { WantedBy = [ "timers.target" ]; };
    };
  };
}
