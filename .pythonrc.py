"""Features:
    * Tab completion on Linux and OS x
    * Color prompt
    * Command history
    * Pretty printing
"""

def setup():
    # Imports we need
    import sys, os, readline, atexit, rlcompleter, pprint

    # Bind tab for completion - both os and linux
    # readline.parse_and_bind("bind -e")
    # readline.parse_and_bind("bind ^I rl_complete")
    # readline.parse_and_bind("bind ^R em-inc-search-prev")
    readline.parse_and_bind("tab: complete")

    # Color Support
    class TermColors(dict):
        """Gives easy access to ANSI color codes. Attempts to fall back to no color
        for certain TERM values. (Mostly stolen from IPython.)"""

        COLOR_TEMPLATES = (
            ("Black"       , "0;30"),
            ("Red"         , "0;31"),
            ("Green"       , "0;32"),
            ("Brown"       , "0;33"),
            ("Blue"        , "0;34"),
            ("Purple"      , "0;35"),
            ("Cyan"        , "0;36"),
            ("LightGray"   , "0;37"),
            ("DarkGray"    , "1;30"),
            ("LightRed"    , "1;31"),
            ("LightGreen"  , "1;32"),
            ("Yellow"      , "1;33"),
            ("LightBlue"   , "1;34"),
            ("LightPurple" , "1;35"),
            ("LightCyan"   , "1;36"),
            ("White"       , "1;37"),
            ("Normal"      , "0"),
        )

        NoColor = ''
        _base  = '\001\033[%sm\002'

        def __init__(self):
            if os.environ.get('TERM') in ('xterm', 'xterm-color', 'xterm-256color', 'linux',
                                        'screen', 'screen-256color', 'screen-bce'):
                self.update(dict([(k, self._base % v) for k,v in self.COLOR_TEMPLATES]))
            else:
                self.update(dict([(k, self.NoColor) for k,v in self.COLOR_TEMPLATES]))
    _c = TermColors()

    # Some fancy prompts
    sys.ps1 = '%s>>> %s' % (_c['Green'], _c['Normal'])
    sys.ps2 = '%s... %s' % (_c['Red'], _c['Normal'])

    # Enable Pretty Printing for stdout
    def my_displayhook(value):
        if value is not None:
            _ = value
            pprint.pprint(value)
    sys.displayhook = my_displayhook

    # Read the existing history if there is one
    histfile = "%s/.pyhistory" % os.environ["HOME"]
    if os.path.exists(histfile):
        readline.read_history_file(histfile)

    # Set maximum number of items that will be written to the history file
    readline.set_history_length(1000)

    def savehist():
        readline.write_history_file(histfile)
    atexit.register(savehist)

setup()
del setup