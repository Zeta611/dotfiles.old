# Load zplug
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "djui/alias-tips"

zplug "zsh-users/zsh-autosuggestions"

zplug "zdharma/fast-syntax-highlighting"

zplug "djui/alias-tips"

zplug "gretzky/auto-color-ls"

zplug "Tarrasch/zsh-bd"

zplug "zuxfoucault/colored-man-pages_mod"

zplug "b4b4r07/emoji-cli"

if zplug check b4b4r07/emoji-cli; then
    EMOJI_CLI_KEYBIND="^E"
fi

zplug "bhilburn/powerlevel9k", \
    use:powerlevel9k.zsh-theme

if zplug check bhilburn/powerlevel9k; then
    POWERLEVEL9K_MODE='nerdfont-complete'

    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uf179  "

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs pyenv)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs date time battery)

    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'

    POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
    POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf408 "

    POWERLEVEL9K_BATTERY_LOW_THRESHOLD=30
    POWERLEVEL9K_BATTERY_STAGES=($'\uf582 ' $'\uf579 ' $'\uf57a ' $'\uf57b ' $'\uf57c ' $'\uf57d ' $'\uf57e ' $'\uf57f' $'\uf580 ' $'\uf581 ' $'\uf578')
    POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(darkred orange4 yellow4 yellow4 chartreuse3 green3 green4 darkgreen)
fi

zplug "plugins/colorize", \
    from:oh-my-zsh

zplug "plugins/command-not-found", \
    from:oh-my-zsh

zplug "plugins/copydir", \
    from:oh-my-zsh

zplug "plugins/copyfile", \
    from:oh-my-zsh

zplug "plugins/extract", \
    from:oh-my-zsh

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

# terminal color
export TERM="xterm-256color"

# custom script location
export PATH="$HOME/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gpg
export GPG_TTY=$(tty)

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    # eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
    eval $(gpg-agent --daemon)
fi

# thefuck
eval $(thefuck --alias)

# colorls configuration
source $(dirname $(gem which colorls))/tab_complete.sh

# autojump configuration
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iterm2 configuration
source ~/.iterm2_shell_integration.zsh

# aliases
alias ls='colorls -lA --sd'
alias clr='clear'
alias finder='open ~'
alias setzsh='nvim ~/.zshrc&&source ~/.zshrc'
alias setnvim='nvim ~/.config/nvim/init.vim'
alias sethyper='nvim ~/.hyper.js&&source ~/.zshrc'
alias weather='ansiweather'
alias forcast='ansiweather -F'
alias v='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim'
alias nvr='/Users/jay/.pyenv/versions/neovim3/bin/nvr'
alias cat='ccat'
alias src='source ~/.zshrc'
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'

# gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
