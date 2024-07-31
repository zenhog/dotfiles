config.load_autoconfig(False)

c.content.webgl = True
c.content.canvas_reading = False
c.content.pdfjs = False
c.content.images = True

c.content.notifications.enabled = False
c.content.autoplay = False
c.content.geolocation = False

c.content.javascript.enabled = True

c.content.media.audio_capture = True
c.content.media.video_capture = True
c.content.media.audio_video_capture = True

c.scrolling.bar = 'never'
c.input.forward_unbound_keys = 'all'
c.new_instance_open_target = 'tab'

c.content.default_encoding = 'utf-8'

c.content.blocking.enabled = True
c.content.blocking.method = 'adblock'
c.content.blocking.hosts.lists = ['file:///dev/null']
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist.to/easylist/fanboy-social.txt',

    'https://secure.fanboy.co.nz/fanboy-annoyance.txt',
    'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt',

    'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt',

    'https://anti-ad.net/easylist.txt',
    'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=1&mimetype=plaintext',
    'https://dl.red.flag.domains/red.flag.domains.txt',

    'https://www.i-dont-care-about-cookies.eu/abp/',

    "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts",
    "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt",
    "https://fanboy.co.nz/fanboy-problematic-sites.txt",
    "https://raw.githubusercontent.com/bogachenko/fuckfuckadblock/master/fuckfuckadblock.txt",

    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/pgl.yoyo.org/as/serverlist",

    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-others.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2022.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2023.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2024.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-mobile.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/ubo-link-shorteners.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/ubol-filters.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt',
    'file:///tmp/blacklist.txt',
]

c.scrolling.smooth = False

c.statusbar.show = 'always'
c.statusbar.position = 'top'
c.statusbar.padding = {'bottom': 1, 'left': 0, 'right': 0, 'top': 1}

#   - text:foo: Display the static text after the colon, `foo` in the example.
c.statusbar.widgets = ['keypress', 'search_match', 'url', 'scroll', 'history', 'tabs', 'progress']

c.tabs.background = True

c.tabs.show = 'always'
c.tabs.position = 'left'

c.tabs.title.format = '{index}'
c.tabs.title.format_pinned = '{index}'
c.tabs.show_switching_delay = 800
c.tabs.width = 50
c.tabs.min_width = 45
c.tabs.max_width = 45

c.tabs.padding = {'bottom': 5, 'left': 2, 'right': 2, 'top': 5}
c.tabs.indicator.padding = {'bottom': 2, 'left': 1, 'right': 5, 'top': 2}
c.tabs.undo_stack_size = -1
c.tabs.favicons.scale = 1
c.tabs.indicator.width = 3

c.url.yank_ignored_parameters = ['ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content', 'utm_name']

c.downloads.open_dispatcher = 'rifle'

c.downloads.position = 'bottom'
c.downloads.location.remember = False
c.downloads.location.suggestion = "both"
c.downloads.location.directory = '~/downloads'

c.completion.height = '30%'
c.completion.scrollbar.width = 10
c.completion.use_best_match = True
c.completion.open_categories = ["bookmarks", "history", "quickmarks",
                                "searchengines", "filesystem"]

c.bindings.key_mappings = {}

c.content.cookies.accept = 'all'
c.auto_save.session = True

c.editor.command = ["gui", "-f", "{file}", "-c", "normal {line}G{column0}l"]

c.downloads.remove_finished = 5000
c.downloads.location.prompt = False

c.tabs.position = 'left'
c.tabs.new_position.unrelated = 'next'

config.source('binds.py')
config.source('theme.py')
