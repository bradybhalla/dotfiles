#!/usr/bin/env bash

on_icon="󰖔"
off_icon=""

temp="$(hyprctl hyprsunset temperature)"

case "$1" in
  toggle)
    if [ "$temp" != 6000 ]; then
      hyprctl hyprsunset temperature 6000
    else
      hyprctl hyprsunset temperature 3600
    fi
    ;;
  *)
    if [ "$temp" != 6000 ]; then
      printf '{"text":"%s", "class": "night-mode", "tooltip": "Night mode on"}\n' "$on_icon"
    else
      printf '{"text":"%s", "class": "day-mode", "tooltip": "Night mode off"}\n' "$off_icon"
    fi
    ;;
esac
