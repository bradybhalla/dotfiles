{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users."bradybhalla" = {
    isNormalUser = true;
    description = "Brady Bhalla";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # TODO split this into more modules (desktop, apps)

  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty # so there is a terminal with the default hyprland config

    alacritty
    # skimpdf # TODO broken: doesn't work on aarch64?
    emacs-pgtk # pgtk makes it look normal on wayland
    vlc
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  services.printing.enable = true;

  # Display
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-macchiato";
    settings = {
      "General" = {
        scale = 2.0;
      };
      "LockScreen" = {
        display = false;
      };
    };
  };

  # Audio
  services.pulseaudio.enable = false; # enabled by default, replaced with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Tailscale
  services.tailscale.enable = true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = false; # TODO maybe remove: may or may not be needed for vm networking, also maybe useful for tailscale?
  };
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # TODO: I added this when trying to fix some mising files but it didnt work
  # unless there is a good reason it can probably be deleted.
  programs.fuse.userAllowOther = true;
  boot.kernelModules = [ "fuse" ];
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
