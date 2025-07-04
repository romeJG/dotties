# ~/.bashrc

[[ $- != *i* ]] && return

# Function to update the prompt dynamically

update_prompt() {
    local user="👤\[\033[1;37m\]\u"
    local host="\[\033[1;34m\]@\h"
    local time="\[\033[1;33m\](\T)"
    local art="\[\033[0;34m\] ̿̿ ̿’̿’̵͇̿̿ \[\033[1;37m\]з=༼ ▀̿̿Ĺ̯̿̿▀̿ ̿ ༽\[\033[1;30m\]"
    local dir="📁\[\033[1;37m\]\w"
    local branch="\$(git_branch)"
    local reset="\[\033[0m\]"

    # Calculate the terminal width
    local term_width=$(tput cols)

    # Calculate the length of the static parts of the prompt
    local prompt1_length=$(( ${#user} + ${#host} + ${#time} + 7 ))  # Length of first part of the prompt
    local prompt2_length=${#art}  # Length of the ASCII art

    # Calculate the length of the fill string
    local fill_length=$(( (term_width - prompt1_length + 12 ) / 2 ))
    local fill=""

    if (( fill_length > 0 )); then
        fill=$(printf '─%.0s' $(seq 1 $fill_length))
    fi

    PS1="\n\[\033[1;35m\]┌─(${user}${host}\[\033[1;35m\])${fill}${time}\[\033[1;31m\]>~\[\033[1;33m\]~\[\033[1;35m\]${fill}\[\033[1;31m\]${art}${reset}\n"
    PS1+="\[\033[1;35m\]├─(${dir}${reset}\[\033[1;35m\]) \[\033[1;35m\]${branch}\n"
    PS1+="\[\033[1;35m\]└─\[\033[35m\](\[\033[1;37m\] ._.\[\033[35m\])⊃\[\033[1;37m\]━\[\033[1;33m\]⛥ ⌒*ﾟ.\[\033[1;37m\]❉・\[\033[1;33m\]゜\[\033[1;37m\]・\[\033[1;33m\].\$ ${reset}"
}

# Ensure the prompt is updated on terminal resize
PROMPT_COMMAND='update_prompt'

shopt -s checkwinsize

# Function to get current git branch


git_branch() {
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n $branch_name ]]; then
        echo -e "\[\033[1;34m\]├─(🌳$branch_name)\[\033[0m\]"
    fi
}

# Initialize the prompt
update_prompt
    alias ls='lsd'
unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root >/dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#my aliasses
alias xampp-start='sudo /opt/lampp/lampp start'
alias xampp-stop='sudo /opt/lampp/lampp stop'

#aqw alias
alias aqw='cd /home/rome/Documents/aqw/ && nohup./Artix_Games_Launcher-x86_64.AppImage'

alias spdtB='speedtest -u MB/s'

alias spdt='speedtest'

alias newt='xfce4-terminal --tab'

alias lsa='lsd -a'
alias lsi='lsd -l'
alias lsia='lsd -la'

alias htdocs='cd /opt/lampp/htdocs/ && lsa'
alias tm='bpytop'

#alias for 	adguard home located in /opt/AdGuardHome/AdGuardHome
# -s  start|stop|restart|status|install|uninstall
alias adguard='sudo /opt/AdGuardHome/AdGuardHome'

#github alias
alias gs='git status'

alias gaa='git add --all'
alias ga='git add'

alias gc='git commit'
alias gcm='git commit -m'

alias gpush='git push'
alias gpull='git pull'

alias glog='git log -4'

#php artisan (laravel)
alias pa='php artisan'

#alias vim for nvim
alias vim='nvim'

alias c='clear'

#neofetch alias
alias nf='neofetch'

# alias for rust dir
alias rustDir='cd Documents/prog/rust'
#on new term neofetch
# neofetch
#alias light="light -S"
#weather
## github https://github.com/chubin/wttr.in

#function made by me :>
# @Param 1 City
#if the city or coordinates are given it will be searched
weather() {
    if [ -n "$1" ]; then
        curl wttr.in/$1?1pnF
    else
        curl wttr.in/?1pqnF
    fi

}


#launch neofetch on open
# neofetch

git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e ' s/* \(.*\)/\n├─(🌳\1)/'
}

eval "$(thefuck --alias)"

[ -f ~/.inshellisense/key-bindings.bash ] && source ~/.inshellisense/key-bindings.bash

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




alias chat-deepseek='~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli -m ~/models/deepseek/deepseek-coder-1.3b-instruct.Q4_K_M.gguf --threads $(nproc)'

alias chat-mistral='~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli \
  -m ~/models/mistral/mistral-7b-instruct-v0.2.Q4_K_M.gguf \
  --color \
  --threads $(nproc)'

alias chat-security=' ~/Documents/Artificial-Inteligence/llama.cpp/build/bin/llama-cli \
  -m ~/models/security-ai/SecurityLLM.Q4_K_M.gguf \
  --color \
  --ctx-size 2048 \
  --threads $(nproc)
  -p "I am running on Linux Manjaro. Avoid suggesting Windows tools or commands unless specified."'
  #

alias bspwm-config="vim ~/.dotfiles/bspwm/.config/bspwm/bspwmrc"
alias picom-config="vim ~/.dotfiles/picom/.config/picom/picom.conf"
alias polybar-config="vim ~/.dotfiles/polybar/.config/polybar/config.ini"
alias shortcuts-config="vim ~/.dotfiles/sxhkd/.config/sxhkd/sxhkdrc"
alias kitty-config="vim ~/.dotfiles/kitty/.config/kitty/kitty.conf"
alias libinput-config="vim ~/.dotfiles/libinput/.config/libinput-gestures.conf"
alias rofi-config="vim ~/.dotfiles/rofi/.config/rofi/config.rasi"
alias wallpaper=nitrogen

alias music=rmpc

export PATH="$HOME/.cargo/bin:$PATH"
