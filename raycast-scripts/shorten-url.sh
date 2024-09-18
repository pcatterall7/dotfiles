#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shorten URL
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 🔗
# @raycast.needsConfirmation false
# @raycast.argument1 {"type": "text", "placeholder": "URL"}
#
# Documentation:
# @raycast.description Shortens the provided url using is.gd
# @raycast.author Phil Catterall
# @raycast.authorURL https://github.com/pcatterall7

shorturl=$(curl "https://is.gd/create.php?format=simple&url=$1")

echo $shorturl | pbcopy
echo $shorturl
