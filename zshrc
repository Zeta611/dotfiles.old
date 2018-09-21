# Load zplug
source ~/.zplug/init.zsh

zplug "bhilburn/powerlevel9k", \
    use:powerlevel9k.zsh-theme
# zplug denysdovhan/spaceship-prompt, \
#     use:spaceship.zsh, \
#     from:github, \
#     as:theme
#
# SPACESHIP_BATTERY_SHOW=always
# SPACESHIP_BATTERY_SYMBOL_DISCHARGING="\ufa1e "
# SPACESHIP_BATTERY_SYMBOL_CHARGING="\uf1e6 "
# SPACESHIP_BATTERY_SYMBOL_FULL="\uf583 "
# SPACESHIP_BATTERY_THRESHOLD=30

zplug "djui/alias-tips"

#zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zdharma/fast-syntax-highlighting"

zplug "djui/alias-tips"

zplug "gretzky/auto-color-ls"

zplug "Tarrasch/zsh-bd"

zplug "zuxfoucault/colored-man-pages_mod"

zplug "b4b4r07/emoji-cli"
EMOJI_CLI_KEYBIND="^E"

zplug "changyuheng/zsh-interactive-cd"

zplug "amstrad/oh-my-matrix"

zplug "wbingli/zsh-wakatime"

# install & load zplug plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
    echo
fi
zplug load

# autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# terminal color
export TERM="xterm-256color"

# powerlevel9k configuration
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uf179  "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs date time battery)

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'

POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf408 "

POWERLEVEL9K_BATTERY_LOW_THRESHOLD=30
POWERLEVEL9K_BATTERY_STAGES=($'\uf582 ' $'\uf579 ' $'\uf57a ' $'\uf57b ' $'\uf57c ' $'\uf57d ' $'\uf57e ' $'\uf57f' $'\uf580 ' $'\uf581 ' $'\uf578')
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(darkred orange4 yellow4 yellow4 chartreuse3 green3 green4 darkgreen)

# colorls configuration
source $(dirname $(gem which colorls))/tab_complete.sh

# thefuck
eval $(thefuck --alias)

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gpg
export GPG_TTY=$(tty)

# aliases
alias ll='ls -l'
alias ls='colorls'
alias clr='clear'
alias finder='open ~'
alias setzsh='nvim ~/.zshrc&&source ~/.zshrc'
alias setnvim='nvim ~/.config/nvim/init.vim'
alias sethyper='nvim ~/.hyper.js&&source ~/.zshrc'
alias weather='ansiweather'
alias forcast='ansiweather -F'
alias v='nvim'
alias vim='nvim'
