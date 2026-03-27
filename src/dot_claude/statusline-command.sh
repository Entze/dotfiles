#!/bin/bash
# Read all of stdin into a variable
input=$(cat)

# Extract fields with jq, "// 0" provides fallback for null
MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
RESETS_AT=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at')

# Build progress bar: printf -v creates a run of spaces, then
# ${var// /▓} replaces each space with a block character
BAR_WIDTH=40
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && printf -v FILL "%${FILLED}s" && BAR="${FILL// /▓}"
[ "$EMPTY" -gt 0 ] && printf -v PAD "%${EMPTY}s" && BAR="${BAR}${PAD// /░}"
BAR_COLOUR="\033[32m"
[ "$PCT" -gt 66 ] && BAR_COLOUR="\033[33m"
[ "$PCT" -gt 88 ] && BAR_COLOUR="\033[31m"
BAR_COLOUR_RESET="\033[0m"

if [ -n "$RESETS_AT" ]; then
  now=$(date +%s)
  diff=$(( RESETS_AT - now ))
  if [ "$diff" -le 0 ]; then
    REMAINING_TIME="0m"
  else
    hours=$(( diff / 3600 ))
    mins=$(( (diff % 3600) / 60 ))
    if [ "$hours" -gt 0 ]; then
      REMAINING_TIME="${hours}h${mins}m"
    else
      REMAINING_TIME="${mins}m"
    fi
  fi
fi

printf "[%s] ${BAR_COLOUR}%s %s%%${BAR_COLOUR_RESET} %s" "$MODEL" "$BAR" "$PCT" "$REMAINING_TIME"
