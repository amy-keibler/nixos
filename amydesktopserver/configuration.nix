{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "amy_desktop_server"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/New_York";

  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  networking.enableIPv6 = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };

      plasma6.enable = true;
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages : [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
    };
  };
  services.displayManager.defaultSession = "xfce+xmonad";

  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.hplip
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.amy = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/PY5G1vwrxu4agNvVaDixP6KlOGACxyaKwHjoZUfys jane@jane_laptop"
    ];
  };

  users.groups.media = { };

  environment.systemPackages = with pkgs; [
    audacity
    calibre
    discord
    du-dust
    emacs
    feh
    ffmpeg
    firefox
    gimp
    git
    git-lfs
    htop
    inkscape
    ispell
    ncdu
    obsidian
    pydf
    ripgrep
    shutter
    signal-desktop
    slack
    vim
    vlc
    wget
    zoom-us
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    source-code-pro
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    
    # Required for having multiple DEs installed
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  programs.bash.promptInit = ''
    eval "$(starship init bash)"
  '';

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  networking.firewall.enable = false;

  services.avahi = {
    enable = true;
    nssmdns4 = true;

    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };

  };

  services.tailscale.enable = true;
  services.jellyfin = {
    enable = true;
    group = "media";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
