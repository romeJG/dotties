# ===============================
# 🛠 Basic Shell Settings
# ===============================

[[ $- != *i* ]] && return  # Only for interactive shells

shopt -s checkwinsize      # Auto-resize awareness
shopt -s histappend        # Append to history
shopt -s expand_aliases    # Allow aliases in scripts

xhost +local:root >/dev/null 2>&1

# ===============================
# 🎨 Prompt Functions
# ===============================

git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'
}

update_prompt() {
    local user="👤\u"
    local host="@\h"
    local time="(\T)"
    local art="\[\033[1;33m\]✶\[\033[1;37m\]━\[\033[1;35m\]⊂\[\033[1;37m\](\[\033[1;33m\]𓂀\[\033[1;37m\]_\[\033[1;33m\]𓂀 \[\033[1;37m\]𓊃)\[\033[0m\]"


    local dir="\w"

    # Estimate visible static portion manually
    local art_len=28
    local static_visible_len=$(( ${#user} + ${#host} + ${#time} + $art_len ))
    local term_width=$(tput cols)
    local fill_visual_width=$(( (term_width - static_visible_len) / 2 ))

    # Simpler particle set, all assumed to be 1 column wide
    declare -a particle_chars=("." "･" "｡" "☆" "⌒" "❉" "𓂀")
    declare -a particle_chars=("." "･" "｡" "☆" "❉" "✦" "𓂀" "𓁹" "✦" "𓅓" "𓃠")
    local colors=(33 35 36 37 34)

    generate_fill() {
        local target_width=$1
        local output=""
        for ((i = 0; i < target_width; i++)); do
            local idx=$(( RANDOM % ${#particle_chars[@]} ))
            local p="${particle_chars[$idx]}"
            local c="${colors[$RANDOM % ${#colors[@]}]}"
            output+="\[\033[1;${c}m\]$p"
        done
        echo "$output"
    }

    local fill_left fill_right
    local center_offset=3
    fill_left="$(generate_fill "$fill_visual_width - $center_offset")"
    fill_right="$(generate_fill "$fill_visual_width + $center_offset")"

    local branch_name="$(git_branch)"
    local branch=""
    if [[ -n $branch_name ]]; then
        branch="\n\[\033[1;35m\]├─(\[\033[1;32m\]🌳$branch_name\[\033[1;35m\])\[\033[0m\]"
    fi

    PS1="\n\[\033[1;35m\]┌─(\[\033[1;37m\]$user\[\033[1;34m\]$host\[\033[1;35m\])"
    PS1+="${fill_left}\[\033[1;33m\]$time${fill_right}\[\033[1;34m\]$art\[\033[0m\]"
    PS1+="\n\[\033[1;35m\]├─(📁\[\033[1;37m\]$dir\[\033[1;35m\]) ${branch}"
    PS1+="\n\[\033[1;35m\]└─\[\033[35m\](\[\033[1;37m\] ._.\[\033[35m\])⊃\[\033[1;37m\]━"
    PS1+="\[\033[1;33m\]⛥ ⌒*ﾟ.\[\033[1;37m\]❉・\[\033[1;33m\]゜\[\033[1;37m\]・\[\033[1;33m\]..\$ \[\033[0m\]"
}

PROMPT_COMMAND='update_prompt'

# ===============================
# 🔥 Aliases
# ===============================

# File/Directory Aliases
alias ls='lsd'
alias lsa='lsd -a'
alias lsi='lsd -l'
alias lsia='lsd -la'
alias htdocs='cd /opt/lampp/htdocs/ && lsa'
alias rustDir='cd ~/Documents/prog/rust'
alias checkdisk=ncdu

# Terminal & System Tools
alias newt='xfce4-terminal --tab'
alias tm='bpytop'
alias nf='neofetch'
alias wallpaper='nitrogen'

# Network Tools
alias spdtB='speedtest -u MB/s'
alias spdt='speedtest'

# XAMPP
alias xampp-start='sudo /opt/lampp/lampp start'
alias xampp-stop='sudo /opt/lampp/lampp stop'

# AdGuard
alias adguard='sudo /opt/AdGuardHome/AdGuardHome'

# Git Aliases
alias gs='git status'
alias gaa='git add --all'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias glog='git log -4'

# PHP/Laravel
alias pa='php artisan'

# Editor Shortcut
alias vim='nvim'

# Quick Commands
alias c='clear'
alias music='rmpc'

# Config Shortcuts
alias bspwm-config='vim ~/.dotfiles/bspwm/.config/bspwm/bspwmrc'
alias picom-config='vim ~/.dotfiles/picom/.config/picom/picom.conf'
alias polybar-config='vim ~/.dotfiles/polybar/.config/polybar/config.ini'
alias shortcuts-config='vim ~/.dotfiles/sxhkd/.config/sxhkd/sxhkdrc'
alias kitty-config='vim ~/.dotfiles/kitty/.config/kitty/kitty.conf'
alias libinput-config='vim ~/.dotfiles/libinput/.config/libinput-gestures.conf'
alias rofi-config='vim ~/.dotfiles/rofi/.config/rofi/config.rasi'

# AI/LLM Shortcuts
alias chat-deepseek='~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli -m ~/models/deepseek/deepseek-llm-7b-chat.Q4_K_M.gguf --threads $(nproc)'
alias chat-mistral='~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli -m ~/models/mistral/mistral-7b-v0.3.Q5_K_M.gguf --color --threads $(nproc)'
alias chat-skinny-mistral='~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli -m ~/models/mistral/mistral-7b-v0.3.Q5_K_M.gguf --ctx-size 2048 --threads $(nproc) --color'

llm-summarize() {
  chat-mistral -p "Summarize the following podcast in bullet points:
$(cat "$1")"
}

# Voice to text
alias whisper-base='~/Documents/Artificial-Inteligence/whisper.cpp/build/bin/whisper-cli -m ~/Documents/Artificial-Inteligence/whisper.cpp/models/ggml-base.bin --threads $(nproc)'
alias whisper-medium='~/Documents/Artificial-Inteligence/whisper.cpp/build/bin/whisper-cli -m ~/Documents/Artificial-Inteligence/whisper.cpp/models/ggml-medium.bin --threads $(nproc)'

# Audio-to-text processor function
whisper-proc() {
  whisper-medium -f "$1" -otxt -of "$2" --language auto
}
# AQW Launcher
alias aqw='cd ~/Documents/aqw && nohup ./Artix_Games_Launcher-x86_64.AppImage &'

# F1 calendar
alias f1-calendar='/home/rome/Documents/prog/rust/f1/f1_schedule/target/debug/f1_schedule'
alias f1-standings='/home/rome/Documents/prog/rust/f1/f1_driver_standings/target/release/f1_driver_standings'
# ===============================
# 📦 Handy Functions
# ===============================

ex() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz)  tar xzf $1 ;;
            *.bz2)     bunzip2 $1 ;;
            *.rar)     unrar x $1 ;;
            *.gz)      gunzip $1 ;;
            *.tar)     tar xf $1 ;;
            *.tbz2)    tar xjf $1 ;;
            *.tgz)     tar xzf $1 ;;
            *.zip)     unzip $1 ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1 ;;
            *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

weather() {
    echo "Fetching weather ⛅"
    if [[ -n $1 ]]; then
        curl wttr.in/$1?1pnF
    else
        curl wttr.in/?1pqnF
    fi
}

# ===============================
# 🌍 Environment & Tools
# ===============================

export PATH="$HOME/.cargo/bin:$PATH"

eval "$(thefuck --alias)"

[ -f ~/.inshellisense/key-bindings.bash ] && source ~/.inshellisense/key-bindings.bash

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

