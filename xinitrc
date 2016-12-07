#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

setxkbmap us altgr-intl

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset r rate 250 30
xset -b  # disable bell

xsetroot -cursor_name left_ptr
python $HOME/bin/systemd-lock-handler.py \
    i3lock -i $HOME/.config/i3/lockbg.png -n &

export DE="kde"
export KDE_FULL_SESSION=true
export KDE_SESSION_VERSION="5"

export MOZ_USE_XINPUT2=1

exec i3
