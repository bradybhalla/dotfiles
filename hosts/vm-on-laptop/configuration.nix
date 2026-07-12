{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/desktop-environment.nix
    ../../modules/nixos/tailscale.nix
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

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
