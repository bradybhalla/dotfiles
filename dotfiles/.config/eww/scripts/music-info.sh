#!/usr/bin/env bash
# Streams one JSON object per metadata change for eww's `music` deflisten.

# Player priority for playerctl: follow Spotify first, then any other player.
player_priority="spotify,%any"

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/eww/album-art"
mkdir -p "$cache_dir"

url_decode() {
  # turn each %XX escape into the corresponding byte
  local s="${1//%/\\x}"
  printf '%b' "$s"
}

resolve_art() {
  local url="$1"
  case "$url" in
    file://*) url_decode "${url#file://}" ;;
    http://*|https://*)
      local f="$cache_dir/$(printf '%s' "$url" | sha256sum | cut -d' ' -f1)"
      if [ ! -s "$f" ]; then
        curl -fsSL --max-time 5 -o "$f" "$url" || { rm -f "$f"; printf ''; return; }
      fi
      printf '%s' "$f" ;;
    *) printf '' ;;
  esac
}

no_player() {
  jq -cn '{status: "None", title: "Nothing playing", artist: "", album: "", art: ""}'
}

# Closing the window when the last player quits is handled out-of-band by
# music-presence.sh (D-Bus name ownership), which mirrors waybar's mpris module
# exactly. This script only renders whatever playerctl is currently following.

no_player
# deflisten does not restart a script that exits, so restart playerctl ourselves.
while true; do
  while IFS=$'\t' read -r status title artist album arturl; do
    if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
      no_player
      continue
    fi
    art="$(resolve_art "$arturl")"
    jq -cn --arg status "$status" --arg title "$title" --arg artist "$artist" \
           --arg album "$album" --arg art "$art" \
           '{status: $status, title: $title, artist: $artist, album: $album, art: $art}'
  done < <(playerctl -p "$player_priority" --follow metadata \
    --format $'{{status}}\t{{title}}\t{{artist}}\t{{album}}\t{{mpris:artUrl}}' 2>/dev/null)
  # playerctl exited: the followed player quit without emitting a final line.
  no_player
  sleep 2
done
