#!/usr/bin/bash
# theo
# 05/03/2024

echo "toto"
youtube-dl -o './yt/download/%(title)s/%(title)s.mp4' --write-description $1 &> /dev/null
temp=$(find yt/download/ -name '*.description*' | cut -d'/' -f3)
mv temp


#https://www.youtube.com/watch?v=jNQXAC9IVRw