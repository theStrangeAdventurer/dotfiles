export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1  ]; then
	exec start-hyprland
fi

if [ -z "${SSH_AUTH_SOCK}" ];then
	eval "$(ssh-agent -s)" > /dev/null
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source /usr/share/nvm/init-nvm.sh
source $ZSH/oh-my-zsh.sh


# User configuration
export EDITOR=nvim

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

