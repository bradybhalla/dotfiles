#!/usr/bin/env bash
song="$(playerctl --ignore-player=firefox metadata --format '{{artist}} - {{title}}' 2>/dev/null)"
jq -cn --arg tooltip "${song:-Nothing playing}" '{text: "", tooltip: $tooltip}'
