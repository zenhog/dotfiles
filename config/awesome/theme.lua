local theme = {}

theme.homedir  = os.getenv('HOME')

theme.wallpaper   = theme.homedir .. '/.wallpapers/main'

theme.textfont_name = 'SpaceMono Nerd Font Mono Bold'
theme.textfont_name = 'VictorMono Nerd Font Mono Bold'
theme.textfont_size = 10
theme.textfont      = theme.textfont_name .. ' ' .. theme.textfont_size

theme.iconfont_name = 'SpaceMono Nerd Font Propo Bold'
theme.iconfont_name = 'VictorMono Nerd Font Propo Bold'
theme.iconfont_size = 10
theme.iconfont      = theme.iconfont_name .. ' ' .. theme.iconfont_size


theme.useless_gap   = 0.5
theme.spacing   = 4
theme.global_radius = 2

theme.wibar_height = 40
theme.wibar_margins = 10

theme.iconsize = theme.iconfont_size * 2
theme.iconsize = theme.wibar_height - theme.spacing

theme.bg_normal  = "#2A393E65"
theme.bg_normal  = "#3A494E75"
theme.bg_normal  = "#70707070"
theme.bg_normal  = "#000000f0"
theme.bg_wrap   = "#00000090"

theme.margin_wrap = 5

theme.tasklist_bg_focus    = '#f0f0f0'
theme.tasklist_bg_normal   = '#606060'
theme.tasklist_bg_urgent   = '#ff6600'
theme.tasklist_bg_minimize = theme.bg_normal

theme.titlebar_bg_focus    = theme.bg_wrap
theme.titlebar_bg_focus   = theme.bg_normal
theme.titlebar_bg_normal    = "#00000030"
theme.titlebar_bg_urgent   = theme.tasklist_bg_urgent

theme.border_width = 1

return theme
