# default theme, also embedded in the source of fast-syntax-highlighting
# removed any bg modifications

#[base]
FAST_HIGHLIGHT_STYLES[default]=none
FAST_HIGHLIGHT_STYLES[unknown-token]=red,bold
FAST_HIGHLIGHT_STYLES[commandseparator]=none
FAST_HIGHLIGHT_STYLES[redirection]=none
FAST_HIGHLIGHT_STYLES[here-string-tri]=yellow
FAST_HIGHLIGHT_STYLES[here-string-text]=18
FAST_HIGHLIGHT_STYLES[here-string-var]=cyan
FAST_HIGHLIGHT_STYLES[exec-descriptor]=yellow,bold
FAST_HIGHLIGHT_STYLES[comment]=black,bold
FAST_HIGHLIGHT_STYLES[correct-subtle]=12
FAST_HIGHLIGHT_STYLES[incorrect-subtle]=red
FAST_HIGHLIGHT_STYLES[subtle-separator]=green
FAST_HIGHLIGHT_STYLES[subtle-bg]=cyan
FAST_HIGHLIGHT_STYLES[secondary]=free
#; recursive-base   =

#[command-point]
FAST_HIGHLIGHT_STYLES[reserved-word]=yellow
FAST_HIGHLIGHT_STYLES[subcommand]=yellow
FAST_HIGHLIGHT_STYLES[alias]=green
FAST_HIGHLIGHT_STYLES[suffix-alias]=green
FAST_HIGHLIGHT_STYLES[global-alias]=cyan
FAST_HIGHLIGHT_STYLES[builtin]=green
FAST_HIGHLIGHT_STYLES[function]=green
FAST_HIGHLIGHT_STYLES[command]=green
FAST_HIGHLIGHT_STYLES[precommand]=green
FAST_HIGHLIGHT_STYLES[hashed-command]=green
FAST_HIGHLIGHT_STYLES[single-sq-bracket]=green
FAST_HIGHLIGHT_STYLES[double-sq-bracket]=green
FAST_HIGHLIGHT_STYLES[double-paren]=yellow

#[paths]
FAST_HIGHLIGHT_STYLES[path]=magenta
FAST_HIGHLIGHT_STYLES[pathseparator]=cyan
FAST_HIGHLIGHT_STYLES[path-to-dir]=red,bold
FAST_HIGHLIGHT_STYLES[globbing]=blue,bold
FAST_HIGHLIGHT_STYLES[globbing-ext]=13

#[brackets]
FAST_HIGHLIGHT_STYLES[paired-bracket]=cyan
FAST_HIGHLIGHT_STYLES[bracket-level-1]=green,bold
FAST_HIGHLIGHT_STYLES[bracket-level-2]=yellow,bold
FAST_HIGHLIGHT_STYLES[bracket-level-3]=cyan,bold

#[arguments]
FAST_HIGHLIGHT_STYLES[single-hyphen-option]=cyan
FAST_HIGHLIGHT_STYLES[double-hyphen-option]=cyan
FAST_HIGHLIGHT_STYLES[back-quoted-argument]=none
FAST_HIGHLIGHT_STYLES[single-quoted-argument]=yellow
FAST_HIGHLIGHT_STYLES[double-quoted-argument]=yellow
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]=yellow

#[in-string]
#; backslash in $'...'
FAST_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=cyan
#; backslash or $... in "..."
FAST_HIGHLIGHT_STYLES[back-or-dollar-double-quoted-argument]=cyan

#[other]
FAST_HIGHLIGHT_STYLES[variable]=113
FAST_HIGHLIGHT_STYLES[assign]=none
FAST_HIGHLIGHT_STYLES[assign-array-bracket]=green
FAST_HIGHLIGHT_STYLES[history-expansion]=blue,bold

#[math]
FAST_HIGHLIGHT_STYLES[mathvar]=blue,bold
FAST_HIGHLIGHT_STYLES[mathnum]=magenta
FAST_HIGHLIGHT_STYLES[matherr]=red

#[for-loop]
FAST_HIGHLIGHT_STYLES[forvar]=none
FAST_HIGHLIGHT_STYLES[fornum]=magenta
#; operator
FAST_HIGHLIGHT_STYLES[foroper]=yellow
#; separator
FAST_HIGHLIGHT_STYLES[forsep]=yellow,bold

#[case]
FAST_HIGHLIGHT_STYLES[case-input]=green
FAST_HIGHLIGHT_STYLES[case-parentheses]=yellow
FAST_HIGHLIGHT_STYLES[case-condition]=cyan
