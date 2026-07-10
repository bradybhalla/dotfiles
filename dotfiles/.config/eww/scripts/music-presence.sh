#!/usr/bin/env bash
# Closes the eww `music` window at the exact moment waybar's mpris module hides.
#
# With a "stopped" icon defined, waybar shows the mpris module whenever any real
# MPRIS player owns a bus name (playing/paused/stopped) and hides only when the
# last one disappears. We mirror that by watching D-Bus name ownership for
# `org.mpris.MediaPlayer2.*` and closing when the real-player count hits zero.
#
# `playerctl -l` already excludes playerctld's always-present proxy name, so a
# player *switch* (one player quits while another keeps playing) never drops the
# count to zero -- no debounce/timeout needed, unlike playerctld's aggregated
# --follow stream which emits a transient Stopped mid-switch.
#
# Run as a `deflisten` from eww.yuck: eww starts it when the music window opens
# and kills it (and the dbus-monitor child) on close, so it lives exactly as
# long as the window it might close. It emits no value.

count_players() { playerctl -l 2>/dev/null | grep -c .; }

prev=$(count_players)

# arg0namespace makes the bus deliver only MPRIS NameOwnerChanged signals, so we
# aren't woken for every unrelated name change. One recompute per signal.
dbus-monitor --session \
  "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0namespace='org.mpris.MediaPlayer2'" \
  2>/dev/null | while read -r line; do
    case "$line" in signal*) ;; *) continue ;; esac
    now=$(count_players)
    # Close only on the transition to zero players, so opening the widget while
    # nothing is playing leaves it open until a player appears and then quits.
    if [ "$prev" -gt 0 ] && [ "$now" -eq 0 ]; then
      eww close music >/dev/null 2>&1
    fi
    prev=$now
  done
