#!/usr/bin/env bash

icon=""

user="$(whoami)"

os="$( ( . /etc/os-release 2>/dev/null && printf '%s' "$PRETTY_NAME" ) )"
[ -z "$os" ] && os="$(nixos-version 2>/dev/null)"

cpu="$(awk -F: '/model name/{print $2; exit}' /proc/cpuinfo | sed 's/^[[:space:]]*//')"
[ -z "$cpu" ] && cpu="$(lscpu 2>/dev/null | awk -F: '/Model name/{print $2; exit}' | sed 's/^[[:space:]]*//')"
[ -z "$cpu" ] && cpu="Unknown"

mem_kb="$(awk '/MemTotal/{print $2; exit}' /proc/meminfo)"
mem="$(awk -v k="$mem_kb" 'BEGIN{printf "%.1f GB", k/1024/1024}')"

storage="$(df -h --total 2>/dev/null | awk '/^total/{print $2; exit}')"
[ -z "$storage" ] && storage="$(df -h / 2>/dev/null | awk 'NR==2{print $2}')"

gpu="$(lspci 2>/dev/null | grep -Ei 'vga|3d controller|display controller' | head -1 | sed 's/^.*: //')"
[ -z "$gpu" ] && gpu="Unknown"

# Escape for JSON (\, ") and Pango markup (&, <, >)
esc() {
  printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
}

tooltip="<b>User:</b> $(esc "$user")\n"
tooltip+="<b>OS:</b> $(esc "$os")\n"
tooltip+="<b>CPU:</b> $(esc "$cpu")\n"
tooltip+="<b>Memory:</b> $(esc "$mem")\n"
tooltip+="<b>Storage:</b> $(esc "$storage")\n"
tooltip+="<b>GPU:</b> $(esc "$gpu")"

printf '{"text":"%s","tooltip":"%s"}\n' "$icon" "$tooltip"
