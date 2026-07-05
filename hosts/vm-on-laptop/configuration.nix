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

  networking.hostName = "nixos-vm-on-laptop";

  # VM-specific graphics
  hardware.graphics.enable = true;
  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1"; # alacritty was not showing up correctly

  # QEMU/SPICE guest support
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Firewall additions
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.allowedTCPPorts = [
    17500 # dropbox
  ];
  networking.firewall.allowedUDPPorts = [
    17500 # dropbox
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  system.stateVersion = "26.05";
}
