# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
# Load zplug
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix libffi)/lib/pkgconfig/"

export PATH=/usr/local/opt/ruby/bin:$PATH
PATH=$PATH:$(ruby -e 'puts Gem.bindir')
[[ $TMUX != "" ]] && export TERM="screen-256color"
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

zplug "romkatv/powerlevel10k", \
    use:powerlevel9k.zsh-theme

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

# load pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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

set -o vi

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
alias nvr='~/.pyenv/versions/neovim-python3/bin/nvr'
alias refreshnvr='rm /tmp/nvimsocket'

alias src='source ~/.zshrc'
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias tmdisablethrottle='sudo sysctl debug.lowpri_throttle_enabled=0'
alias tmenablethrottle='sudo sysctl debug.lowpri_throttle_enabled=1'

alias gis='git status'
alias gic='git commit -S'
alias gica='git commit -a -S'
alias gip='git push'
alias gipf='git push -f'
alias gil='git log'

alias ctags='/usr/local/bin/ctags'
# zprof

function truecolor() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

# opam configuration
test -r /Users/jay/.opam/opam-init/init.zsh && . /Users/jay/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
