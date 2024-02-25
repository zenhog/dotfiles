local awful   = require('awful')
local wibox   = require('wibox')
local gears   = require('gears')
local theme   = require('beautiful')
local widgets = require('widgets').watches
local addbutton = require('widgets').addbutton

local M = {}

awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile.left,
}


local function rrect(radius)
    return function(c, width, height)
        gears.shape.rounded_rect(c, width, height, radius)
    end
end

local function block(widget, forced_width)
    return wibox.widget
    {
        {
            widget,
            margins = theme.spacing,
            widget = wibox.container.margin,
        },
        bg = theme.bg_wrap,
        shape = rrect(theme.global_radius),
        forced_width = forced_width,
        widget = wibox.container.background,
    }
end


local function scroll(widget, width)
    local iconwidget = wibox.widget {
        widget.widget.iconbox,
        halign = 'center',
        valign = 'center',
        fill_horizontal = true,
        widget = wibox.container.place,
    }

    local textblock = block(M.group({
        halign = 'center',
        widget = wibox.container.place,
        fill_horizontal = true,
        forced_width = width,
        {
            widget.widget.textbox,
            speed = 40,
            extra_space = 50,
            step_function =
                wibox.container.scroll.step_functions.linear_increase,
            layout = wibox.container.scroll.horizontal,
        },
    }))

    local iconblock = block(M.group(iconwidget), theme.iconsize)

    local w = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 1,
        iconblock,
        textblock,
    }

    local fmtcmd = function(subcmd)
        return string.format('widget %s %s', widget.widget.name, subcmd)
    end

    local buttons = {}

    buttons = addbutton(buttons, 1, fmtcmd('run'))
    buttons = addbutton(buttons, 3, fmtcmd('toggle'))
    buttons = addbutton(buttons, 4, fmtcmd('next'))
    buttons = addbutton(buttons, 5, fmtcmd('prev'))

    w:buttons(buttons)
    return w
end

local function mouse_in(widget)
    widget.oldbg = widget.bg
    widget.bg = "#000000ff"
    local m = _G.mouse.current_wibox
    if m then
        widget.old_cursor, widget.old_wibox = m.cursor, m
        m.cursor = 'hand2'
    end
end

local function mouse_out(widget)
    widget.bg = widget.oldbg
    if widget.old_wibox then
        widget.old_wibox.cursor = widget.old_cursor
        widget.old_wibox = nil
    end
end

function M.group(...)
    local args = table.pack(...)
    local group = {
        spacing = theme.spacing,
        spacing = 1,
        layout = wibox.layout.fixed.horizontal,
    }
    for i = 1, args.n do
        if args[i] then
            local w = wibox.widget {
                widget = wibox.container.background,
                bg = theme.bg_wrap,
                shape = rrect(theme.global_radius),
                {
                    widget = wibox.container.margin,
                    margins = theme.spacing,
                    args[i],
                },
            }

            w:buttons(w.widget.widget:buttons())

            w:connect_signal("button::press", function()
                w.bgp = w.bg
                w.bg = "#000000aa"
            end)

            w:connect_signal("button::release", function()
                w.bg = w.bgp
            end)

            w:connect_signal("mouse::enter", mouse_in)
            w:connect_signal("mouse::leave", mouse_out)
            table.insert(group, w)
        end
    end
    return wibox.widget(group)
end

