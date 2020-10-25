# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "fiasco"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.windowManager.defaultSession = "none+xmonad";
  services.xserver.windowManager.xmonad.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.lukas = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$QoMeQJwCG5Xh$PrTJgARgUCtHDu21ZPZVCxPe8pnB99o4GfjwdmhCmf8e1MsxhP4PtkuuLmqtemLw8g2.WNaZjKzyHExfJtsxj/";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # Allow proprietary software (for broadcm)
  nixpkgs.config.allowUnfree = true;

  # Automatically upgrade
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true

  # Allow users to connect to the Nix daemon without sudo
  nix.allowedUsers = [ "@wheel" ];

  #nix.package = pkgs.nixUnstable;
  #nix.extraOptions = ''
  #  experimental-features = nix-command flakes
  #'';

  # This is needed by wpgtk
  programs.dconf.enable = true;

  # change backlight
  programs.light.enable = true;
  services.actkbd = {
      enable = true;
      bindings = [
          { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
          { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
          { keys = [ 229 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -s sysfs/leds/smc::kbd_backlight -U 20"; }
          { keys = [ 230 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -s sysfs/leds/smc::kbd_backlight -A 20"; }
          { keys = [ 113 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l lukas -c 'amixer -q set Master toggle'"; }
          { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l lukas -c 'amixer -q set Master 5%- unmute'"; }
          { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l lukas -c 'amixer -q set Master 5%+ unmute'"; }

          ];
      };
  nix.nixPath = ["nixpkgs=/home/lukas/.config/nixpkgs"];

}

