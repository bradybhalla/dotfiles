{ config, pkgs, ... }:
{
  users.users."sydney" = {
    isNormalUser = true;
    description = "Sydney Wang";
    extraGroups = [  ];
    packages = with pkgs; [
      google-chrome
      spotify
    ];
  };

  services.desktopManager.plasma6.enable = true;

  programs._1password-gui.polkitPolicyOwners = [ "sydney" ];
}
