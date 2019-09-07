#! /usr/bin/env bash

# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=vim

PS1='\[\e[34m\]\u@\h\[\e[m\] \[\e[33m\]\W\[\e[m\] \$ '

export XDG_CONFIG_DIRS=~/.config
export XDG_CONFIG_HOME=~/.config
export RTV_BROWSER='w3m'

# tab complete even with sudo
complete -cf sudo

# add scripts to path
NPATH="$HOME/.scripts"
case ":${PATH}:" in
	*:${NPATH}:*) ;;
	*) PATH=${PATH}:$NPATH ;;
esac
# add dotnet tools to path
NPATH="$HOME/.dotnet/tools"
case ":${PATH}:" in
	*:${NPATH}:*) ;;
	*) PATH=${PATH}:$NPATH ;;
esac

# environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export CMAKE_GENERATOR="Unix Makefiles"

# aliases
alias ls='ls --color=auto'
alias celar='clear'
alias :q='exit'
alias :e='vim'
alias :h='man'
alias l='ls'
alias la='ls -A'
alias lht='ls -lht'
alias laht='ls -Alht'
alias lahtless='ls -Alht --color=always | \less -r'
alias neofetch='echo && neofetch'
alias pacfetch='neofetch && pacinfo.sh && echo'
alias nano='nano -m' # adds mouse interactions
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,OWNER,MOUNTPOINT'
alias pgrep='pgrep -fil'
alias df='df -h'
alias mv='mv -iv'
alias cp='cp -iv'
alias chmod='chmod -v'
alias chown='chown -v'
alias dd='dd status=progress'
alias rm='trash-put'
alias sudo='sudo -E ' # run sudo with user env and aliases
alias cat='bat'
alias less='bat'
alias cd..='cd ..'
alias mirrors='pacman-mirrors -c United_States'
#alias ssh='sshrc'
alias pacman-inter="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -r sudo pacman -S"
alias yay-inter="yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -r sudo yay -S"

## Section requiring X session to be running:
if [ "$TERM" != "linux" ] && [ "x${SSH_TTY}" = "x" ]; then
	# swap caps lock and escape
	(setxkbmap -option caps:swapescape &)

	# add powerline
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	# . /usr/share/powerline/bindings/bash/powerline.sh
	source /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

	# autohide mouse when inactive
	(pkill unclutter)
	(nohup unclutter -idle 2 -jitter 10 -root > /dev/null 2>&1 &)
fi

# add fzf keybindings
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

