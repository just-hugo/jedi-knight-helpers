#!/bin/bash

set -euo pipefail
trap 'rm -rf "$temp_dir"' EXIT

steam_dir="$HOME/Library/Application Support/Steam/steamapps"
game_dir="$steam_dir/common/Star Wars Jedi Knight"
app_manifest="$steam_dir/appmanifest_32380.acf"
temp_dir="$HOME/Downloads/temp"

error_message() {
    echo "Error: $1" >&2
}

command -v curl >/dev/null || {
    error_message "curl not installed, attempting installation"
    brew install curl || error_message "Failed to install curl"
}

command -v tar >/dev/null || {
    error_message "tar not installed, attempting installation"
    brew install tar || error_message "Failed to install tar"
}

command -v osascript >/dev/null || {
    error_message "osascript not installed, attempting installation"
    brew install osascript || error_message "Failed to install osascript"
}

mkdir -p "$game_dir" || error_message "Failed to create game directory: $game_dir"
touch "$app_manifest" || error_message "Failed to create manifest file: $app_manifest"

cat << EOF > "$app_manifest"
"AppState"
{
        "AppID" "32380"
        "Universe" "1"
        "StateFlags" "1026"
        "installdir" "Star Wars Jedi Knight"
}
EOF

open -a Steam || error_message "Failed to open Steam application"

expected_size="658"

get_folder_size_in_mb() {
    du -sm "$game_dir" | cut -f1 || error_message "Failed to get folder size"
}

while [ "$(get_folder_size_in_mb)" -lt "$expected_size" ]; do
    sleep 3  
done

killall -9 steam_osx || error_message "Failed to close Steam"

current_release_tar="openDF2JK_current.tar.gz"
previous_release_tar="openDF2JK_previous.tar.gz"
launcher_orig="OpenJKDF2_universal.app"
launcher_single="OpenJKDF2_universal_single.app"
launcher_multi="OpenJKDF2_universal_multi.app"
current_release_url="https://github.com/shinyquagsire23/OpenJKDF2/releases/download/v0.9.1/macos-debug.tar.gz"
previous_release_url="https://github.com/shinyquagsire23/OpenJKDF2/releases/download/v0.9.0/macos-debug.tar.gz"

mkdir -p "$temp_dir" || error_message "Failed to create temp directory: $temp_dir"
cd "$temp_dir" || error_message "Failed to change directory to: $temp_dir"

curl -L -o "$current_release_tar" "$current_release_url" || error_message "Failed to download $current_release_tar"
curl -L -o "$previous_release_tar" "$previous_release_url" || error_message "Failed to download $previous_release_tar"

tar -xzf "$current_release_tar" -C "$game_dir" || error_message "Failed to extract $current_release_tar"
mv "$game_dir/$launcher_orig" "$game_dir/$launcher_single" || error_message "Failed to rename launcher to $launcher_single"

tar -xzf "$previous_release_tar" -C "$game_dir" || error_message "Failed to extract $previous_release_tar"
mv "$game_dir/$launcher_orig" "$game_dir/$launcher_multi" || error_message "Failed to rename launcher to $launcher_multi"

unset steam_dir game_dir app_manifest temp_dir current_release_tar previous_release_tar launcher_orig launcher_single launcher_multi current_release_url previous_release_url
