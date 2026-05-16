#!/usr/bin/env bash
case $1 in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac
out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
if echo $out | grep -q MUTED; then
    msg="MUTED"
else
    msg="$(echo $out | awk '{print int($2*100)}')%"
fi
notify-send -t 1300 -h string:x-canonical-private-synchronous:volume "Volume" $msg
