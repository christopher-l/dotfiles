#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
    read line
    backlight=$(xbacklight -get | cut -d . -f 1)
    dat="[{ \"full_text\": \"BKL ${backlight}%\" },"
    echo "${line/[/$dat}" || exit 1
done
