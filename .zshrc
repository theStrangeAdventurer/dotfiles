export ZSH="$HOME/.oh-my-zsh"

# Base PATH
export PATH="$PATH:$HOME/.local/bin"

# Flutter and Android configuration (conditional)
if (( $+commands[flutter] )) || [ -d "$HOME/.flutter/bin" ]; then
    # Add flutter bin only if it's not already in PATH
    [[ ":$PATH:" != *":$HOME/.flutter/bin:"* ]] && export PATH="$PATH:$HOME/.flutter/bin"

    # Android SDK check
    if [ -d "$HOME/Android/Sdk" ]; then
        export ANDROID_HOME="$HOME/Android/Sdk/"
        export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"
        export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
    fi
fi


if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1  ]; then
	exec start-hyprland
fi

if [ -z "${SSH_AUTH_SOCK}" ];then
	eval "$(ssh-agent -s)" > /dev/null
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="intheloop"

plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

source /usr/share/nvm/init-nvm.sh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=nvim

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
ai() {
  local os_name="$(uname -s)"
	local distro=""

	if [ "$os_name" = "Linux" ]; then
		if [ -f /etc/os-release ]; then
			distro=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
		fi
	fi
  aichat --no-stream --prompt "Answer briefly in the user's language. Give advice based on the user's operating system: $os_name $distro. Current working directory: $PWD. If the answer is straightforward and can be expressed in a single bash command, provide ONLY that command without any explanation or formatting." "$*"
}

source /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/completion.zsh

