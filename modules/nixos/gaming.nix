{
  pkgs,
  ...
}:

{
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  # gamemoded needs the user in the "gamemode" group to change the CPU
  # governor / renice game processes (the module creates the group only)
  users.users."bradybhalla".extraGroups = [ "gamemode" ];

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}
