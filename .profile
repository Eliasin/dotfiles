# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add npm toolchain to PATH
export PATH="$PATH:/home/steven/node_modules/bin"

# Add scripts to PATH
export PATH="$PATH:/home/steven/scripts"

# Use vim as default editor
export EDITOR="vim"

# Dump SSL keys to file
#export SSLKEYLOGFILE="/home/steven/ssl"

# Configure nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add opt scripts to path
export PATH="$PATH:/opt/scripts"

# Add pyenv to path
export PATH="/home/steven/.pyenv/bin:$PATH"

# virtualenvwrapper configuration
export VIRTUALENVWRAPPER_PYTHON=/home/steven/.pyenv/shims/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source /usr/local/bin/virtualenvwrapper.sh

# Android Studio configuration
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Unicode support
export LANG='en_US.UTF-8'
export LC_ALL="en_US.UTF-8"

# Add cargo and rust stuff to path
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

# Add emacs doom bins to path
export PATH="$PATH:/home/steven/.emacs.d/bin"

# Add haskell cabal binaries to path
export PATH="$PATH:/home/steven/.cabal/bin"

# Add platformio tools to path
export PATH=$PATH:~/.platformio/penv/bin
