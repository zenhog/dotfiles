package.loaded["naughty.dbus"] = {}
local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

require('awful.autofocus')

local theme = require('beautiful')

--local dbus = nil
local naughty = require('naughty')

theme.init(os.getenv('HOME') .. '/.config/awesome/theme.lua')

local keys = require('keys')
local wibars = require('wibars')


local function handle_errors()
    if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = 'Startup errors',
        text = awesome.startup_errors,
    }
    end

    do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        if in_error then return end
        in_error = true
        naughty.notify {
            preset = naughty.config.presets.critical,
            title = 'Runtime error',
            text = tostring(err),
        }
        in_error = false
    end)
    end
end

local function set_clienticon(c)
    local homedir = os.getenv('HOME')

    local contents, environ, envicon, envfile

    if c.pid and c.pid ~= 6 then
        envicon = io.popen('getenv ' .. c.pid .. ' ICON'):read('all*')

        --envfile = string.format('/proc/%u/environ', c.pid)
        --envfile = '/proc/' .. c.pid .. '/environ'
        --log(string.format('got envfile:%s', envfile))

        --if gears.filesystem.file_readable(envfile) then
        --    contents = io.open(envfile)
        --    log(string.format('file readable and contents=%s',contents))
        --    if contents then
        --        environ = contents:read('all*')
        --        contents:close()
        --    log(string.format('environ read: %s',environ))
        --    end
        --end
        --    log(string.format('environ read: %s',environ))

        --if environ then
        --    for var in string.gmatch(environ, '[^\x00]+') do
        --        if var:match('^ICON=') then
        --            envicon = var:match('^ICON=(%S+)\x00')
        --        end
        --    log(string.format('environ read: %s',environ))
        --    end
        --end
        --    log(string.format('environ read: %s',environ))
    end

    if envicon == '' then
        envicon = nil
    end

    c.profile = c.profile or envicon or ''
    c.profile = envicon or c.profile

    if not c.profile and not c.class and not c.instance then
        return
    end

    c.profile = c.profile or string.lower(c.class)


    local iconpath = string.format('%s/.icons/%s.png', homedir, c.profile)

    if gears.filesystem.file_readable(iconpath) then
        os.execute(string.format('xseticon -id 0x%08x %s', c.window, iconpath))
    end
end

local function set_clientimg(c)
    local cairo = require("lgi").cairo
    local homedir = os.getenv('HOME')

    if c and c.valid then
        local icon

        if c.profile then
          icon = string.format('%s/.icons/%s.png', homedir, c.profile)
        else
          icon = homedir .. '/.icons/default.png'
        end

        local s = gears.surface(icon)

        local img = cairo.ImageSurface.create(
          cairo.Format.ARGB32, s:get_width(), s:get_height())
        local cr = cairo.Context(img)

        cr:set_source_surface(s, 0, 0)
        cr:paint()

        c.icon = img._native
    end
end

local function set_clienttag(c)
    local tags = c.screen.tags
    local homedir = os.getenv('HOME')

    if c.instance == 'loop' then
        c:move_to_tag(tags[5])
        return
    end

    local path = function(p)
      local homedir = os.getenv('HOME')
      return string.format('%s/.icons/%s.png', homedir, p)
    end

    c.profile = c.profile or string.lower(c.instance or '')

    if not gears.filesystem.file_readable(path(c.profile)) then
      c.profile = string.lower(c.instance or '')
    end

    local hostname = os.getenv('HOSTNAME')

    if c.profile == hostname then
      c.profile = 'main'
    end

    if not gears.filesystem.file_readable(path(c.profile)) then
      c.profile = string.lower(c.class)
    end

    if not gears.filesystem.file_readable(path(c.profile)) then
      c.profile = nil
    end

    local tagmap = {
        main      = 1,
        tmux      = 1,
        rmux      = 1,
        urxvt     = 1,
        alacritty = 1,
        kitty     = 1,
        ctfbox    = 1,
        cutter    = 1,

        Navigator = 2,
        firefox   = 2,
        wanfox    = 2,
        wanqute   = 2,
        mupdf     = 2,

        vpnfox    = 3,
        vpnqute   = 3,
        feh       = 3,
        nsxiv     = 3,
        chromium  = 3,

        discord   = 4,
        spotify   = 4,
        vlc       = 4,

        stremio   = 5,
        steam     = 5,
        retroarch = 5,
    }

    local tagnum = tagmap[c.profile] or 5

    c:move_to_tag(tags[tagnum])
end

local function set_titlebars(c)
    if c.instance == 'loop' then
        return
    end

    awful.titlebar(c, {
        size = 0,
        position = 'top',
        bg_normal = 'gray',
        bg_focus = 'darkgray',
    })
end

local function set_attributes(c)
  local s = awful.screen.focused()
  local w, h = s.geometry.width, s.geometry.height

  if c.class == 'menu' and c.instance == 'loop' then
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
    c.width = w / 1.2
    c.height = h / 1.2
    c.x = w / 2 - c.width / 2
    c.y = h / 2 - c.height / 2
  end

end

local roundedrect = function(cr, w, h, r)
  return gears.shape.rounded_rect(cr, w, h, theme.global_radius / 2)
end

client.connect_signal("manage", function(c)
  c.shape = roundedrect

  set_clienttag(c)
  set_titlebars(c)
  set_attributes(c)
  set_clientimg(c)

  if awesome.startup and not c.size_hints.user_position and
    not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

local function focus_menu()
  for _, ct in ipairs(client.get()) do
    if ct.instance == 'loop' and ct.hidden == false then
      client.focus = ct
    end
  end
end

client.connect_signal("focus", function(c, context)
    focus_menu()
end)

client.connect_signal("request::activate", function(c, context)
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
      titlebars_enabled = true,
      fullscreen = false,
      floating = false,
      requests_no_titlebar = false,
      placement = awful.placement.no_overlap +
        awful.placement.no_offscreen,
    },
  },
}

awful.spawn.with_shell('autostart', awful.rules.rules)
