{ lib, config, pkgs, ... }:
let
  secret = (name:
    (lib.mkOption {
      description = "${name}";
      type = lib.types.str;
    }));
in
{
  options = {
    secrets = lib.mkOption {
      description = "Lukas's secrets.";
      type = lib.types.submodule {
        options = {
          spotifyusername = secret "spotifyusername";
          spotifypassword = secret "spotifypassword";
          spotifyclientid = secret "spotifyclientid";
          spotifyclientsecret= secret "spotifyclientsecret";
        };
      };
    };
  };
  config.secrets = {
    spotifyusername = builtins.readFile ../../secrets/spotifyusername;
    spotifypassword = builtins.readFile ../../secrets/spotifypassword ;
    spotifyclientid = builtins.readFile ../../secrets/spotifyclientid;
    spotifyclientsecret = builtins.readFile ../../secrets/spotifyclientsecret;
    };
}

