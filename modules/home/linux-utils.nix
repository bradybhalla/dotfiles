# Linux-specific tools that aren't particularly tied to another module

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # apps and tools I use
    alacritty
    emacs-pgtk # pgtk makes it look normal on wayland
    spotify # TODO: only works on x86
    maestral # for cli
    maestral-gui # tray and daemon
    trayscale # tailscale gui

    # utility apps
    nemo # file manager
    qimgv # image viewer
    mpv # video player
    zathura # pdf viewer
  ];
}
