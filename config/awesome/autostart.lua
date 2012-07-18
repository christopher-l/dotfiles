function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end


--awful.util.spawn_with_shell("sleep 5 && xsetroot -cursor_name left_ptr")
awful.util.spawn_with_shell("xset r rate 250 30")
-- "/etc/X11/xorg.conf.d/10-synaptics.conf"
--awful.util.spawn_with_shell("synclient TouchpadOff=1")
--awful.util.spawn_with_shell("synclient HorizTwoFingerScroll=1")

awful.util.spawn_with_shell("xmodmap $HOME/.Xmodmap")


run_once("pidgin")
run_once("urxvt -T irssi -pe -tabbed -e irssi")
run_once("dropboxd")
run_once("syndaemon -t -k -i 1 -d")
--run_once("nm-applet")
-- vim: ts=4 sw=4 et:
