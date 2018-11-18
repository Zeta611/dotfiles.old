# zmodload zsh/zprof
# Load zplug
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
export PATH=/usr/local/opt/ruby/bin:$PATH
export TERM="xterm-256color"
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"

zplug "zdharma/fast-syntax-highlighting", defer:2

zplug "Tarrasch/zsh-bd"

zplug "wting/autojump"

zplug "zuxfoucault/colored-man-pages_mod", lazy:on

zplug "b4b4r07/emoji-cli", lazy:on

if zplug check b4b4r07/emoji-cli; then
    EMOJI_CLI_KEYBIND="^E"
fi

zplug "Zeta611/powerlevel9k", \
    use:powerlevel9k.zsh-theme, \
    at:no-match-found-handle

if zplug check Zeta611/powerlevel9k; then
    P9K_MODE='nerdfont-complete'

    P9K_PROMPT_ADD_NEWLINE=true
    P9K_PROMPT_ON_NEWLINE=true
    P9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON=""
    P9K_MULTILINE_LAST_PROMPT_PREFIX_ICON="%{%B%F{red}%}ζ "

    # P9K_LEFT_PROMPT_ELEMENTS=(user dir vcs pyenv)
    P9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
    P9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs date time battery)

    P9K_LEFT_SEGMENT_SEPARATOR_ICON=$'\uE0B0'
    P9K_RIGHT_SEGMENT_SEPARATOR_ICON=$'\uE0B2'

    P9K_VCS_BRANCH_ICON='\uF126 '
    P9K_VCS_GIT_GITHUB_ICON="\uf408 "

    P9K_BATTERY_LOW_THRESHOLD=30
    P9K_BATTERY_STAGES=($'\uf582 ' $'\uf579 ' $'\uf57a ' $'\uf57b ' $'\uf57c ' $'\uf57d ' $'\uf57e ' $'\uf57f' $'\uf580 ' $'\uf581 ' $'\uf578')
    P9K_BATTERY_LEVEL_BACKGROUND=(darkred orange4 yellow4 yellow4 chartreuse3 green3 green4 darkgreen)

    P9K_DIR_SHORTEN_LENGTH=1
    P9K_DIR_SHORTEN_DELIMITER=""
    # P9K_DIR_SHORTEN_STRATEGY=truncate_from_right
    P9K_DIR_SHORTEN_STRATEGY=truncate_to_unique

    P9K_TIME_FORMAT="%D{%H:%M:%S}"
    P9K_DATE_FORMAT="%D{%m/%d}"

    P9K_USER_DEFAULT_ICON="\uF415"
    P9K_USER_ROOT_ICON="#"
    P9K_USER_SUDO_ICON=$'\uF09C'
fi

zplug "changyuheng/zsh-interactive-cd"

zplug "wbingli/zsh-wakatime"

zplug load

# compinit check for rebuilding the dump & calling compaudit once a day
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# custom script location
export PATH="$HOME/Developer/bin:$PATH"

# lazily load pyenv
eval "$(pyenv init -)"

# gpg
export GPG_TTY=$(tty)

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    {
        eval $(gpg-agent --daemon)
    } &> /dev/null
fi

# thefuck
fuck() {
    unset -f fuck
    eval $(thefuck --alias)
    fuck "$@"
}

# colorls configuration
colorls() {
    unset -f colorls
    source $(dirname $(gem which colorls))/tab_complete.sh
    colorls "$@"
}

 # autojump configuration
j() {
    unset -f j
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
    j "$@"
}

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iterm2 configuration
source ~/.iterm2_shell_integration.zsh

# gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# aliases
alias l='colorls -l --sd'
alias la='colorls -lA --sd'
alias ldir='colorls -ldA'
alias lf='colorls -lfA'
alias clr='clear'
alias finder='open .'
alias setzsh='nvim ~/.zshrc&&source ~/.zshrc'
alias setnvim='nvim ~/.config/nvim/init.vim'
alias sethyper='nvim ~/.hyper.js&&source ~/.zshrc'
alias weather='ansiweather'
alias forcast='ansiweather -F'
alias v='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim'
alias nvr='/Users/jay/.pyenv/versions/neovim3/bin/nvr'
alias refreshnvr='rm /tmp/nvimsocket'
alias src='source ~/.zshrc'
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias tmdisablethrottle='sudo sysctl debug.lowpri_throttle_enabled=0'
alias tmenablethrottle='sudo sysctl debug.lowpri_throttle_enabled=1'
# zprof
