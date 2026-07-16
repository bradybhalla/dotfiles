{ config, pkgs, ... }:
{
  users.users."sydney" = {
    isNormalUser = true;
    description = "Sydney Wang";
    extraGroups = [  ];
  };

  services.desktopManager.plasma6.enable = true;
}
