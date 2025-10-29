# Aerospace setup

Enable dragging:
defaults write -g NSWindowShouldDragOnGesture -bool true

Fix Mission Control:
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

`aerospace-center-window.sh` works around the fact that windows don't support a max width right now, so apps like Slack end up way too wide. Shortcut: shift-opt-; -> g

## TODO

- [ ] resize to 3/4 and 1/4
- [ ]
