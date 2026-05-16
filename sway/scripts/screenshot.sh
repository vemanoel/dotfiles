#!/usr/bin/env bash
outdir=$HOME/Pictures/screenshots
mkdir -p $outdir
filepath=$outdir/$(date +%Y%m%d_%H%M%S).png
if [ $1 = "area" ]; then
    area=$(slurp) || exit 0
    grim -g "$area" $filepath
else
    grim $filepath
fi
notify-send -t 2000 "Screenshot Saved" $filepath
