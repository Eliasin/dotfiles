export EDITOR=/usr/bin/nano
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
. "$HOME/.cargo/env"
# Add doom to path
export PATH=$PATH:/home/steven/.emacs.d/bin
# Add local binaries to path
export PATH=$PATH:/home/steven/.local/bin
# Add npm local binaries to path
export PATH=$PATH:/home/steven/.npm-global/bin
# Add zig to path
export PATH=$PATH:/home/steven/.local/lib/zig-linux-x86_64-0.10.1
export EDITOR=nvim

export XCURSOR_SIZE=24
export MOZ_ENABLE_WAYLAND=1
export OBSIDIAN_USE_WAYLAND=1

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gcr/ssh"

