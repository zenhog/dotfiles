package.loaded["naughty.dbus"] = {}
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local awm = require("awm")
local handlers = require("handlers")

local sharedtags = require("sharedtags")

require("awful.autofocus")

local theme = require("beautiful")

--local dbus = nil
local naughty = require("naughty")

theme.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

local keys = require("keys")
local wibars = require("wibars")

_G.cmds = {}

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

awful.rules.rules = {
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			keys = keys,
			-- buttons = clientbuttons,
			screen = awful.screen.preferred,
			size_hints_honor = false,
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

handlers.register_handlers()

handle_errors()

awm.load()

awful.spawn.with_shell("autostart", awful.rules.rules)
