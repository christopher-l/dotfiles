#!/usr/bin/bash

# export XKB_DEFAULT_LAYOUT=us
# export XKB_DEFAULT_VARIANT=altgr-intl
# export XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle,
export WLC_REPEAT_DELAY=250
export WLC_REPEAT_RATE=30
export SWAY_CURSOR_THEME=Adwaita

export MOZ_USE_XINPUT2=1

ibus-daemon -drx

sway
