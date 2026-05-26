#!/usr/bin/env bash
case $1 in
    up)
        wpctl set-volume --limit 0.25 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
if echo $VOLUME | grep -q MUTED; then
    msg="MUTED"
else
    msg="$(echo $VOLUME | awk '{print int($2*100)}')%"
fi
notify-send -t 1300 -h string:x-canonical-private-synchronous:volume "Volume" $msg
