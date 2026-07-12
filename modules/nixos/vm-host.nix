# libvirt/KVM virtualization host setup (virt-manager, USB redirection)

{
  ...
}:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.users."bradybhalla".extraGroups = [ "libvirtd" ];

  # trust the libvirt NAT bridge (may or may not be needed for VM networking)
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
