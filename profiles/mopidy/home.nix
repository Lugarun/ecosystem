{ pkgs, config, ... }:
let
in
{
  imports = [ ./homeService.nix ];

  home.packages = [
    pkgs.ncmpcpp
    pkgs.mopidy
    pkgs.mopidy-mpd
    pkgs.mopidy-spotify
  ];

  xdg.configFile."ncmpcpp".text = ''
  mpd_host = 127.0.0.1
  mpd_port = 6600
  mpd_music_dir = ~/Music
  '';

  services.mopidy = {
    enable = true;
    extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-mpd ];
    configuration = ''
[mpd]
enabled = true
[spotify]
enabled = true
username = ${config.secrets.spotifyusername}
password = ${config.secrets.spotifypassword}
client_id = ${config.secrets.spotifyclientid}
client_secret = ${config.secrets.spotifyclientsecret}
bitrate = 320
[mopify]
enabled = true
    '';
  };

}

