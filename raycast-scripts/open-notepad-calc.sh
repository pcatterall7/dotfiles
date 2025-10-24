#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Notepad Calculator
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ➕
# @raycast.packageName notepadCalculator

# Documentation:
# @raycast.description Opens notepadcalculator.com in a new chrome tab
# @raycast.author Phil Catterall
# @raycast.authorURL https://github.com/pcatterall7

open -na "Google Chrome" --args --new-window  "https://notepadcalculator.com/"
sleep 0.3
open rectangle://execute-action?name=last-third
