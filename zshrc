# Load zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

timer=$(($(gdate +%s%N)/1000000))
plugin='zsh-autosuggestions'
zplug "zsh-users/zsh-autosuggestions"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='fast-syntax-highlighting'
zplug "zdharma/fast-syntax-highlighting", defer:2
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='zsh-bd'
zplug "Tarrasch/zsh-bd"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='autojump'
zplug "wting/autojump"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='colored-man-pages_mod'
zplug "zuxfoucault/colored-man-pages_mod"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='emoji-cli'
zplug "b4b4r07/emoji-cli", lazy:on

if zplug check b4b4r07/emoji-cli; then
    EMOJI_CLI_KEYBIND="^E"
fi
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='powerlevel9k'
zplug "bhilburn/powerlevel9k", \
    use:powerlevel9k.zsh-theme

if zplug check bhilburn/powerlevel9k; then
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
fi
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='zsh-interactive-cd'
zplug "changyuheng/zsh-interactive-cd"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='zsh-wakatime'
zplug "wbingli/zsh-wakatime"
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

timer=$(($(gdate +%s%N)/1000000))
plugin='load'
zplug load
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# terminal color
export TERM="xterm-256color"

# custom script location
export PATH="$HOME/bin:$PATH"

# lazily load pyenv
timer=$(($(gdate +%s%N)/1000000))
plugin='pyenv'
if type pyenv &> /dev/null; then
    local PYENV_SHIMS="${PYENV_ROOT:-${HOME}/.pyenv}/shims"
    export PATH="${PYENV_SHIMS}:${PATH}"
    function pyenv() {
        unset pyenv
        eval "$(command pyenv init -)"
        pyenv $@
    }
fi
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# gpg
timer=$(($(gdate +%s%N)/1000000))
plugin='gpg'
export GPG_TTY=$(tty)

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    {
        eval $(gpg-agent --daemon)
    } &> /dev/null
fi
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# thefuck
timer=$(($(gdate +%s%N)/1000000))
plugin='thefuck'
fuck() {
    unset -f fuck
    eval $(thefuck --alias)
    fuck "$@"
}
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# colorls configuration
timer=$(($(gdate +%s%N)/1000000))
plugin='colorls'
colorls() {
    unset -f colorls
    source $(dirname $(gem which colorls))/tab_complete.sh
    colorls "$@"
}
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# autojump configuration
timer=$(($(gdate +%s%N)/1000000))
plugin='autojump'
j() {
    unset -f j
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
    j "$@"
}
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# fzf configuration
timer=$(($(gdate +%s%N)/1000000))
plugin='fzf'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# iterm2 configuration
timer=$(($(gdate +%s%N)/1000000))
plugin='iterm2'
source ~/.iterm2_shell_integration.zsh
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# aliases
timer=$(($(gdate +%s%N)/1000000))
plugin='aliases'
alias la='colorls -lA --sd'
alias ls='colorls -l --sd'
alias ldir='colorls -ldA'
alias lf='colorls -lfA'
alias clr='clear'
alias finder='open ~'
alias setzsh='nvim ~/.zshrc&&source ~/.zshrc'
alias setnvim='nvim ~/.config/nvim/init.vim'
alias sethyper='nvim ~/.hyper.js&&source ~/.zshrc'
alias weather='ansiweather'
alias forcast='ansiweather -F'
alias v='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim'
alias nvr='/Users/jay/.pyenv/versions/neovim3/bin/nvr'
alias src='source ~/.zshrc'
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin

# gitignore.io
timer=$(($(gdate +%s%N)/1000000))
plugin='gitignore.io'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
now=$(($(gdate +%s%N)/1000000))
elapsed=$(($now-$timer))
echo $elapsed":" $plugin
