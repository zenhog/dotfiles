package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

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
  local clients

  for i, arg in ipairs(args) do
    if i % 2 == 1 then
      goto continue
    end
    clients = awm.match(args[i-1], arg, clients)
    ::continue::
  end

  if clients[1] then
    return clients[1]
  end

  return nil
end

awm.spawn = function(mode, ...)
  local args = { ... }
end

awm.list = function()
  local res = '\n'
  local sep = '\x01'
  local fmt = '%s' .. sep .. '%d' .. sep .. '%s' .. sep .. '%s'
    .. sep .. '%s' .. sep .. '[%s]' .. '\n'

  for _, c in ipairs(client.get()) do
    res = res .. string.format(fmt,
      string.format('0x%08x', c.window or -1),
      c.pid or -1,
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

awm.raise = function(mode, ...)
  local args = { ... }

  local c = awm.find(table.unpack(args))

  if c then
    c.hidden = false
    c.minimized = false
    c:raise()
    if not (c.above and c.sticky) and mode == 'fg' then
      c.first_tag:view_only()
    end
    client.focus = c
    return true
  end

  return false
end

awm.fg = function(...)
  local args = { ... }
  return awm.raise('fg', table.unpack(args))
end

awm.bg = function(...)
  local args = { ... }
  return awm.raise('bg', table.unpack(args))
end

return awm
