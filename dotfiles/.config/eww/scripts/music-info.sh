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

# Debounced close: playerctld emits a transient empty/Stopped line while
# switching from one player to another, immediately followed by the new
# player's Playing line. Closing on that transient line makes the widget
# disappear mid-switch, so instead schedule the close and cancel it if an
# active track arrives before the timer fires.
close_pid=""

schedule_close() {
  cancel_close
  { sleep 1; eww close music >/dev/null 2>&1; } &
  close_pid=$!
}

cancel_close() {
  if [ -n "$close_pid" ]; then
    kill "$close_pid" 2>/dev/null
    close_pid=""
  fi
}

no_player
# deflisten does not restart a script that exits, so restart playerctl ourselves.
# Process substitution (not a pipe) keeps the read loop in this shell so $prev
# survives after playerctl exits when the last player quits.
while true; do
  prev=""
  while IFS=$'\t' read -r status title artist album arturl; do
    if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
      no_player
      # Auto-close only when transitioning away from an active track, so
      # opening the widget while nothing is playing keeps it open. Debounced
      # so a player switch (empty line then Playing) does not close it.
      case "$prev" in
        Playing|Paused) schedule_close ;;
      esac
      prev="$status"
      continue
    fi
    # An active track arrived: cancel any pending close from a player switch.
    cancel_close
    art="$(resolve_art "$arturl")"
    jq -cn --arg status "$status" --arg title "$title" --arg artist "$artist" \
           --arg album "$album" --arg art "$art" \
           '{status: $status, title: $title, artist: $artist, album: $album, art: $art}'
    prev="$status"
  done < <(playerctl -p "$player_priority" --follow metadata \
    --format $'{{status}}\t{{title}}\t{{artist}}\t{{album}}\t{{mpris:artUrl}}' 2>/dev/null)
  # playerctl exited: the followed player quit without emitting a final line.
  # Close the widget (debounced) if we were showing an active track.
  no_player
  case "$prev" in
    Playing|Paused) schedule_close ;;
  esac
  sleep 2
done
