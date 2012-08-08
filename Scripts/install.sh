#!/bin/sh

plugin_path="$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins/"

echo "=== Installing ==="
mkdir -p "$plugin_path"

unzip -fo ./XComment.xcplugin.zip -d "$plugin_path"

echo "=== DONE ==="

