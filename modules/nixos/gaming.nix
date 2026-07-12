# Steam/Proton gaming setup: gamemode, mangohud, protonup-qt

{
  pkgs,
  ...
}:

{
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  users.users."bradybhalla".extraGroups = [ "gamemode" ];

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}
