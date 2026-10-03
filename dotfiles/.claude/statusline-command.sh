#!/bin/bash

input=$(cat)

# Parse fields from JSON input (\x1f-delimited so empty fields survive read)
IFS=$'\x1f' read -r cwd model used plan plan_reset_time week week_reset_date < <(echo "$input" | jq -r '
  [
    .workspace.current_dir,
    .model.display_name,
    .context_window.used_percentage,
    .rate_limits.five_hour.used_percentage,
    (.rate_limits.five_hour.resets_at | if . then strflocaltime("%-I:%M%p") | ascii_downcase else . end),
    .rate_limits.seven_day.used_percentage,
    (.rate_limits.seven_day.resets_at | if . then strflocaltime("%-m/%-d") else . end)
  ] | map(. // "") | join("\u001f")')

# Git branch (skip optional locks to avoid interference)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short -q HEAD || git -C "$cwd" rev-parse --short HEAD)
fi

# Build the status line
parts=()

# Git branch
if [ -n "$git_branch" ]; then
  parts+=("$(printf '\033[35m[%s]\033[0m' "$git_branch")")
fi

# Model
if [ -n "$model" ]; then
  parts+=("$(printf '\033[36m[%s]\033[0m' "$model")")
fi

# Context usage
if [ -n "$used" ]; then
  used_int=${used%.*}
  if [ "$used_int" -ge 80 ]; then
    color='\033[31m'  # red
  elif [ "$used_int" -ge 50 ]; then
    color='\033[33m'  # yellow
  else
    color='\033[32m'  # green
  fi
  parts+=("$(printf "${color}[%s%%]\033[0m" "$used_int")")
fi

# Plan 5-hour usage
if [ -n "$plan" ]; then
  plan_int=$(printf '%.0f' "$plan")
  parts+=("$(printf '\033[90m[%s%% until %s]\033[0m' "$plan_int" "$plan_reset_time")")
fi

# Plan 7-day usage
if [ -n "$week" ]; then
  week_int=$(printf '%.0f' "$week")
  parts+=("$(printf '\033[90m[%s%% until %s]\033[0m' "$week_int" "$week_reset_date")")
fi

printf '%s' "${parts[*]}"
