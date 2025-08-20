# vim: set ts=4 sw=4 et:

[ -n "$IS_CONTAINER" ] && return 0

TTYS=${TTYS:-12}
if [ -n "$KEYMAP" ]; then
    msg "Level 3"
    loadkeys -q -u ${KEYMAP}
fi
