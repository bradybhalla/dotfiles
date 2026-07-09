#!/usr/bin/env bash

# TODO: review rewrite (added watch mode for waybar, day temp 6000 -> 6500,
# night mode = anything below 5000)
# TODO: is day mode actually 6500?

on_icon="󰖔"
off_icon=""

# hyprsunset.conf schedules 6500 (day) / 3600 (night), so treat anything
# below 5000 as night regardless of which side set it
is_night() {
  temp="$(hyprctl hyprsunset temperature 2>/dev/null)"
  [ "$temp" -lt 5000 ] 2>/dev/null
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
      hyprctl hyprsunset temperature 6500
    else
      hyprctl hyprsunset temperature 3600
    fi
    ;;
  watch)
    # persistent waybar exec: emit a line only when the state changes, so
    # both manual toggles and scheduled transitions show up within a second
    last=""
    while true; do
      current="$(status)"
      if [ "$current" != "$last" ]; then
        echo "$current"
        last="$current"
      fi
      sleep 1
    done
    ;;
  *)
    status
    ;;
esac
