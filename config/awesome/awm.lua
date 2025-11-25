package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local fs = require("gears.filesystem")
local serpent = require("serpent")
local path = fs.get_cache_dir() .. 'persistent_state.lua'

local awm = {}

awm.match = function(prop, val, clients)
  local res = {}

  if not clients then
    clients = client.get()
  end

  for _, c in ipairs(clients) do
    if c[prop] == val then
      table.insert(res, c)
    end
  end

  return res
end

awm.find = function(...)
  local args = { ... }
  local clients = nil

  for i, arg in ipairs(args) do
    if i % 2 == 1 then
      goto continue
    end
    clients = awm.match(args[i-1], arg, clients)
    ::continue::
  end

  if clients and clients[1] then
    return clients[1]
  end

  return nil
end

awm.view = function(window)
  local c = awm.find('window', window)
end

awm.list = function()
  local res = '\n'
  local sep = '\x01'
  local fmt = '%s' .. sep .. '%d' .. sep .. '%d' .. sep .. '%s' .. sep .. '%s'
    .. sep .. '%s' .. sep .. '[%s]' .. '\n'

  for _, c in ipairs(client.get()) do
    res = res .. string.format(fmt,
      string.format('0x%08x', c.window or -1),
      c.pid or -1,
      c.initag or -1,
      c.profile,
      c.class,
      c.instance,
      c.name
    )
  end
  return res
end

awm.setprops = function(props, ...)
  local args = { ... }

  local c = awm.find(table.unpack(args))

  for k, v in pairs(props) do
    c[k] = v
  end
end

awm.getprops = function(props, ...)
  local args = { ... }

  local res = '\n'

  local c = awm.find(table.unpack(args))

  for _, v in ipairs(props) do
    local fmt
    if c and type(c[v]) == string then
      fmt = '%s: "%s"\n'
    else
      fmt = '%s: %s\n'
    end
    res = res .. string.format(fmt, v, tostring(c[v] or nil))
  end

  return res
end

local raise = function(c)
  if c then
    c.hidden = false
    c.minimized = false
    c:raise()
    if not (c.above and c.sticky) then
      c.first_tag:view_only()
    end
    client.focus = c
    return c.pid
  end

  return false
end

awm.raise = function(...)
  local args = { ... }

  local c = awm.find(table.unpack(args))

  raise(c)
end

awm.spawn = function(mode, cmd, ...)
  local args = { ... }
  local attrs = {}

  for i, arg in ipairs(args) do
    if i % 2 == 0 then
      attrs[args[i-1]] = arg
    end
  end

  local c = awm.find(table.unpack(args))

  if c then
    if mode == 'fg' then
      return raise(c)
    else
      return c.pid
    end
  end

  local pid = awful.spawn(cmd)

  if pid and type(pid) == 'number' then
    _G.attrs = _G.attrs or {}
    _G.modes = _G.modes or {}
    _G.attrs[pid] = attrs
    _G.modes[pid] = mode
    return pid
  end

  return false
end

awm.fg = function(cmd, ...)
  local args = { ... }
  return awm.spawn('fg', cmd, table.unpack(args))
end

awm.bg = function(cmd, ...)
  local args = { ... }
  return awm.spawn('bg', cmd, table.unpack(args))
end

awm.load = function()
  local data

  if fs.file_readable(path) then
    data = assert(loadfile(path))()
  end

  if not data then return end

  _G.attrs = data.attrs or {}
  _G.modes = data.modes or {}

  local state = data.state or nil

  if not state then return end

  for _, entry in ipairs(state.screens) do
    local s = screen[entry.screen]
    if s then
      if entry.tag and s.tags[entry.tag] then
        s.tags[entry.tag]:view_only()
      end

      -- restore tag layout
      if entry.layout then
        for _, l in ipairs(awful.layout.layouts) do
          if awful.layout.getname(l) == entry.layout then
            awful.layout.set(l, s.tags[entry.tag])
            break
          end
        end
      end
    end
  end

  -- restore screen
  local focused = state.focused or nil

  if focused and screen[focused] then
    -- awful.screen.focus(screen[focused])
    gears.timer.delayed_call(function()
      awful.screen.focus(screen[focused])
    end)
  end

  -- os.remove(path)
end

awm.save = function()
  local data = {
    attrs = _G.attrs,
    modes = _G.modes,
  }

  data.state = {}

  data.state.focused = awful.screen.focused().index

  data.state.screens = {}

  for s in screen do
    local sel = s.selected_tag
    local layout = awful.layout.get(s)

    table.insert(data.state.screens, {
      screen = s.index,
      tag = sel and sel.index or nil,
      layout = layout and awful.layout.getname(layout) or nil,
    })
  end

  local f = io.open(path, "w+")

  f:write(serpent.dump(data))
  f:close()
end

return awm
