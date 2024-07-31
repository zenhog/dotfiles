local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local theme = require('beautiful')
dbus = nil
local naughty = require('naughty')
local dpi = require('beautiful').xresources.apply_dpi
local utils = require('menubar.utils')
local commands = require('commands')

local helpers = {}

helpers.spacer = function(n)
    s = ''
    for i = 1, n do
      s = s .. ' '
    end
    return wibox.widget.textbox(s)
end

helpers.rrect = function(radius)
  return function(c, width, height)
    gears.shape.rounded_rect(c, width, height, radius)
  end
end

helpers.prrect = function(radius, tl, tr, br, bl)
  return function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
  end
end

helpers.colorize_text = function(text, color)
    if text and color then
      return "<span foreground='" .. color .."'>" .. text .. "</span>"
    end
    return
end

helpers.change_font = function(font, text)
    if text and font then
      return "<span font='" .. font .. "'>" .. text .. "</span>"
    end
    return
end

helpers.topleft_corner = function(color)
  local widget = wibox.widget.base.make_widget()
  widget.fit = function(m, w, h)
    return theme.corner_width, theme.corner_height
  end
  widget.draw = function(w, wibox, cr, width, height)
    cr:set_source_rgb(gears.color.parse_color(color))
    cr:new_path()
    cr:move_to(0, 0)
    cr:line_to(width, 0)
    cr:line_to(0, height)
    cr:close_path()
    cr:fill()
  end
  return widget
end

helpers.topright_corner = function(color)
  local widget = wibox.widget.base.make_widget()
  widget.fit = function(m, w, h)
    return theme.corner_width, theme.corner_height
  end
  widget.draw = function(w, wibox, cr, width, height)
    cr:set_source_rgb(gears.color.parse_color(color))
    cr:new_path()
    cr:move_to(0, 0)
    cr:line_to(width, 0)
    cr:line_to(width, height)
    cr:close_path()
    cr:fill()
  end
  return widget
end

helpers.botleft_corner = function(color)
  local widget = wibox.widget.base.make_widget()
  widget.fit = function(m, w, h)
    return theme.corner_width, theme.corner_height
  end
  widget.draw = function(w, wibox, cr, width, height)
    cr:set_source_rgb(gears.color.parse_color(color))
    cr:new_path()
    cr:move_to(0, 0)
    cr:line_to(width, height)
    cr:line_to(0, height)
    cr:close_path()
    cr:fill()
  end
  return widget
end

helpers.botright_corner = function(color)
  local widget = wibox.widget.base.make_widget()
  widget.fit = function(m, w, h)
    return theme.corner_width, theme.corner_height
  end
  widget.draw = function(w, wibox, cr, width, height)
    cr:set_source_rgb(gears.color.parse_color(color))
    cr:new_path()
    cr:move_to(width, 0)
    cr:line_to(width, height)
    cr:line_to(0, height)
    cr:close_path()
    cr:fill()
  end
  return widget
end

helpers.topleft_para = function(widget, color, margins, l_skip, r_skip)
  local l_corner = helpers.botright_corner(color)
  local r_corner = helpers.topleft_corner(color)
  local middle = wibox.container.background(wibox.container.margin(widget, margins, margins, margins, margins), color)
  if l_skip then
      l_corner = nil
      middle = wibox.container.margin(middle, 0, 0, 0, 0)
  end
  if r_skip then
      r_corner = nil
      middle = wibox.container.margin(middle, 0, 0, 0, 0)
  end
  return wibox.container.margin(wibox.widget {
    l_corner,
    middle,
    r_corner,
    layout = wibox.layout.align.horizontal
  }, 0, 0, 0, 0)
end

helpers.botleft_para = function(widget, color, margins, l_skip, r_skip)
  local l_corner = helpers.topright_corner(color)
  local r_corner = helpers.botleft_corner(color)
  local middle = wibox.container.background(wibox.container.margin(widget, margins, margins, margins, margins), color)
  if l_skip then
      l_corner = nil
      middle = wibox.container.margin(middle, 0, 0, 0, 0)
  end
  if r_skip then
      r_corner = nil
      middle = wibox.container.margin(middle, 0, 0, 0, 0)
  end
  return wibox.container.margin(wibox.widget {
    l_corner,
    middle,
    r_corner,
    layout = wibox.layout.align.horizontal
  }, 0, 0, 0, 0)
end

helpers.top_trapeze = function(widget, color, margins)
  local l_corner = helpers.botright_corner(color)
  local r_corner = helpers.botleft_corner(color)
  return wibox.container.margin(wibox.widget {
    l_corner,
    wibox.container.background(wibox.container.margin(widget, margins, margins), color),
    r_corner,
    layout = wibox.layout.align.horizontal
  }, 0, 0, 0, 0)
end

helpers.bot_trapeze = function(widget, color, margins)
  local l_corner = helpers.topright_corner(color)
  local r_corner = helpers.topleft_corner(color)
  return wibox.widget {
    l_corner,
    wibox.container.background(wibox.container.margin(widget, margins, margins), color),
    r_corner,
    layout = wibox.layout.align.horizontal
  }
end

helpers.handle_errors = function()
  if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors on startup!",
        text = awesome.startup_errors
      })
  end

  do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
      if in_error then return end
      in_error = true
      naughty.notify({
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err)
        })
      in_error = false
    end)
  end
end

return helpers
