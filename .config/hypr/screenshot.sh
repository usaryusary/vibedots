#!/bin/bash
LOCKFILE=/tmp/screenshot.lock

if [ -f "$LOCKFILE" ]; then
    exit 0
fi

touch "$LOCKFILE"
hyprpicker --no-fancy -r &
PICKER_PID=$!
sleep 0.2
AREA=$(slurp)
kill $PICKER_PID 2>/dev/null
if [ -n "$AREA" ]; then
    grim -g "$AREA" - | tee ~/Pictures/$(date +%Y%m%d_%H%M%S).png | wl-copy
fi
rm "$LOCKFILE"
