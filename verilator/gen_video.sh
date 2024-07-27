#!/bin/bash

make

mkdir -p frames/
rm -f frames/*

timeout ${1:-20} ./obj_dir/VTop
ffmpeg -y -framerate 60 -pattern_type glob -i 'frames/*.bmp' -f s8 -ar 48k -i audio.raw -map 0:v:0 -map 1:a:0  -c:v libx264 -pix_fmt yuv420p -af 'lowpass=5000' -c:a aac out.mp4
