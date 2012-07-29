-- {{{ Wibox

-- Reusable separator
separator = widget({ type = "textbox" })
separator.text = " | "

space_s = widget({ type = "textbox" })
space_s.text = " "

-- Date
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, '%a %b %d <span weight="bold">%R</span> ')

-- Battery state
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, 
function (widget, args)
    string = args[1] .. args[2] .. ' ' .. args[3]
    if     args[2] <= 10 then return '<span font="bold" color="red">' .. string .. '</span>'
    elseif args[2] <= 30 then return '<span font="bold" color="orange">' .. string .. '</span>'
    elseif args[2] <= 50 then return '<span color="yellow">' .. string .. '</span>'
    else   return string
    end
end, 2, "BAT0")

-- CPU
--cpufreq = widget({ type = "textbox" })
--vicious.register(cpufreq, vicious.widgets.cpufreq, "$2", 10, "cpu0")

-- Load
--loadwidget = widget({ type = "textbox" })
--vicious.register(loadwidget, vicious.widgets.uptime, "$4 $5 $6")

-- Wifi
wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi,
function (widget, args)
  if     args["{ssid}"] == "N/A" then return 'no wifi'
  elseif args["{rate}"] <= 1 then return args["{ssid}"]..' '.. args["{sign}"]..'dBm connecting'
  else return args["{ssid}"]..' '.. args["{sign}"]..'dBm'
  end
end, 2, "wlan0")

-- PKG
--pkgwidget = widget({ type = "textbox" })
--vicious.register(pkgwidget, vicious.widgets.pkg, "$1", 600, "Arch")

-- Volume
volumewidget = widget({ type = "textbox"})
vicious.register(volumewidget, vicious.widgets.volume, "$1 $2", 2, "Master")
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end),
    awful.button({ }, 4, function ()
        awful.util.spawn("pactl -- set-sink-volume 0 +2%")
        vicious.force({ volumewidget, }) end),
    awful.button({ }, 5, function ()
        awful.util.spawn("pactl -- set-sink-volume 0 -2%")
        vicious.force({ volumewidget, }) end)
))

-- Create a textclock widget
--mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 2, function (c)
                                              c:kill()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)


    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "12", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylayoutbox[s],
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        datewidget,
        separator,
        batwidget,
        separator,
        wifiwidget,
        separator,
        volumewidget,
        --separator,
        --loadwidget,
        space_s,
        s == 1 and mysystray or nil,
        space_s,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
-- vim: ts=4 sw=4 et:
