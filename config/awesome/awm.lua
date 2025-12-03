package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local fs = require("gears.filesystem")
local serpent = require("serpent")
local path = fs.get_cache_dir() .. 'persistent_state.lua'
-- local widgets = require("widgets")

local home = os.getenv("HOME")
local lockdir = home .. '/.lockdir'

local awm = {}

awm.parse = function(args)
  local attrs = {}
  local props = {}
  local keys = {}

  local sep = false

  for i, arg in ipairs(args) do
    if arg == '--' then
      sep = true
    elseif not sep then
      if i % 2 == 0 then
        attrs[args[i-1]] = arg
      end
    else
      table.insert(keys, arg)
      if i % 2 == 1 then
        props[args[i-1]] = arg
      end
    end
  end

  return attrs, props, keys
end

awm.match = function(c, attrs)
  if not next(attrs) then
    return false
  end

  for k, v in pairs(attrs) do
    if c[k] ~= v then
      return false
    end
  end
  return true
end

awm.find = function(attrs)
  for _, c in ipairs(client.get()) do
    if awm.match(c, attrs) then
      return c
    end
  end

  return nil
end

awm.fmt = function(c, keys)
  local res = ''
  local sep = '\x01'

  for i, key in ipairs(keys) do
    if c then
      local fmt = '%s'

      if type(c[key]) == 'number' then
        fmt = '%d'
        if key == 'window' then
          fmt = "0x%08x"
        end
      end

      if i == #keys then
        sep = '\n'
      end

      res = res .. string.format(fmt, c[key]) .. sep
    end
  end

  return res
end

awm.list = function(...)
  local args = { ... }
  local list = '\n'

  for _, c in ipairs(client.get()) do
    list = list .. awm.fmt(c, args)
  end

  return list
end

awm.raise = function(c)
  if c then
    c.hidden = false
    c.minimized = false
    c:raise()
    if not (c.above and c.sticky) then
      c.first_tag:view_only()
    end
    client.focus = c
    print(string.format("Raising: %s\n", c.profile))
    return true
  end
  return false
end

awm.cmp = function(t1, t2)
  if not next(t1) then return false end
  if not next(t2) then return false end

  if type(t1) ~= "table" or type(t2) ~= "table" then return false end

  for k, v in pairs(t1) do
    if t2[k] ~= v then
      return false
    end
  end

  for k, v in pairs(t2) do
    if t1[k] ~= v then
      return false
    end
  end

  return true
end

awm.inspect = function()
  for pid, attrs in pairs(_G.attrs) do
    for k, v in pairs(attrs) do
      print(string.format('attrs[%d].%s = %s', pid, k, v)
      )
    end
  end
end

awm.kill = function(...)
  local args = { ... }
  local attrs = awm.parse(args)
  local c = awm.find(attrs)

  if c then
    return c:kill()
  end

  return false
end

awm.getattributes = function(...)
  local args = { ... }
  local output = '\n'

  local attrs, keys

  attrs, _, keys = awm.parse(args)

  local c = awm.find(attrs)

  if c then
    for _, k in ipairs(keys) do
      output = output .. string.format('%s: %s', k, awm.fmt(c, { k }))
    end
    return output
  end
  return false
end

awm.setattributes = function(...)
  local args = { ... }
  local output = '\n'

  local attrs, props, keys = {}

  attrs, props, _ = awm.parse(args)

  local c = awm.find(attrs)

  if c then
    for k, v in pairs(props) do
      if v == '' then v = nil end
      c[k] = v
      output = output .. string.format('%s: %s', k, awm.fmt(c, { k }))
    end
    return output
  end

  return false
end

awm.spawn = function(mode, cmd, ...)
  local args = { ... }

  local attrs = awm.parse(args)

  local c = awm.find(attrs)

  if c then
    print(string.format('awm.spawn(%s): found %s', mode, c.profile))
    if mode == 'fg' then
      return awm.raise(c)
    end
    return true
  end

  local pid = awful.spawn(cmd)

  if pid and type(pid) == 'number' then
    _G.states = _G.states or {}
    _G.states[pid] = {
      attrs = attrs,
      mode = mode,
      cmd = cmd,
    }
    print(string.format('awm.spawn(%s): new "%s" as %s',
      mode, cmd, attrs.profile))
    return pid
  end

  print(string.format('awm.spawn(%s): failed "%s"', mode, cmd))
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

  _G.states = data.states or {}

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

  os.remove(path)
end

awm.save = function()
  local data = {
    states = _G.states
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

awm.timeout = function(...)
  local args = { ... }

  local widgets = require("widgets")

  for _, arg in ipairs(args) do
    widgets.timers[arg]:emit_signal("timeout")
  end
end

return awm
