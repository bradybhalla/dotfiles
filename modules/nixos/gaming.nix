# Steam/Proton gaming setup: gamemode, mangohud, protonup-qt

{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Add every normal user to the gamemode group
  users.groups.gamemode.members =
    lib.attrNames (lib.filterAttrs (_: u: u.isNormalUser) config.users.users);

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}
