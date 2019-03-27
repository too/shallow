# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:$PATH
# Load .bashrc if it exists
if [ -f ~/.bashrc ];
    then source ~/.bashrc 
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

##
# Your previous /Users/too/.bash_profile file was backed up as /Users/too/.bash_profile.macports-saved_2013-03-21_at_00:51:30
##

# MacPorts Installer addition on 2013-03-21_at_00:51:30: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/too/.bash_profile file was backed up as /Users/too/.bash_profile.macports-saved_2013-03-21_at_19:54:08
##

# MacPorts Installer addition on 2013-03-21_at_19:54:08: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
# export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
