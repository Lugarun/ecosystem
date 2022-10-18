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
      pkgs.notmuch
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
          notmuch.enable = true;
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
          notmuch.enable = true;
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
        extraConfig = ''
        auto_view text/html
        set mailcap_path = ~/.config/mailcap/mailcap
        macro index,pager A "<save-message>=Archive<enter>" "Archive Message"
        '';
      };
    };

    # source: https://gist.github.com/akheron/61a01d597360c0187dc4#file-mailcap
    xdg.configFile."mailcap/mailcap".text = ''
      # Open in browser when viewing interactively
      text/html; chromium %s && sleep 1.5; description=HTML Text; nametemplate=%s.html
      
      # Dump with w3cm and the correct encoding when viewing non-interactively
      text/html; w3m -dump -T text/html -I %{charset} -O utf-8 %s; copiousoutput; description=HTML Text; nametemplate=%s.html
      
      image/png; sxiv '%s'; test=test -n "$DISPLAY"
      image/jpeg; sxiv '%s'; test=test -n "$DISPLAY"
      
      # Support non-standard image/jpg, too
      image/jpg; sxiv '%s'; test=test -n "$DISPLAY"
      
      application/pdf; zathura '%s'; test=test -n "$DISPLAY"
      application/x-pdf; zathura '%s'; test=test -n "$DISPLAY"
      
      # doc/docx
      application/vnd.openxmlformats-officedocument.wordprocessingml.document; lowriter '%s'; test=test -n "$DISPLAY"
      application/msword; lowriter '%s'; test=test -n "$DISPLAY"
      
      # xlsx
      application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; localc '%s'; test=test -n "$DISPLAY"
      
      # winmail.dat
      application/ms-tnef; tnef -w %s
    '';

    # Need to run mu init -m $maildir once before you can begin
    systemd.user.services.mbsync = {
      Unit = { Description = "mbsync mailbox synchronization"; };
      Service = {
        Type = "oneshot";
        ExecStart =
          "${pkgs.isync}/bin/mbsync --all";
        ExecStop = "${pkgs.mu}/bin/mu index; ${pkgs.notmuch}/bin/notmuch new";
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
