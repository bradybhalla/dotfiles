# Tailscale setup

{
  config,
  ...
}:

{
  # from https://wiki.nixos.org/wiki/Tailscale

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
