export ZSH="$HOME/.oh-my-zsh"

if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "/opt/homebrew/opt/llvm/bin" ]; then
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "$HOME/.local/bin/mise" ]; then
	eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

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

if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
	source "/usr/share/nvm/init-nvm.sh"
fi

# User configuration
export EDITOR=nvim
export TERMINAL=wezterm

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias get_idf='. /opt/esp-idf/export.sh'

# >>> ZINIT AUTO CONFIG START >>>
# Проверяем, установлен ли Zinit, прежде чем что-то запускать
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ -f "${ZINIT_HOME}/zinit.zsh" ]; then
    # Источник Zinit
    source "${ZINIT_HOME}/zinit.zsh"

    # Автодополнение для команды zinit
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    # ==============================================================================
    # ПЛАГИНЫ
    # ==============================================================================
    zinit light zsh-users/zsh-autosuggestions
    zinit light zdharma-continuum/fast-syntax-highlighting
    zinit light zdharma-continuum/history-search-multi-word

    # Оптимальный compinit с cdreplay
    autoload -Uz compinit
    compinit
    zinit cdreplay -q
else
    # Если Zinit пропал, просто дефолтный compinit
    autoload -Uz compinit
    compinit
fi
# <<< ZINIT AUTO CONFIG END <<<
