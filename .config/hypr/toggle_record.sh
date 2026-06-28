#!/bin/bash
PIDFILE=/tmp/gpu_recorder.pid
VIDEODIR="$HOME/Videos"

if [ -f "$PIDFILE" ]; then
    kill -INT $(cat "$PIDFILE")
    rm "$PIDFILE"
else
    mkdir -p "$VIDEODIR"
    N=1
    while [ -f "$VIDEODIR/$N.mp4" ]; do ((N++)); done
    gpu-screen-recorder -w screen -f 144 -k h264 -encoder gpu -low-power yes -o "$VIDEODIR/$N.mp4" &
    echo $! > "$PIDFILE"
fi
