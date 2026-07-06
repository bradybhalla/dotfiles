#!/bin/bash

input=$(cat)

# Parse fields from JSON input
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
plan=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
plan_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // .rate_limits.weekly.used_percentage // empty')
week_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // .rate_limits.weekly.resets_at // empty')

# Git branch (skip optional locks to avoid interference)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
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
  if [ "$used_int" -ge 80 ] 2>/dev/null; then
    color='\033[31m'  # red
  elif [ "$used_int" -ge 50 ] 2>/dev/null; then
    color='\033[33m'  # yellow
  else
    color='\033[32m'  # green
  fi
  parts+=("$(printf "${color}[%s%%]\033[0m" "$used_int")")
fi

# Plan 5-hour usage
if [ -n "$plan" ]; then
  plan_int=$(printf '%.0f' "$plan")
  plan_reset_time=$(perl -e 'my @t=localtime($ARGV[0]); my $h=$t[2]%12; $h=12 if $h==0; printf("%d:%02d%s", $h, $t[1], $t[2]<12?"am":"pm")' "$plan_resets_at" 2>/dev/null)
  parts+=("$(printf '\033[90m[%s%% until %s]\033[0m' "$plan_int" "$plan_reset_time")")
fi

# Plan 7-day usage
if [ -n "$week" ]; then
  week_int=$(printf '%.0f' "$week")
  week_reset_date=$(perl -e 'my @t=localtime($ARGV[0]); printf("%d/%d", $t[4]+1, $t[3])' "$week_resets_at" 2>/dev/null)
  parts+=("$(printf '\033[90m[%s%% until %s]\033[0m' "$week_int" "$week_reset_date")")
fi

printf '%s' "${parts[*]}"
