#!/usr/bin/env python

import sys
import gi
import os

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

if len(sys.argv) == 2 and sys.argv[1] == "poweroff":
    text = "Power Off System"
else:
    text = "Exit Session"


dialog = Gtk.MessageDialog(
    flags=0,
    message_type=Gtk.MessageType.QUESTION,
    buttons=Gtk.ButtonsType.NONE,
    text=text,
)
dialog.format_secondary_text(
    "Exit the desktop session and close all applications."
)

if len(sys.argv) == 1:
    dialog.add_buttons(Gtk.STOCK_CANCEL, 0, "Log Out", 1, "Restart", 2, "Power Off", 3)
elif sys.argv[1] == "logout":
    dialog.add_buttons(Gtk.STOCK_CANCEL, 0, "Log Out", 1)
elif sys.argv[1] == "poweroff":
    dialog.add_buttons(Gtk.STOCK_CANCEL, 0, "Power Off", 3)

response = dialog.run()

if response == 1:
    os.system('swaymsg exit')
elif response == 2:
    os.system('systemctl reboot')
elif response == 3:
    os.system('systemctl poweroff')

dialog.destroy()