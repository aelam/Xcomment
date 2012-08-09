#!/bin/sh

plugin_path="$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins/"
current_dir="$PWD"

echo "=== Installing ==="
mkdir -p "$plugin_path"

echo $current_dir
unzip -fo "$current_dir/XComment.xcplugin.zip" -d "$plugin_path"

echo "=== DONE ==="

