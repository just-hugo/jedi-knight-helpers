#!/bin/bash

# update graphics

# Exit on any error, treat unset variables as errors, fail on errors in pipes
set -euo pipefail
trap 'rm -rf "$temp_dir"' EXIT

temp_dir="$HOME/Downloads/temp"

error_message() {
    echo "Error: $1" >&2
}

command -v 7z >/dev/null || {
    error_message "p7zip not installed, attempting installation"
    brew install p7zip || error_message "Failed to install p7zip"
}

game_dir=~/Library/Application\ Support/Steam/steamapps/common/Star\ Wars\ Jedi\ Knight

# install emjk
mkdir -p ~/Downloads/temp/EMJK
curl -L -o ~/Downloads/temp/EMJK/EMJKv1.7z https://www.moddb.com/downloads/mirror/176347/136/9c0928a439bbb4536697333d1ab0dc33/?referer=https%3A%2F%2Fwww.moddb.com%2Fmods%2Ftodoa%2Fdownloads%2Femjk
cd ~/Downloads/temp/EMJK
7z x EMJKv1.7z
mv ~/Downloads/temp/EMJK/jkgm "$game_dir"
mv ~/Downloads/temp/EMJK/Episode/JK1 "$game_dir"/Episode
mv ~/Downloads/temp/EMJK/Resource/EnhancementMod.gob "$game_dir"/Resource

# install jknup
mkdir -p ~/Downloads/temp/jknup
curl -L -o ~/Downloads/temp/jknup/jknup.zip https://www.moddb.com/downloads/mirror/176243/130/d14b501c75059ab556221ea0247bb250/?referer=https%3A%2F%2Fwww.moddb.com%2Fmods%2Fjedi-knight-neural-upscale-texture-pack
unzip ~/Downloads/temp/jknup/jknup.zip -d "$game_dir"/jkgm/materials

curl -L -o ~/Downloads/temp/jknup_fx/jknup_fx.zip https://www.moddb.com/downloads/mirror/177460/122/626236f28fe487a67981be7ee4616c54/?referer=https%3A%2F%2Fwww.moddb.com%2Fmods%2Fjedi-knight-neural-upscale-texture-pack
unzip ~/Downloads/temp/jknup_fx/jknup_fx.zip -d ~/Downloads/temp/jknup_fx
