local awm = require('awm')
local awful = require('awful')
local gears = require('gears')
local serpent = require('serpent')
local fs = gears.filesystem

local M = {}

local handlers = { tag = {}, client = {}, awesome = {} }

M.register_handlers = function ()
  for obj, sigtable in pairs(handlers) do
    for signame, sighandler in pairs(sigtable) do
      local sigprint = string.format('Registering _G[%s].connect_signal(%s)',
        obj, signame)
      print(sigprint)

      _G[obj].connect_signal(signame, function(c, ...)
        local args = { ... }

        if obj == 'client' then
          print(string.format("Signal [%s.%s] => (%d, [%s:%s.%s], %s)",
            obj, signame, c.pid or -1, c.profile, c.class, c.instance, c.name))
        end

        if obj == 'tag' then
          print(string.format("Signal [%s.%s] => ([%d:%d], [.%s])",
            obj, signame, c.screen.index or -1, c.index or -1, c.name))
        end

        if obj == 'awesome' then
          print(string.format("Signal [%s.%s]", obj, signame))
        end

        sighandler(c, table.unpack(args))
      end)
    end
  end
end

local function update_layout_icon(t)
  local name = t.layout.name

  local icon = 'icon'

  if name:match('tile') then
    icon = 'alticon'
  end

  t.screen.menus.awm:emit_signal("menus::awm", icon)
end

local function set_tagnum(c)
  for i = 1,5 do
    local iconpath = string.format("%s/.icons/%d/%s.png",
      os.getenv("HOME"), i, c.profile)

    if fs.file_readable(iconpath) then
      c.iconpath = iconpath
      return i
    end
  end

  c.iconpath = string.format("%s/.icons/default.png", os.getenv("HOME"))
  return 5
end

local function set_profile(c)
	c.profile = c.profile or string.lower(c.instance or '')
  c.profile = c.profile or string.lower(c.class or '')
  c.profile = c.profile or 'default'

	if c.profile == os.getenv("HOSTNAME") then
		c.profile = 'main'
	end

  if c.class == 'menu' and c.instance == 'loop' then
    c.profile = 'menuloop'
  end
end

local function set_clienttag(c)
	local tags = _G.tags

  set_profile(c)

	if c.profile == "menuloop" then
    c.tagnum = 0
    return
	end

  c.tagnum = c.tagnum or set_tagnum(c)

  c:move_to_tag(tags[c.tagnum])
end

local function set_attributes(c)
	local s = awful.screen.focused()
	local w, h = s.geometry.width, s.geometry.height

  if c.state then
    for k, v in pairs(c.state.attrs) do
      c[k] = v
    end
  end

  if c.class then
    if c.class:match("tmux") or
      c.class:match("rmux") or
      c.class:match("Alacritty") or
      c.class:match("URxvt")
    then
      c.opacity = 0.75
    end
  end

	if c.class == "menu" and c.instance == "loop" then
		c.opacity = 1
		c.hidden = true
		c.minimized = true
		c.titlebars_enabled = false
		c.requests_no_titlebar = true
		c.sticky = true
		c.floating = true
		c.ontop = true
		c.above = true
		c.skip_taskbar = true
		c.width = w / 1.1
		c.height = h / 1.1
		c.x = w / 2 - c.width / 2
		c.y = h / 2 - c.height / 2
	end

  c.transparency = c.opacity or 1
end

