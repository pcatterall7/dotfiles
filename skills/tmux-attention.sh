#!/bin/sh
# Flag (or clear) the tmux window running this Claude Code session so the
# status bar can show that it needs attention. Usage: tmux-attention.sh set|clear
[ -n "$TMUX_PANE" ] || exit 0

case "$1" in
  set)
    # Don't flag the window you're already looking at
    [ "$(tmux display -p -t "$TMUX_PANE" '#{window_active}')" = 1 ] && exit 0
    tmux set -w -t "$TMUX_PANE" @attention 1 ;;
  clear)
    tmux set -wu -t "$TMUX_PANE" @attention ;;
esac
exit 0
