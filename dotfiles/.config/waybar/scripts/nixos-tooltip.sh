#!/usr/bin/env bash
tooltip="$(whoami)@$(hostname)
<i>$(uptime -p)</i>"
jq -cn --arg tooltip "$tooltip" '{text: "", tooltip: $tooltip}'
