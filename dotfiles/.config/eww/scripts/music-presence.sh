#!/usr/bin/env bash
# Runs as a deflisten from eww while the music window is open. Watches D-Bus
# for MPRIS players joining/leaving the bus and closes the window on the
# falling edge to zero real players (mirrors waybar's mpris module).

count_players() { playerctl -l 2>/dev/null | grep -c .; }

prev=$(count_players)

dbus-monitor --session \
  "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0namespace='org.mpris.MediaPlayer2'" \
  2>/dev/null | while read -r line; do
    case "$line" in signal*) ;; *) continue ;; esac
    now=$(count_players)
    if [ "$prev" -gt 0 ] && [ "$now" -eq 0 ]; then
      eww close music >/dev/null 2>&1
    fi
    prev=$now
  done
