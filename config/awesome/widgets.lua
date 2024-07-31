local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local theme = require('beautiful')
local utils = require('utils')

local w = {
    watches = {},
    timers  = {},
}

local textupdate = function()
    return function(widget, stdout)
        stdout = stdout or ''
        local icon, text = stdout:match('^(.-):(.*)$')

        if not icon or icon == '' then
            widget.widget.spacing = 0
        end

        widget.widget.iconbox.markup = icon or ''
        widget.widget.textbox.markup = text or ''

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

w.addbutton = function(buttons, button, cmd)
    buttons = gears.table.join(buttons,
        awful.button({}, button, function() awful.spawn(cmd) end)
    )
    return buttons
end

for _, line in ipairs(pipexec('widget')) do
    local widget, period = line:match('^(%S+):(%S+)$')
    period = tonumber(period)

    local buttons = {}

    local fmtcmd = function(subcmd)
        return string.format('widget %s %s', widget, subcmd)
    end

    buttons = w.addbutton(buttons, 1, fmtcmd('run'))
    buttons = w.addbutton(buttons, 3, fmtcmd('toggle'))
    buttons = w.addbutton(buttons, 4, fmtcmd('next'))
    buttons = w.addbutton(buttons, 5, fmtcmd('prev'))

    w.watches[widget], w.timers[widget] =
        awful.widget.watch(fmtcmd('output'), period, textupdate(),
            wibox.widget {
            widget = wibox.container.place,
            halign = 'center',
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = theme.spacing,
                name = widget,
                {
                    id = 'iconbox',
                    widget = wibox.widget.textbox,
                    font = theme.iconfont
                },
                {
                    id = 'textbox',
                    widget = wibox.widget.textbox,
                    font = theme.textfont
                },
            },
        })

    w.watches[widget]:buttons(buttons)
end

return w
