#!/usr/bin/env bash
# Toggle hyprsunset night light based on the current temperature.
# `hyprctl hyprsunset temperature` echoes back the last set value: 6000
# (neutral default) or 4500 (warm). `identity` is avoided because the getter
# doesn't reflect it, so we set 6000 to turn the night light "off".

on_icon="󰖔"   # night (warm active)
off_icon=""  # sunny (normal)

temp="$(hyprctl hyprsunset temperature)"

case "$1" in
  toggle)
    if [ "$temp" != 6000 ]; then
      hyprctl hyprsunset temperature 6000
    else
      hyprctl hyprsunset temperature 4500
    fi
    ;;
  *)
    if [ "$temp" != 6000 ]; then
      printf '{"text":"%s"}\n' "$on_icon"
    else
      printf '{"text":"%s"}\n' "$off_icon"
    fi
    ;;
esac
