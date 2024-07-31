local awful = require('awful')
local wibox = require('wibox')
--dbus = nil
local naughty = require('naughty')
local theme = require('beautiful')

local commands = {}

commands.focus_up = function()
    awful.client.focus.bydirection("up")
end

commands.focus_down = function()
    awful.client.focus.bydirection("down")
end

commands.focus_left = function()
    awful.client.focus.bydirection("left")
end

commands.focus_right = function()
    awful.client.focus.bydirection("right")
end

commands.next_client = function()
    awful.client.focus.byidx(1)
end

commands.prev_client = function()
    awful.client.focus.byidx(-1)
end

commands.unminimize = function()
    local c = awful.client.restore()
    if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
end

commands.swap_up = nil
commands.swap_down = nil
commands.swap_left = nil
commands.swap_right = nil

commands.resize_up = nil
commands.resize_down = nil
commands.resize_left = nil
commands.resize_right = nil

commands.layout = function()
  awful.layout.inc(1)
end


commands.gototag = function(tagnum)
  return function()
    local screen = awful.screen.focused()
    local tag = screen.tags[tagnum]
    if tag then tag:view_only() end

  end
end

commands.movetotag = function(tagnum)
  return function()
    if client.focus then
      local tag = client.focus.screen.tags[tagnum]
      if tag then client.focus:move_to_tag(tag) end
    end
  end
end

commands.toggletag = function(tagnum)
  return function()
    local screen = awful.screen.focused()
    local tag = screen.tags[tagnum]
    if tag then awful.tag.viewtoggle(tag) end
  end
end

commands.kill_alerts = function()
    naughty.destroy_all_notifications()
end

commands.vtswitch = function(i)
    return function()
        awful.spawn.with_shell('sudo chvt ' .. tostring(i))
    end
end

commands.fullscreen = function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end

commands.minimize = function(c)
    c.minimized = true
end

commands.maximize = function(c)
    c.maximized = not c.maximized
    c:raise()
end

commands.close = function(c)
    if c.instance == 'discord' then
        awful.spawn.with_shell('killall -9 Discord')
    end
    c:kill()
end

return commands
