# Hammerspoon config

Symlinked to `~/.hammerspoon` via `install.conf.yaml`.

The leader key is `right-cmd + g`, remapped to `F18` by Karabiner-Elements
(`karabiner/karabiner.json`). Hammerspoon listens for `F18` and opens a modal
that hints the available sub-commands.

## Current commands

- `b` — run the Chrome bookmarks picker (`~/bin/databricks/chrome-bookmarks.py`)
- `s` — split the current window with another, 50/50 (⎇ while picking for 70/30),
  via the vendored [Split.spoon](https://github.com/evantravers/Split.spoon)
  under `Spoons/Split.spoon/`
- `r` — reload the Hammerspoon config

The `meetings` and `other` submenus are commented out in `init.lua` while the
config is being stabilized. Re-enable one at a time.

## Todo

- [ ] Have my meeting schedule update throughout the day
- [ ] Should we move new-customer-note.sh completely into hammerspoon?
## Known limitation: moving windows across Spaces

We tried adding a "summon Obsidian to this Space" command. It didn't work because
the latest macOS versions broke the space APIs hammerspoon uses.

**Future direction**: investigate
[franzbu/EnhancedSpaces.spoon](https://github.com/franzbu/EnhancedSpaces.spoon/),
which implements its own Spaces management on top of Hammerspoon and claims
to handle cross-Space window moves reliably without the broken CGS call.
