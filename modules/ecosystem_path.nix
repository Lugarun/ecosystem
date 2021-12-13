{ config, lib, pkgs, ... }:

{
  options.ecosystem.config_paths = {
    baseDir = lib.mkOption {
      type = lib.types.path;
      default = /home/lukas/projects/ecosystem;
      description = ''
                  Base directory for the ecosystem configuration.
                  '';
    };
  };
}
