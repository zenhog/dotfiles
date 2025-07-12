package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local sharedtags = require("sharedtags")

require("awful.autofocus")

local theme = require("beautiful")

--local dbus = nil
local naughty = require("naughty")

local last_focused_screen = awful.screen.focused()

theme.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

_G.layout = {
  icons = {
    tileleft = ''
  }
}

local keys = require("keys")
local wibars = require("wibars")

_G.tags = sharedtags({
	{
		name = "1",
		idx = 1,
		layout = awful.layout.layouts[1],
	},
	{
		name = "2",
		idx = 2,
		layout = awful.layout.layouts[1],
		screen = 2,
	},
	{
		name = "3",
		idx = 3,
		layout = awful.layout.layouts[1],
		screen = 2,
	},
	{
		name = "4",
		idx = 4,
		layout = awful.layout.layouts[1],
		screen = 2,
	},
	{
		name = "5",
		idx = 5,
		layout = awful.layout.layouts[1],
		screen = 2,
	},
})

local function update_clients_visibility(t)
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

local function update_layout_icon(t)
    local icons = _G.layout.icons

    local name = t.layout.name
    t.screen.menus.run.markup = string.format(
      '<b><span color="%s">%s</span></b>', _G.layout.color, icons[name]
    )
end

-- Update wibox visibility for a screen
local function update_wibox_visibility(s)
	-- Check if current tag has any fullscreen clients
	local current_tag = s.selected_tag
	local should_hide = false
	for _, c in ipairs(client.get()) do
		if c.screen == s and c.fullscreen and c:tags()[1] == current_tag then
			should_hide = true
			break
		end
	end

	-- Set wibox visibility
	s.leftbar.visible = not should_hide
	s.topbar.visible = not should_hide
end

tag.connect_signal("property::layout", function(t)
  update_layout_icon(t)
  update_wibox_visibility(t.screen)
  update_clients_visibility(t)
end)

-- Update when tag is selected
tag.connect_signal("property::selected", function(t)
  update_layout_icon(t)
  update_wibox_visibility(t.screen)
  update_clients_visibility(t)
  -- update_client_visibility?
end)

-- Update when client moves between tags
client.connect_signal("tagged", function(c)
	for _, s in ipairs(screen) do
		update_wibox_visibility(s)
	end
end)

-- Fullscreen property handler
client.connect_signal("property::fullscreen", function(c)
  -- c.first_tag.layout = awful.layout.layouts[1]
  c.first_tag:emit_signal("property::selected")
end)

-- Client unmanaged handler
client.connect_signal("unmanage", function(c)
	if c.fullscreen then
		update_wibox_visibility(c.screen)
	end
end)

local function handle_errors()
	if awesome.startup_errors then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Startup errors",
			text = awesome.startup_errors,
		})
	end

	do
		local in_error = false
		awesome.connect_signal("debug::error", function(err)
			if in_error then
				return
			end
			in_error = true
			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Runtime error",
				text = tostring(err),
			})
			in_error = false
		end)
	end
end

local function set_clientimg(c)
	local cairo = require("lgi").cairo
	local homedir = os.getenv("HOME")

	if c and c.valid then
		local icon

		if c.profile then
			icon = string.format("%s/.icons/%s.png", homedir, c.profile)
		else
			icon = homedir .. "/.icons/default.png"
		end

		local s = gears.surface(icon)

		local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
		local cr = cairo.Context(img)

		cr:set_source_surface(s, 0, 0)
		cr:paint()

		c.icon = img._native
		c.alticon = c.icon
	end
end

-- Fix clients that dynamically change their own icon on a whim
client.connect_signal("property::icon", function(c)
  if c and not c.mutex then
    if c.alticon and c.alticon ~= c.icon then
      c.mutex = true
      c:emit_signal("icon_mutex")
    end
  end
end)

client.connect_signal("icon_mutex", function(c)
  if c.mutex then
    c.icon = c.alticon
    c.mutex = nil
  end
end)

local function set_clienttag(c)
	local tags = c.screen.tags
	tags = _G.tags
	local homedir = os.getenv("HOME")

	if c.instance == "loop" then
		c:move_to_tag(tags[4])
		return
	end

	local path = function(p)
		local homedir = os.getenv("HOME")
		return string.format("%s/.icons/%s.png", homedir, p)
	end

	c.profile = c.profile or string.lower(c.instance or "")

	if not gears.filesystem.file_readable(path(c.profile)) then
		c.profile = string.lower(c.instance or "")
	end

	local hostname = os.getenv("HOSTNAME")

	if c.profile == hostname then
		c.profile = "main"
	end

	if not gears.filesystem.file_readable(path(c.profile)) then
		c.profile = string.lower(c.class or "")
	end

	if not gears.filesystem.file_readable(path(c.profile)) then
		c.profile = nil
	end

	local tagmap = {
		main = 1,
		tmux = 1,
		rmux = 1,
		urxvt = 1,
		alacritty = 1,
		kitty = 1,
		ctfbox = 1,
		cutter = 1,
		dota2 = 1,

		navigator = 2,
		chromium = 2,
		firefox = 2,
		qutebrowser = 2,

		feh = 3,
		nsxiv = 3,
		mupdf = 3,

		discord = 4,
		spotify = 4,
		whatsie = 4,
		vlc = 4,
		mpv = 4,
		goofcord = 4,
		ts3client_linux_amd64 = 4,

		stremio = 5,
		retroarch = 5,
		steam = 5,
	}

	tagmap["firefox-vpn1"] = 3
	tagmap["firefox-vpn2"] = 3
	tagmap["qutebrowser-vpn1"] = 3
	tagmap["qutebrowser-vpn2"] = 3

	local tagnum = tagmap[c.profile] or 5

	c:move_to_tag(tags[tagnum])
end

local function set_titlebars(c)
	if c.instance == "loop" then
		return
	end

	awful.titlebar(c, {
		size = 0,
		position = "top",
		bg_normal = "gray",
		bg_focus = "darkgray",
	})
end

local function set_attributes(c)
	local s = awful.screen.focused()
	local w, h = s.geometry.width, s.geometry.height

  if c.class:match("tmux") or
    c.class:match("rmux") or
    c.class:match("Alacritty") or
    c.class:match("URxvt")
  then
    c.opacity = 0.75
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

client.connect_signal("manage", function(c)
	-- c.shape = roundedrect

	set_clienttag(c)
	--set_titlebars(c)
	set_attributes(c)
	set_clientimg(c)

  update_clients_visibility(c.first_tag)

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end

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
end)

local function focus_menu()
	for _, ct in ipairs(client.get()) do
		if ct.instance == "loop" and ct.hidden == false then
			client.focus = ct
		end
	end
end

client.connect_signal("focus", function(c, context)
	last_focused_screen = c.screen
	focus_menu()
	update_clients_visibility(c.first_tag)
end)

client.connect_signal("property::screen", function(c)
	-- if c.active then
	--    update_clients_visibility(c.first_tag)
	-- end
end)

client.connect_signal("unfocus", function(c)
  -- update_clients_visibility(c.first_tag)
end)

client.connect_signal("request::activate", function(c, context)
  -- update_clients_visibility(c.first_tag)
	focus_menu()
end)

handle_errors()

awful.rules.rules = {
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			size_hint_honor = true,
			honor_workarea = true,
			honor_padding = true,
			maximized_horizontal = false,
			maximized_vertical = false,
			maximized = false,
			titlebars_enabled = false,
			fullscreen = false,
			floating = false,
			requests_no_titlebar = false,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},
}

-- update_terminal_visibility()

awful.spawn.with_shell("autostart", awful.rules.rules)
