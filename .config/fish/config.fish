if status is-interactive
    # Commands to run in interactive sessions can go here

    alias dotfiles='/usr/bin/git --git-dir=$HOME/Dotfiles --work-tree=$HOME'

    if set -q "$EMACS"
        # wal
        cat ~/.cache/wal/sequences
        # To add support for TTYs this line can be optionally added.
        source ~/.cache/wal/colors-tty.sh

        # wpgtk
        #(cat $HOME/.config/wpg/sequences &)

        # Change to vi mode
		# fish_vi_key_bindings
    end

    if test -n "$INSIDE_EMACS"
        set -gx GIT_EDITOR "emacsclient"
        set -gx EDITOR "emacsclient"
    end
    alias edit="$EDITOR"

	# Setup starship
    starship init fish | source

	# Setup rbenv
	status --is-interactive; and rbenv init - fish | source
end

direnv hook fish | source
