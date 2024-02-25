local awful = require('awful')
local gears = require('gears')
local commands = require('commands')
local hotkeys_popup = require('awful.hotkeys_popup')

local altkey = "Mod1"
local modkey = "Mod4"

local mods = {}

mods['W'] = { modkey }
mods['S-M'] = { altkey, "Shift" }
mods['C-M'] = { altkey, "Control" }

local nmod = { modkey }
local smod = { modkey, "Shift"   }
local cmod = { modkey, "Control" }

local mapkey = function(mod, key, cmd, group, desc)
    return awful.key(mod, key, cmd, {
        group = group,
        description = desc,
    })
end

local spawn = function(cmd)
    return function()
        awful.spawn(cmd)
    end
end


local pipexec = function(cmd)
    local pipe = io.popen(cmd)
    local u = {}
    for line in pipe:lines() do
        table.insert(u, line)
    end
    pipe:close()
    return u
end

globalkeys = {}
clientkeys = {}

clientkeys = gears.table.join(
    mapkey(nmod, "f", commands.fullscreen,  "client", "fullscreen"),
    mapkey(nmod, "x", commands.maximize,    "client", "maximize"),
    mapkey(nmod, "n", commands.minimize,    "client", "minimize"),
    mapkey(nmod, "q", commands.close,       "client", "close"),
    -- o: make-master-window
    {}
)

globalkeys = gears.table.join(
    mapkey(nmod, ",", awful.tag.viewprev, "tag", "view prev"),
    mapkey(nmod, ".", awful.tag.viewnext, "tag", "view next"),
    mapkey(smod, "s", hotkeys_popup.show_help, "awesome", "help popup"),

    mapkey(nmod, "k", commands.focus_up,    "client", "focus up"),
    mapkey(nmod, "j", commands.focus_down,  "client", "focus down"),
    mapkey(nmod, "h", commands.focus_left,  "client", "focus left"),
    mapkey(nmod, "l", commands.focus_right, "client", "focus right"),
    -- C-hjkl: swap-by-direction?
    -- HJKL: resize-by-direction?

    mapkey(smod, "w", commands.kill_alerts, "awesome", "kill alerts"),
    mapkey(nmod, "m", commands.unminimize,  "awesome", "unminimize"),

    mapkey(nmod, "Tab", commands.next_client,  "awesome", "next client"),
    mapkey(smod, "Tab", commands.prev_client,  "awesome", "prev client"),

    mapkey(nmod, "space", commands.layout,        "awesome", "toggle layout"),
    mapkey(nmod, "u", awful.client.urgent.jumpto, "awesome", "jump urgent"),

    mapkey(cmod, "q", awesome.quit,    "awesome", "quit awesome"),
    mapkey(cmod, "r", awesome.restart, "awesome", "restart awesome"),
    {}
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        mapkey(nmod, "#" .. i + 9, commands.gototag(i)),
        mapkey(smod, "#" .. i + 9, commands.movetotag(i)),
        mapkey(cmod, "#" .. i + 9, commands.toggletag(i)),
        mapkey({ altkey }, "F" .. i,     commands.vtswitch(i)),
        {}
    )
end

for _, line in ipairs(pipexec('gui')) do
    local _, command, mod, key = line:match('^(%S+):(%S+):(%S+):(%S+)$')

    globalkeys = gears.table.join(globalkeys,
        mapkey(mods[mod], key,
            spawn(string.format('menu %s', command)), "menu", command)
    )
end

for _, line in ipairs(pipexec('gui run keys')) do
    local app, mod, key = line:match('^(%S+):(%S+):(%S+)$')

    globalkeys = gears.table.join(globalkeys,
        mapkey(mods[mod], key,
            spawn(string.format('gui run fg %s', app)), "app", app)
    )
end

for _, line in ipairs(pipexec('widget')) do
    local widget, _ = line:match('^(%S+):(%S+)$')
    for _, l in ipairs(pipexec(string.format('widget %s keys', widget))) do
        local method, mod, key = l:match('^(%S+):(%S+):(%S+)$')
        globalkeys = gears.table.join(globalkeys,
            mapkey(
                mods[mod],
                key,
                spawn(string.format('widget %s %s', widget, method)),
                "widget",
                string.format('%s %s', widget, method)
            )
        )
    end
end

root.keys(globalkeys)

return clientkeys
