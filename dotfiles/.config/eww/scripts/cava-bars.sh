#!/usr/bin/env bash
# Raw ascii cava output (0-7 per bar, ';' separated) -> unicode block string.
# sed must be unbuffered (-u) or the visualization lags in bursts.
conf="$(dirname "$(readlink -f "$0")")/../cava.conf"
exec cava -p "$conf" | \
  sed -u 's/;//g; s/0/▁/g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
