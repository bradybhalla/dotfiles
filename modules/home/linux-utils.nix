# Linux-specific tools that aren't particularly tied to another module

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # apps and tools I use
    alacritty

    # utility apps
    nemo # file manager
    qimgv # image viewer
    mpv # video player
    zathura # pdf viewer
  ];
}
