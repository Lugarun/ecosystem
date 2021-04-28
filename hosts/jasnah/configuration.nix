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

  networking.hostName = "jasnah"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.enableIPv6 = false;
  networking.useDHCP = false;
  networking.interfaces.enp2s0f0.useDHCP = true;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
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

  

  # Configure keymap in X11
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.libinput.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.windowManager.xmonad.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.lukas = {
    isNormalUser = true;
    extraGroups = [ "video" "networkmanager" "docker" "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$QoMeQJwCG5Xh$PrTJgARgUCtHDu21ZPZVCxPe8pnB99o4GfjwdmhCmf8e1MsxhP4PtkuuLmqtemLw8g2.WNaZjKzyHExfJtsxj/";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    libimobiledevice
    cifs-utils
    tailscale
    docker
  ];

  virtualisation.docker.enable = true ;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.usbmuxd.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ]; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
  
  nixpkgs.config.allowunfree = true;
  nix.allowedUsers = [ "@wheel" ];
  programs.dconf.enable = true;

  # change backlight
  programs.light.enable = true;
  services.actkbd = {
      enable = true;
      bindings = [
          { keys = [ (233 - 8) ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
          { keys = [ (232 - 8) ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
          { keys = [ (235 - 8) ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -s sysfs/leds/tpacpi::kbd_backlight -U 20"; }
          { keys = [ (246 - 8) ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -s sysfs/leds/tpacpi::kbd_backlight -A 20"; }
          ];
      };

}