local function set_wallpaper(s)
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
    awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    s.tasklist_buttons = awful.util.table.join(
        awful.button({}, 1, function(c)
            if c == _G.client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                _G.client.focus = c
                c:raise()
            end
        end),
        awful.button({}, 3, function(c)
            c.kill(c)
        end),
        awful.button({}, 4, function()
            awful.client.focus.byidx(1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx(-1)
        end)
    )

    s.taglist_buttons = awful.util.table.join(
        awful.button({}, 1, function(t)
            t:view_only()
        end),
        awful.button({}, 3, function(t)
            awful.tag.viewtoggle(t)
        end),
        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end)
    )

    local taglist_callback = function(self, t, index, tags)
        local star_outline = '󰓒'  -- empty
        local star         = '󰓎'  -- normal
        local starface     = '󰦥'  -- focus
        local shuriken     = '󰫢'  -- urgent
        -- local star         = '󰐾'  -- normal
        -- local star_outline = ''  -- empty
        -- local starface     = ''  -- focus
        -- local shuriken     = '󱥸'  -- urgent

        local colors = { "deepskyblue", "yellow", "red", "cyan", "magenta" }

        local ir = self:get_children_by_id('index_role')[1]

        local tagclients = t:clients()

        local hasmenu = false

        for _, c in ipairs(tagclients) do
            if c.instance == 'menu' then
                hasmenu = true
            end
        end

        if #tagclients > 0 then
            if #tagclients == 1 and hasmenu then
                ir.markup = star_outline
            else
                ir.markup = star
            end
        else
            ir.markup = star_outline
        end

        if t.urgent and not hasmenu then
            ir.markup = shuriken
        end

        if t.selected then
            ir.markup = starface
        end

        ir.font = theme.iconfont_name .. ' 10'
        ir.font = theme.iconfont_name .. ' 12'

        ir.markup = string.format('<span color="%s">%s</span>',
            colors[index], ir.markup)

        local br = self:get_children_by_id('outsidebox')[1]

        self:connect_signal('mouse::enter', mouse_in)

        self:connect_signal('mouse::leave', mouse_out)
    end

    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = wibox.layout.fixed.vertical,
        buttons = s.taglist_buttons,
        style  = {
            spacing = theme.spacing / 2,
            spacing = 1,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, theme.global_radius)
            end,
        },
        widget_template = {
            -- widget = wibox.container.background,
            -- shape = rrect(theme.global_radius),
            -- bg = theme.bg_normal,
            -- forced_height = theme.iconsize,
            -- {
            --     widget = wibox.container.margin,
            --     margins = theme.spacing,
            --     {
            widget = wibox.container.background,
            shape = rrect(theme.global_radius),
            bg = "#00000080",
            id = 'outsidebox',
            {
                widget = wibox.container.margin,
                margins = theme.spacing,
                right = theme.spacing + 1,
                {
                    id     = 'index_role',
                    align = 'center',
                    widget = wibox.widget.textbox,
                },
            },
            --    },
            --},
            create_callback = taglist_callback,
            update_callback = taglist_callback,
        },
        -- widget_template = {
        --     widget = wibox.container.margin,
        --     top    = 1,
        --     bottom = 1,
        --     {
        --         id     = 'index_role',
        --         widget = wibox.widget.textbox,
        --     },
        --     create_callback = taglist_callback,
        --     update_callback = taglist_callback,
        -- },
    }

    s.tasklist = wibox.container.margin(awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = wibox.layout.fixed.vertical,
        buttons = s.tasklist_buttons,
        style = {
            spacing = theme.spacing,
            spacing = 1,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, theme.global_radius)
            end,
        },
        widget_template = {
            widget = wibox.container.background,
            shape = rrect(theme.global_radius),
            bg = theme.bg_normal,
            bg = "#00000080",
            forced_height = theme.iconsize,
            id = 'outsidebox',
            {
                widget = wibox.container.margin,
                margins = theme.spacing,
                {
                    widget = wibox.container.margin,
                    {
                        id = 'background_role',
                        widget = wibox.container.background,
                        {
                            id = 'icon_margin_role',
                            margins = theme.spacing,
                            widget = wibox.container.margin,
                            {
                                id = 'icon_role',
                                shape = rrect(theme.global_radius),
                                widget = wibox.widget.imagebox,
                            },
                        },
                    },
                },
            },
            create_callback = function(self, c, index, objects)
                self:connect_signal("mouse::enter", mouse_in)
                self:connect_signal("mouse::leave", mouse_out)
            end,
            update_callback = function(self, c, index, objects)
            end,
        },
    })

    local function iconwidget(icon, lcommand, rcommand, color)
        local widget = wibox.widget.textbox()
        color = color or 'gray'

        local buttons = {}
        if lcommand then
            buttons = gears.table.join(
                awful.button({}, 1, function() awful.spawn(lcommand) end)
            )
        end
        if rcommand then
            buttons = gears.table.join(
                awful.button({}, 3, function() awful.spawn(rcommand) end)
            )
        end

        widget.font = theme.iconfont

        widget.align  = 'center'
        widget.valign = 'center'
        widget.markup = string.format('<b><span color="%s">%s</span></b>',
            color, icon)
        widget.forced_width = theme.iconsize

        widget:buttons(buttons)
        return widget
    end

    s.menus = {}

    local pipe = io.popen('gui')

    for line in pipe:lines() do
        local icon, command, _, _ = line:match('^(%S+):(%S+):(%S+):(%S+)$')
        local buttons = {}

        s.menus[command] = iconwidget(icon, command, command)
        s.menus[command]:buttons(addbutton(buttons, 1, 'menu ' .. command))
    end
    pipe:close()


    s.topbar = awful.wibar {
        screen = s,
        position = "top",
        opacity = 0.65,
        height = theme.wibar_height,
        type = "dock",
        bg = "#00000000",
    }

    s.leftbar = awful.wibar {
        screen = s,
        position = "left",
        opacity = 0.65,
        width = theme.wibar_height,
        width = 38,
        type = "dock",
        bg = "#00000000",
    }

    s.topbar:setup {
        {
            --inner_fill_strategy = 'justify',
            layout = wibox.layout.ratio.horizontal,
            id = 'topbar',
            {
                widget = wibox.container.place,
                fill_horizontal = true,
                id = 'underbar',
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 1,
                    block(M.group(s.menus.run), theme.iconsize),
                    block(M.group(s.menus.awm), theme.iconsize),
                    block(M.group(s.menus.ssh), theme.iconsize),
                    scroll(widgets.music, 250),
                    block(M.group(
                        widgets.playback, widgets.capture, widgets.backlight)),
                    block(M.group(widgets.ping, widgets.vpn)),
                    block(M.group(widgets.ram, widgets.disk, widgets.temp)),
                    scroll(widgets.push),
                }
            },
            {
                widget = wibox.container.margin,
                left = 1,
                right = 1,
            },
            {
                widget = wibox.container.place,
                halign = 'right',
                {
                    layout = wibox.layout.align.horizontal,
                    spacing = 1,
                    {
                        widget = wibox.container.constraint,
                        width = 400,
                        {
                            widget = wibox.container.place,
                            fill_horizontal = true,
                            halign = 'right',
                            {
                                layout = wibox.layout.flex.horizontal,
                                spacing = 1,
                                scroll(widgets.connection),
                                scroll(widgets.bluetooth),
                            },
                        },
                    },
                    {
                        widget = wibox.container.margin,
                        right = 1,
                    },
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = 1,
                        block(M.group(
                            widgets.mail, widgets.news, widgets.download)),
                        block(M.group(widgets.battery)),
                        block(M.group(widgets.timedate)),
                        block(M.group(s.menus.service), theme.iconsize),
                        block(M.group(s.menus.menu), theme.iconsize),
                    },
                },
            },
        },
        left = 1,
        right = 1,
        top = 1,
        widget = wibox.container.margin,
    }

    s.topbar:get_children_by_id('topbar')[1]:ajust_ratio(2, 0.6, 0, 0.4)

    s.leftbar:setup {
        {
            layout = wibox.layout.align.vertical,
            spacing = 1,
            expand = 'none',
            {
                layout = wibox.layout.fixed.vertical,
                spacing = 1,
                block(M.group(s.menus.search)),
                s.tasklist,
            },
            {
                widget = wibox.container.margin,
                top = 1,
                bottom = 1,
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = 1,
                    block(s.taglist),
                },
            },
            {
                layout = wibox.layout.fixed.vertical,
                spacing = 1,
                block(M.group(s.menus.screenshot)),
                block(M.group(s.menus.cheat)),
                block(M.group(s.menus.vocab)),
                block(M.group(s.menus.clip)),
                block(M.group(s.menus.pass)),
                block(M.group(s.menus.mark)),
                block(M.group(s.menus.contact)),
                block(M.group(s.menus.settings)),
                block(M.group(s.menus.power)),
            },
        },
        left = 1,
        bottom = 1,
        top = 0,
        widget = wibox.container.margin,
    }

end)
