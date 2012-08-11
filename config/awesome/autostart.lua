function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end


awful.util.spawn_with_shell("synclient TouchpadOff=1")

run_once("pidgin")
--run_once("dropboxd")
--run_once("syndaemon -t -k -i 1 -d")

-- vim: ts=4 sw=4 et:
