#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate UUID
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🫆
# @raycast.packageName uuid

# Documentation:
# @raycast.description Generates a UUID and copies it to the clickboard
# @raycast.author Phil Catterall
# @raycast.authorURL https://github.com/pcatterall7

UUID=`uuidgen | tr '[:upper:]' '[:lower:]'`
echo $UUID | pbcopy
echo "$UUID copied"
