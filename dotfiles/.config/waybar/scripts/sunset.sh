#!/usr/bin/env bash
# Toggle hyprsunset night light. Click once -> 4500K, click again -> identity.

state_file="${XDG_RUNTIME_DIR:-/tmp}/hyprsunset.state"

on_icon="󰖔"   # night (warm active)
off_icon="󰖙"  # sunny (normal)

is_on() { [ -f "$state_file" ]; }

case "$1" in
  toggle)
    if is_on; then
      hyprctl hyprsunset identity
      rm -f "$state_file"
    else
      hyprctl hyprsunset temperature 4500
      touch "$state_file"
    fi
    # Tell waybar to refresh this module
    pkill -RTMIN+8 waybar 2>/dev/null
    ;;
  *)
    if is_on; then
      printf '{"text":"%s","class":"on","tooltip":"Night light on (4500K)"}\n' "$on_icon"
    else
      printf '{"text":"%s","class":"off","tooltip":"Night light off"}\n' "$off_icon"
    fi
    ;;
esac
