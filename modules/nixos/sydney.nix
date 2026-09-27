{ config, pkgs, ... }:
{
  users.users."sydney" = {
    isNormalUser = true;
    description = "Sydney Wang";
    extraGroups = [  ];
  };

  services.desktopManager.plasma6.enable = true;

  programs._1password-gui.polkitPolicyOwners = [ "sydney" ];

  # Flatpak for Discover, with Flathub added only as a user remote for sydney
  services.flatpak.enable = true;
  systemd.user.services.flatpak-add-flathub = {
    wantedBy = [ "default.target" ];
    unitConfig.ConditionUser = "sydney";
    path = [ pkgs.flatpak ];
    serviceConfig.Type = "oneshot";
    script = ''
      flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
