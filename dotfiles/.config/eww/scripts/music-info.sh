#!/usr/bin/env bash
# Streams one JSON object per metadata change for eww's `music` deflisten.

# Player priority for playerctl: follow Spotify first, then any other player.
player_priority="spotify,%any"

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/eww/album-art"
mkdir -p "$cache_dir"
find "$cache_dir" -type f -mtime +30 -delete

resolve_art() {
  local url="$1"
  case "$url" in
    file://*) printf '%s' "${url#file://}" ;;
    http://*|https://*)
      # GTK CSS can't load remote URLs, so download to a local cache
      local f="$cache_dir/$(printf '%s' "$url" | sha256sum | cut -d' ' -f1)"
      if [ ! -s "$f" ]; then
        curl -fsSL --max-time 5 -o "$f" "$url" || { rm -f "$f"; return; }
      fi
      printf '%s' "$f" ;;
  esac
}

no_player() {
  jq -cn '{title: "Nothing playing", artist: "", album: "", art: ""}'
}

no_player
while IFS=$'\x1f' read -r status title artist album arturl; do
  if [ -z "$status" ]; then
    # followed player quit; close the window if it was the last one
    no_player
    [ -z "$(playerctl -l)" ] && eww close music
    continue
  fi
  if [ "$status" = "Stopped" ]; then
    no_player
    continue
  fi
  art="$(resolve_art "$arturl")"
  jq -cn --arg title "$title" --arg artist "$artist" --arg album "$album" --arg art "$art" \
         '{title: $title, artist: $artist, album: $album, art: $art}'
done < <(playerctl -p "$player_priority" --follow metadata \
  --format $'{{status}}\x1f{{title}}\x1f{{artist}}\x1f{{album}}\x1f{{mpris:artUrl}}')
