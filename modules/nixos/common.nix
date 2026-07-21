# base NixOS system config shared across all hosts: boot, locale, users,
# networking, audio, and other core services

{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  hardware.enableRedistributableFirmware = true;

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

  users.users."brady" = {
    isNormalUser = true;
    description = "Brady Bhalla";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.openssh = {
    enable = true;
    openFirewall = true;
    # require public key authentication
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users."brady".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4V4YF2edOtQEMfL7kC3Zvkro8wwSUPjiKz5F8wOrfy brady@brady-macbook-pro"
  ];

  services.printing.enable = true;
  services.udisks2.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.gnupg.agent.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    python3
    kitty # so there is a terminal with the default hyprland config
  ];

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

  # TODO: this fixes xdg portal service error I was getting. idk if all of this is actually needed.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  security.wrappers.fusermount3 = {
    source = "${pkgs.fuse3}/bin/fusermount3";
    owner = "root";
    group = "root";
    setuid = true;
  };
}
