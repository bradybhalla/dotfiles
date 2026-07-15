{ config, pkgs, ... }:
{
  users.users."sydney" = {
    isNormalUser = true;
    description = "Sydney";
    extraGroups = [  ];
  };

  services.desktopManager.plasma6.enable = true;
}
