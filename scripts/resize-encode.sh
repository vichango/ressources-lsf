#!/bin/bash
cd ../videos

FILES=*.m4v

for f in $FILES
do
    name=$(basename "$f" ".m4v")
    echo "Processing $name file..."
    ffmpeg -i "$f" -loglevel quiet -an -filter:v scale=-1:240 -y "$name.mp4"
    mv "$f" ../videos/done/
done
