
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

def bind(key, *commands, mode='normal'):
    config.bind(key, ' ;; '.join(commands), mode=mode)

def unbind(key, mode='normal'):
    config.unbind(key, mode=mode)

# key to adblock-update and clearup
# key to save session
# key to open tabs/bookmarks/quickmarks?
# key to 
# key to whitelist some site
# key to block some site

unbind('m')
unbind('M')
unbind('b')
unbind('B')
unbind('T')
#unbind('t')

bind('<Ctrl-S>', 'session-save')
#bind('<Ctrl-X><Ctrl-S>', 'session-load')
#bind('<Ctrl-X><Ctrl-C>', 'config-source')
bind('<Ctrl-V>', 'spawn mpv {url}')
bind('<Ctrl+/>', 'hint links spawn --detach mpv {hint-url}')

bind('<Ctrl-Return>', 'spawn --userscript reload')
bind('<Ctrl-A>', 'spawn --userscript whitelist {url:host}')
bind('<Ctrl-B>', 'spawn --userscript blacklist {url:host}')

bind('<Ctrl-M>', 'spawn --userscript menurun mark {url}')
bind('<Ctrl-O>', 'spawn --userscript menurun unmark {url}')

bind('<Ctrl-Y>', 'spawn --userscript menurun passinit {url:host} {url}')

bind('<Ctrl-E>', 'spawn --userscript menurun grab username {url:host}', mode = 'insert')
bind('<Ctrl-R>', 'spawn --userscript menurun grab password {url:host}', mode = 'insert')

bind('<Alt-Tab>', 'spawn --userscript tabs')
