#!/usr/bin/env bash

on_icon="󰖔<span font-size='5pt'> </span>"
off_icon="<span font-size='9pt'> </span>"

# hyprsunset.conf schedules 6000 (day, hyprsunset's built-in default) / 3600
# (night), so treat anything below 5000 as night regardless of which side set it
is_night() {
  temp="$(hyprctl hyprsunset temperature)"
  [ "$temp" -lt 5000 ]
}

status() {
  if is_night; then
    printf '{"text":"%s", "class": "night-mode", "tooltip": "Night mode on"}\n' "$on_icon"
  else
    printf '{"text":"%s", "class": "day-mode", "tooltip": "Night mode off"}\n' "$off_icon"
  fi
}

case "$1" in
  toggle)
    if is_night; then
      hyprctl hyprsunset temperature 6000
    else
      hyprctl hyprsunset temperature 3600
    fi
    pkill -RTMIN+8 waybar
    ;;
  *)
    status
    ;;
esac
