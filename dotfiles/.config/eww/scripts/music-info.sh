#!/usr/bin/env bash
# Streams one JSON object per metadata change for eww's `music` deflisten.
# Firefox players are ignored entirely (video audio shouldn't take over the widget).

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

# Close the eww popup (no-op if it is already closed).
close_widget() {
  eww close music >/dev/null 2>&1
}

no_player
# deflisten does not restart a script that exits, so restart playerctl ourselves
while true; do
  prev=""
  playerctl --ignore-player=firefox --follow metadata \
    --format $'{{status}}\t{{title}}\t{{artist}}\t{{album}}\t{{mpris:artUrl}}' 2>/dev/null |
  while IFS=$'\t' read -r status title artist album arturl; do
    if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
      no_player
      # Auto-close only when transitioning away from an active track, so
      # opening the widget while nothing is playing keeps it open.
      case "$prev" in
        Playing|Paused) close_widget ;;
      esac
      prev="$status"
      continue
    fi
    art="$(resolve_art "$arturl")"
    jq -cn --arg status "$status" --arg title "$title" --arg artist "$artist" \
           --arg album "$album" --arg art "$art" \
           '{status: $status, title: $title, artist: $artist, album: $album, art: $art}'
    prev="$status"
  done
  no_player
  sleep 2
done
