
if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_preexec --on-event fish_preexec
    set cmd (string split " " -- $argv[1])[1]
    switch $cmd
        case spotify_player
            set cmd "spotify"
    end
    echo -ne "\033]2;$cmd\007"
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

alias ls='eza --no-quotes'
alias ll='eza -l --icons --header --git --time-style relative --no-quotes'
alias lt='eza -T -L2 --icons --no-quotes'
alias lr='ll --no-permissions --no-user --no-filesize -s age'

alias cal='calcite'
alias sono='sonolite'

alias config='nvim ~/.config/fish/config.fish && exec fish'

set -Ux EDITOR nvim
set -Ux QUTE_CONFIG_DIR ~/.config/qutebrowser
set -Ux WEATHERCRAB_CONFIG ~/.config/weathercrab/wthrr.ron
set -x TEXINPUTS ~/latex/packages//

fish_add_path /Library/TeX/texbin
fish_add_path /Users/valentin/go/bin
fish_add_path /Users/valentin/.pat/bin
fish_add_path /Users/valentin/.rbenv/bin

zoxide init fish | source
set --export PATH $HOME/.pat/bin $PATH

status --is-interactive; and source (rbenv init -|psub)
