-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons },
--      callback   = awful.client.setslave
    },
                     
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { name = "Oracle VM VirtualBox Manager" },
      properties = { floating = true } },
    { rule = { class = "Dolphin" },
      properties = { floating = false } },
    { rule = { name = "Moving" },
      properties = { floating = true } },
    { rule = { name = "Warning – Dolphin" },
      properties = { floating = true } },
    { rule = { name = "New Folder – Dolphin" },
      properties = { floating = true } },
    { rule = { name = "Delete Files - Dolphin" },
      properties = { floating = true } },
    { rule = { name = "Rename Item – Dolphin" },
      properties = { floating = true } },
    { rule = { name = "Copying" },
      properties = { floating = true } },
    { rule = { name = "Folder Already Exists" },
      properties = { floating = true } },
    { rule = { name = "File Already Exists" },
      properties = { floating = true } },
    { rule = { class = "Amarok" },
      properties = { floating = false } },

    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } },

    { rule       = { class = "Gnome-terminal" },
      properties = { size_hints_honor = false }
    },
    { rule       = { class = "URxvt" },
      properties = { size_hints_honor = false }
    },
    { rule       = { class = "Firefox", instance = "Download" },
      properties = { floating = true }
    },
    { rule       = { class = "Pidgin" },
      properties = { tag = tags[1][4] },
    },
    { rule       = { name = "irssi" },
      properties = { tag = tags[1][4] },
    },
    { rule       = { class = "Liferea" },
      properties = { tag = tags[1][3] },
    },
    { rule       = { class = "Thunderbird" },
      properties = { tag = tags[1][3] },
    },
    { rule       = { class = "Evolution" },
      properties = { tag = tags[1][3] },
    },
    { rule       = { class = "Plugin-container" },
      callback  = function (c) c.maximized_horizontal = true c.focus = true end
    },
}
-- }}}
-- vim: ts=4 sw=4 et: