# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# Add MacPorts bin directories on Mac.
if [ "$(uname)" == "Darwin" ]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi
