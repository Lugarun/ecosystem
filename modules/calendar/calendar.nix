{ config, lib, pkgs, ... }:
let
  khal_reminder_script = pkgs.writeShellScriptBin "khal_reminder" (builtins.readFile ./khal_reminder.sh);
  khal_reminder = pkgs.symlinkJoin {
    name = "khal_reminder";
    paths = [ khal_reminder_script pkgs.khal pkgs.vdirsyncer pkgs.bc pkgs.coreutils ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/khal_reminder --prefix PATH : $out/bin";
  };
in {
  config = {
    home.packages = [ pkgs.khard pkgs.todoman pkgs.khal pkgs.vdirsyncer khal_reminder ];

    xdg.configFile."vdirsyncer/config".source = ../../secrets/vdirsyncer.conf;
    xdg.configFile."khal/config".source = ./khal.conf;
    xdg.configFile."todoman/config.py".source = ./todoman_config.py;


    systemd.user.timers.vdirsyncer = {
      Unit = {
        Description = "Timer to synchronize calendars";
      };
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnBootSec = "15min";
      };
    };
    systemd.user.services.vdirsyncer = {
      Unit = {
        Description = "Synchronize your calendars";
        Wants = [ "network-online.target" ];
        After = [ "network-online.target" ];
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        ExecStart = "${khal_reminder}/bin/khal_reminder";
        Restart = "on-failure";
        Type = "oneshot";
        RestartSec = 30;
      };
    };
  };
}