local function set_buttons(c)
	c:buttons(awful.util.table.join(
		awful.button({}, 1, function(c)
			if c ~= client.focus then
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
		awful.button({}, 3, function(c)
			if c ~= client.focus then
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end)
	))
end

local function focus_menu()
	for _, c in ipairs(client.get()) do
		if c.profile == "menuloop" and c.hidden == false then
			client.focus = c
		end
	end
end

local function update_screen_tags()
  for s in screen do
    if s ~= awful.screen.focused() then
      for _, t in ipairs(s.tags) do
        t:emit_signal("property::name")
      end
    end
  end
end

local function set_visibility(t)
  if not t then
    return
  end

  local clients = t:clients()
  local layout = t.layout.name
  local focused = client.focus

  if not focused then
    return
  end

  if focused.class == 'menu' then
    return
  end

  local in_fullscreen = false

  for _, c in ipairs(clients) do
    if c.fullscreen then
      in_fullscreen = true
    end
  end

  for _, c in ipairs(clients) do
    if c.class == 'menu' then
      goto continue
    end

    if c == focused then
      c.opacity = c.transparency
    elseif in_fullscreen then
      c.opacity = 0
    else
      if layout == 'max' then
        c.opacity = 0
      elseif layout == 'tileleft' then
        c.opacity = c.transparency
      end
    end
    ::continue::
  end
end

local function set_clientimg(c)
	local cairo = require("lgi").cairo

	if c and c.valid then
		local icon = c.iconpath or nil

		local s = gears.surface(icon)

		local img = cairo.ImageSurface.create(
      cairo.Format.ARGB32, s:get_width(), s:get_height())
		local cr = cairo.Context(img)

		cr:set_source_surface(s, 0, 0)
		cr:paint()

		c.icon = img._native
		c.alticon = c.icon
	end
end

local function set_statusbars(c)
	c.screen.leftbar.visible = not c.fullscreen
	c.screen.topbar.visible = not c.fullscreen
end

local function update_wibox_visibility(s)
	local current_tag = s.selected_tag
	local should_hide = false

  for _, c in ipairs(current_tag:clients()) do
		if c.fullscreen then
			should_hide = true
			break
		end
	end

	s.leftbar.visible = not should_hide
	s.topbar.visible = not should_hide
end

handlers.client.tagged = function(c)
  if c.tagnum and c.tagnum ~= 0 then
    local tags = _G.tags
    c:move_to_tag(tags[c.tagnum])
  end

  -- for _, s in ipairs(screen) do
  --   update_wibox_visibility(s)
  -- end

  set_statusbars(c)

  update_screen_tags()
end

handlers.client['property::fullscreen'] = function(c)
  set_statusbars(c)
  c.first_tag:emit_signal("property::selected")
end

handlers.awesome.exit = function(restarting)
  if restarting then
    awm.save()
  end
end

handlers.client.manage = function(c)

  if _G.states and _G.states[c.pid] then
    c.state = _G.states[c.pid]
  end

	set_attributes(c)
	set_clienttag(c)
	set_clientimg(c)
  set_buttons(c)

  set_visibility(c.first_tag)

  if c.state and c.state.mode and c.state.mode == 'fg' then
    c:raise()
    client.focus = c
    c.first_tag:view_only()
  end
end

handlers.client.focus = function(c, context)
	-- last_focused_screen = c.screen
	focus_menu()
	set_visibility(c.first_tag)
end

handlers.client['property::screen'] = function(c)
	-- if c.active then
	--    set_visibility(c.first_tag)
	-- end
end

handlers.client.unfocus = function(c)
  -- set_visibility(c.first_tag)
end

handlers.client['request::activate'] = function(c)
  -- set_visibility(c.first_tag)
  -- update_wibox_visibility(c.screen)
  set_statusbars(c)
	focus_menu()
end

handlers.client.unmanage = function(c)
	-- if c.fullscreen then
	-- 	update_wibox_visibility(c.screen)
	-- end

  set_statusbars(c)

  update_screen_tags()

  -- if c.lockfile then
  --   os.execute('rm -f ' .. c.lockfile)
  -- end
end

handlers.tag['property::selected'] = function(t)
  update_layout_icon(t)
  -- update_wibox_visibility(t.screen)
  update_screen_tags()
  set_visibility(t)
end

handlers.tag['property::layout'] = function(t)
  update_layout_icon(t)
  -- update_wibox_visibility(t.screen)
  set_visibility(t)
end

handlers.client['property::icon'] = function(c)
  if c and not c.mutex then
    if c.alticon and c.alticon ~= c.icon then
      c.mutex = true
      c:emit_signal("icon::mutex")
    end
  end
end

handlers.client["icon::mutex"] = function(c)
  if c.mutex then
    c.icon = c.alticon
    c.mutex = nil
  end
end

local unwanted_props = {
  "maximized",
  "maximized_horizontal",
  "maximized_vertical",
  "above",
  "below",
  "sticky",
  "ontop",
}

local function prevent_unwanted(c)
  c.maximized = false
  c.maximized_vertical = false
  c.maximized_horizontal = false
  c.above = false
  c.below = false

  if c.profile ~= "menuloop" then
    c.sticky = false
    c.ontop = false
  end
end

for _, prop in ipairs(unwanted_props) do
  handlers.client["property::" .. prop] = prevent_unwanted
end

return M
