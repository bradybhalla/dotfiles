# dropbox syncing using Maestral
# First time setup:
#   maestral auth link
#
# The sync daemon is started by the system-tray applet (the `maestral_qt`
# binary from maestral-gui, NOT `maestral gui` which fails on Nix), which is
# autostarted from hypr/hyprland.lua after the tray is ready. The `maestral`
# CLI (status, stop, etc.) talks to whichever daemon is running over its IPC
# socket, so it works regardless of how the daemon was launched.
#
# We deliberately do NOT run a systemd user service for the daemon: it races
# the tray applet (both try to own the daemon) and the loser marks itself
# failed on `home-manager switch` with "Daemon is already running".

# TODO: maestral is no longer being maintained so find a replacement

{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    maestral
    maestral-gui
  ];
}
