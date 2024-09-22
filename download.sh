#!/bin/bash
set -x +eo pipefail

mkdir -p music
cd music
yt-dlp 'https://www.youtube.com/playlist?list=PLxaqr-SrpBDjWQJeiZZjFP0HLN2c0kC1M' --embed-thumbnail -f bestaudio -x --audio-format mp3 --add-metadata -N 5 --download-archive ../download-lists/downloaded-songs-list.txt --output "%(title)s - %(uploader)s.%(ext)s"
yt-dlp 'https://www.youtube.com/playlist?list=PLxaqr-SrpBDj1faQ663Ov1P817RA4uvCx' --embed-thumbnail -f bestaudio -x --audio-format mp3 --add-metadata -N 5 --download-archive ../download-lists/downloaded-songs-mnm-list.txt --output "%(title)s - %(uploader)s.%(ext)s"
cd ..

mkdir -p samples
cd samples
yt-dlp 'https://www.youtube.com/playlist?list=PLxaqr-SrpBDh4dnqwDire46kY1vAnDODK' --embed-thumbnail -f bestaudio -x --audio-format mp3 --add-metadata -N 5 --download-archive ../download-lists/downloaded-samples-list.txt --output "%(title)s - %(uploader)s.%(ext)s"
cd ..
