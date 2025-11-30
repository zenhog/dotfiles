package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local fs = require("gears.filesystem")
local serpent = require("serpent")
local path = fs.get_cache_dir() .. 'persistent_state.lua'

local awm = {}

awm.parse = function(args)
  local attrs = {}
  local props = {}

  local sep = false

  for i, arg in ipairs(args) do
    if arg == '--' then
      sep = true
    elseif not sep then
      if i % 2 == 0 then
        attrs[args[i-1]] = arg
      end
    else
      if i % 2 == 1 then
        props[args[i-1]] = arg
      end
    end
  end

  return attrs, props
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

awm.list = function()
  local res = '\n'
  local sep = '\x01'
  local fmt = '%s' .. sep .. '%d' .. sep .. '%d' .. sep .. '%s' .. sep .. '%s'
    .. sep .. '%s' .. sep .. '[%s]' .. '\n'

  for _, c in ipairs(client.get()) do
    res = res .. string.format(fmt,
      string.format('0x%08x', c.window or -1),
      c.pid or -1,
      c.tagnum or -1,
      c.profile,
      c.class,
      c.instance,
      c.name
    )
  end
  return res
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
      print(string.format('attrs[%d].%s = %s',
        pid, k, v)
      )
    end
  end
end

awm.getattributes = function(...)
  local args = { ... }

  local c = awm.find(args)


end

awm.spawn = function(mode, cmd, ...)
  local args = { ... }

  local attrs = awm.parse(args)

  local c = awm.find(attrs)

  if c and mode == 'fg' then
    return awm.raise(c)
  end

  local pid = awful.spawn(cmd)

  if pid and type(pid) == 'number' then
    _G.states = _G.states or {}
    _G.states[pid] = {
      attrs = attrs,
      mode = mode,
      cmd = cmd,
    }
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

  -- os.remove(path)
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

return awm
