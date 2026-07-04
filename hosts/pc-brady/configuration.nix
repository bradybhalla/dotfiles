{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/nixos/common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "brady-pc";

  # NVIDIA
  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.users."bradybhalla".extraGroups = [ "libvirtd" ];
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Ollama with CUDA
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    mangohud
    protonup-qt
  ];

  system.stateVersion = "26.11";
}
