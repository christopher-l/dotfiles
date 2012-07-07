-- {{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,      --1
    awful.layout.suit.tile,          --2
--    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,   --3
--    awful.layout.suit.tile.top,
    awful.layout.suit.fair,          --4
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,--5
    awful.layout.suit.magnifier,     --6
    awful.layout.suit.max,           --7
--    awful.layout.suit.max.fullscreen,
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = {
        " term ",
        " web ",
        " mail ",
        " chat ",
        " 5 ",
        " 6 ",
        " 7 ",
        " 8 ",
        " 9 ",
        " 10 ",
        " F1 ",
        " F2 ",
        " F3 ",
        " F4 ",
        " F5 ",
    },
    layout = { 
        layouts[2],  --1
        layouts[2],  --2
        layouts[2],  --3
        layouts[2],  --4
        layouts[2],  --5
        layouts[2],  --6
        layouts[2],  --7
        layouts[2],  --8
        layouts[2],  --9
        layouts[2],  --10
        layouts[2],  --F1
        layouts[2],  --F2
        layouts[2],  --F3
        layouts[2],  --F4
        layouts[2],  --F5
    }
}
tags[1] = awful.tag( tags.names, 1, tags.layout)
--awful.tag.setproperty(tags[1][4], "mwfact", 0.19)
for s = 2, screen.count() do
     -- Each screen has its own tag table.
    tags[s] = awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 ",
                          " a ", " b ", " c ", " d ", " e ", " f "}, s, layouts[2])
end
-- }}}
-- vim: ts=4 sw=4 et:
