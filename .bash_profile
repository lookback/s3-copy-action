source ~/.bashrc

##
# Your previous /Users/littke/.bash_profile file was backed up as /Users/littke/.bash_profile.macports-saved_2011-01-22_at_21:30:39
##

# MacPorts Installer addition on 2011-01-22_at_21:30:39: adding an appropriate PATH variable for use with MacPorts.
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
# Finished adapting your PATH environment variable for use with MacPorts.


export MAGICK_HOME="$HOME/bin/ImageMagick-6.6.7"
export PATH="$PATH:$MAGICK_HOME/bin"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
