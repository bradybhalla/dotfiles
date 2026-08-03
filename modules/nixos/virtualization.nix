# Virtualization: libvirt/KVM host (virt-manager, USB redirection) and Docker
# TODO: test that this actually works

{
  pkgs,
  ...
}:

{
  users.users."brady".extraGroups = [
    "libvirtd"
    "docker"
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # trust the libvirt NAT bridge (may or may not be needed for VM networking)
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
