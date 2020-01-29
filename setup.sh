#!/bin/bash

# tput variables
highlight=$(tput setaf 3; tput bold)
alert=$(tput setaf 1)
reset=$(tput sgr0)

prompt_begin()
{
  NAME=$1
  echo "${highlight}Installing $NAME...${reset}"
}

prompt_already_installed()
{
  NAME=$1
  echo "${alert}$NAME already installed!${reset}"
}

prompt_finished()
{
  NAME=$1
  echo "${highlight}$NAME installed!${reset}"
}

# Install Xcode Command Line Tools
# echo "${highlight}Installing Xcode Command Line Tools...${reset}"
prompt_begin "Xcode Command Line Tools"
xcode-select -p > /dev/null
if [ $? -eq 0 ]; then
  echo "${alert}Xcode Command Line Tools already installed!${reset}"
else
  xcode-select --install
  sudo xcode-select --switch /Library/Developer/CommandLineTools
  echo "${highlight}Xcode Command Line Tools installed!${reset}"
fi

# Install Homebrew
echo -e "\n${highlight}Installing Homebrew...${reset}"
if [ -x "$(command -v brew)" ]; then
  echo "${alert}Homebrew already installed!${reset}"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "${highlight}Homebrew installed!${reset}"
fi

# Tap Homebrew taps
echo -e "\n${highlight}Tapping essential taps...${reset}"
grep -qxF "homebrew/cask" <(brew tap) || brew tap homebrew/cask
# grep -qxF "homebrew/cask-fonts" <(brew tap) || brew tap homebrew/cask-fonts
# grep -qxF "homebrew/bundle" <(brew tap) || brew tap homebrew/bundle

# Install Hombrew package 'mas-cli' if not already installed
echo -e "\n${highlight}Installing mas-cli...${reset}"
if brew ls --versions mas > /dev/null; then
  echo "${alert}Homebrew package 'mas-cli' is already installed!${reset}"
else
  brew install mas
  echo "${highlight}mas-cli installed!${reset}"
fi

# Install Xcode via 'mas' if not already installed
echo -e "\n${highlight}Installing Xcode...${reset}"
if [ -d /Applications/Xcode.app ]; then
  echo "${alert}Xcode already installed!${reset}"
else
  mas install 497799835
  echo "${highlight}Xcode installed!${reset}"
  sudo xcodebuild -license accept
  curl -fsSL https://raw.githubusercontent.com/wakatime/xcode-wakatime/master/install.sh | sh
fi

# Install XQuartz via Hombrew Cask if not already installed
# echo -e "\n${highlight}Installing XQuartz...${reset}"
# if [ -d /Applications/Utilities/XQuartz.app ]; then
#   echo "${alert}XQuartz already installed!${reset}"
# else
#   # brew cask install xquartz
#   echo "${highlight}XQuartz installed!${reset}"
# fi

# Setup Pyton
echo -e "\n${highlight}Setting Python...${reset}"
# Install pyenv
echo -e "\n${highlight}Installing pyenv...${reset}"
if brew ls --versions pyenv > /dev/null; then
  echo "${alert}Homebrew package 'pyenv' is already installed!${reset}"
else
  brew install pyenv
  eval "$(pyenv init -)"
  echo "${highlight}pyenv installed!${reset}"
fi

# Install pyenv-virtualenv
echo -e "\n${highlight}Installing pyenv-virtualenv...${reset}"
if brew ls --versions pyenv-virtualenv > /dev/null; then
  echo "${alert}Homebrew package 'pyenv-virtualenv' is already installed!${reset}"
else
  brew install pyenv-virtualenv
  eval "$(pyenv virtualenv-init -)"
  echo "${highlight}pyenv-virtualenv installed!${reset}"
fi

# Recommended to install before Python: openssl readline sqlite3 xz zlib
echo -e "\n${highlight}Installing openssl...${reset}"
if brew ls --versions openssl > /dev/null; then
  echo "${alert}Homebrew package 'openssl' is already installed!${reset}"
else
  brew install openssl
  echo "${highlight}openssl installed!${reset}"
fi
echo -e "\n${highlight}Installing readline...${reset}"
if brew ls --versions readline > /dev/null; then
  echo "${alert}Homebrew package 'readline' is already installed!${reset}"
else
  brew install readline
  echo "${highlight}readline installed!${reset}"
fi
echo -e "\n${highlight}Installing sqlite3...${reset}"
if brew ls --versions sqlite3 > /dev/null; then
  echo "${alert}Homebrew package 'sqlite' is already installed!${reset}"
else
  brew install sqlite3
  echo "${highlight}sqlite3 installed!${reset}"
fi
echo -e "\n${highlight}Installing xz...${reset}"
if brew ls --versions xz > /dev/null; then
  echo "${alert}Homebrew package 'xz' is already installed!${reset}"
else
  brew install xz
  echo "${highlight}xz installed!${reset}"
fi
echo -e "\n${highlight}Installing zlib...${reset}"
if brew ls --versions zlib > /dev/null; then
  echo "${alert}Homebrew package 'zlib' is already installed!${reset}"
else
  brew install zlib
  echo "${highlight}zlib installed!${reset}"
fi

# Find the latest Python for pyenv
echo -e "\n${highlight}Installing xxenv-latest...${reset}"
if [ -d "$(pyenv root)"/plugins/xxenv-latest ]; then
  echo "${alert}xxenv-latest already installed!${reset}"
else
  git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest
  echo "${highlight}xxenv-latest installed!${reset}"
fi

# Install the latest Python 2.7 and 3
echo -e "\n${highlight}Installing the latest Python 2.7...${reset}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
LATEST_PYTHON2=$(pyenv latest --print 2.7)
grep -qF $LATEST_PYTHON2 <(pyenv versions) || pyenv install $LATEST_PYTHON2
pyenv global $LATEST_PYTHON2
pip install --upgrade pip
echo "${highlight}Python $LATEST_PYTHON2 installed!${reset}"
echo "${highlight}Preparing virtualenv for Neovim...${reset}"
pyenv virtualenv $LATEST_PYTHON2 neovim-python2
pyenv activate neovim-python2
pip install neovim
pyenv deactivate
echo -e "\n${highlight}Installing the latest Python 3...${reset}"
LATEST_PYTHON3=$(pyenv latest --print)
grep -qF $LATEST_PYTHON3 <(pyenv versions) || pyenv install $LATEST_PYTHON3
pyenv global $LATEST_PYTHON3
pip install --upgrade pip
echo "${highlight}Preparing virtualenv for Neovim...${reset}"
pyenv virtualenv $LATEST_PYTHON3 neovim-python3
pyenv activate neovim-python3
pip install neovim neovim-remote
pyenv deactivate
echo "${highlight}Python $LATEST_PYTHON3 installed!${reset}"

# Install pipenv
echo -e "\n${highlight}Installing pipenv...${reset}"
if brew ls --versions pipenv > /dev/null; then
  echo "${alert}Homebrew package 'pipenv' is already installed!${reset}"
else
  brew install pipenv
  eval "$(pipenv --completion)"
  echo "${highlight}pipenv installed!${reset}"
fi

# Install pipx
echo -e "\n${highlight}Installing pipx...${reset}"
if brew ls --versions pipx > /dev/null; then
  echo "${alert}Homebrew package 'pipx' is already installed!${reset}"
else
  brew install pipx
  pipx ensurepath
  autoload -U bashcompinit
  bashcompinit
  eval "$(register-python-argcomplete pipx)"
  echo "${highlight}pipx installed!${reset}"
fi

# Setup Ruby
echo -e "\n${highlight}Setting Ruby...${reset}"
# Install rbenv
echo -e "\n${highlight}Installing rbenv...${reset}"
if brew ls --versions rbenv > /dev/null; then
  echo "${alert}Homebrew package 'rbenv' is already installed!${reset}"
else
  brew install rbenv
  eval "$(rbenv init -)"
  echo "${highlight}rbenv installed!${reset}"
fi

# Find the latest Ruby for rbenv
echo -e "\n${highlight}Installing xxenv-latest...${reset}"
if [ -d "$(rbenv root)"/plugins/xxenv-latest ]; then
  echo "${alert}xxenv-latest already installed!${reset}"
else
  git clone https://github.com/momo-lab/xxenv-latest.git "$(rbenv root)"/plugins/xxenv-latest
  echo "${highlight}xxenv-latest installed!${reset}"
fi

# Install the latest Ruby
echo -e "\n${highlight}Installing the latest Ruby...${reset}"
LATEST_RUBY=$(rbenv latest --print)
grep -qF $LATEST_RUBY <(rbenv versions) || rbenv install $LATEST_RUBY
rbenv rehash
rbenv global $LATEST_RUBY
echo "${highlight}Ruby $LATEST_RUBY installed!${reset}"

# Install CocoaPods
if [ -x "$(command -v cocoapods)" ]; then
  echo "${alert}CocoaPods already installed!${reset}"
else
  gem install cocoapods
  rbenv rehash
  echo "${highlight}CocoaPods installed!${reset}"
fi

# Install Jazzy
if [ -x "$(command -v jazzy)" ]; then
  echo "${alert}Jazzy already installed!${reset}"
else
  gem install jazzy
  rbenv rehash
  echo "${highlight}Jazzy installed!${reset}"
fi

# Install colorls
if [ -x "$(command -v colorls)" ]; then
  echo "${alert}colorls already installed!${reset}"
else
  gem install colorls
  rbenv rehash
  rehash
  source $(dirname $(gem which colorls))/tab_complete.sh
  echo "${highlight}colorls installed!${reset}"
fi

# Install neovim-ruby
if [ -x "$(gem query -q neovim)" ]; then
  echo "${alert}neovim-ruby already installed!${reset}"
else
  gem install neovim
  rbenv rehash
  echo "${highlight}neovim-ruby installed!${reset}"
fi

# Setup OCaml
# Install OPAM
# Needs to install before OPAM: gpatch
echo -e "\n${highlight}Installing gpatch...${reset}"
if brew ls --versions gpatch > /dev/null; then
  echo "${alert}Homebrew package 'gpatch' is already installed!${reset}"
else
  brew install gpatch
  echo "${highlight}gpatch installed!${reset}"
fi
echo -e "\n${highlight}Installing OPAM...${reset}"
if brew ls --versions opam > /dev/null; then
  echo "${alert}Homebrew package 'OPAM' is already installed!${reset}"
else
  brew install opam
  opam init -a --shell=zsh
  eval $(opam env)
  echo "${highlight}OPAM installed!${reset}"
fi

# Install OCaml
echo -e "\n${highlight}Installing OCaml...${reset}"
if [ -x "$(command -v ocaml)" ]; then
  echo "${alert}OCaml already installed!${reset}"
else
  opam switch create 4.09.0
  eval $(opam env)
  echo "${highlight}OCaml installed!${reset}"
fi

# Install OCaml tools
# Install ocp-indent
echo -e "\n${highlight}Installing ocp-indent...${reset}"
opam install ocp-indent
echo "${highlight}OCaml installed!${reset}"


# Setup Node.js
echo -e "\n${highlight}Installing Node.js...${reset}"
if brew ls --versions node > /dev/null; then
  echo "${alert}Node.js already installed!${reset}"
else
  brew install node
  echo "${highlight}Node.js installed!${reset}"
fi

# Install gitmoji-cli
echo -e "\n${highlight}Installing gitmoji-cli...${reset}"
if [ -x "$(command -v gitmoji)" ]; then
  echo "${alert}gitmoji-cli already installed!${reset}"
else
  npm install -g gitmoji-cli
  echo "${highlight}gitmoji-cli installed!${reset}"
fi

# Install neovim-client
echo -e "\n${highlight}Installing neovim-client...${reset}"
if [ -x "$(npm list -g neovim | grep neovim)" ]; then
  echo "${alert}neovim-client already installed!${reset}"
else
  npm install -g neovim
  echo "${highlight}neovim-client installed!${reset}"
fi

# Setup GnuPG
echo -e "\n${highlight}Installing GPG Suite...${reset}"
if brew cask ls --versions gpg-suite-no-mail > /dev/null; then
  echo "${alert}GPG Suite already installed!${reset}"
else
  brew cask install gpg-suite-no-mail
  gpg --gen-key
  GPGKEY=$(gpg --list-secret-keys --keyid-format LONG | grep '^ ' | tr -d '[:space:]')
  gpg --armor --export $GPGKEY | pbcopy
  echo -e "\n${highlight}PGP public key copied!${reset}"
  open https://github.com/settings/keys
  echo "${highlight}GPG Suite installed!${reset}"
fi

# Install fzf
echo -e "\n${highlight}Installing fzf...${reset}"
if brew ls --versions fzf > /dev/null; then
  echo "${alert}fzf already installed!${reset}"
else
  brew install fzf
  yes | $(brew --prefix)/opt/fzf/install
  echo "${highlight}fzf installed!${reset}"
fi

# Install Neovim
echo -e "\n${highlight}Installing Neovim...${reset}"
if brew ls --versions nvim > /dev/null; then
  echo "${alert}Neovim already installed!${reset}"
else
  brew install neovim
  echo "${highlight}Neovim installed!${reset}"
fi

# Install MacTeX
echo -e "\n${highlight}Installing MacTeX...${reset}"
if brew cask ls --versions mactex > /dev/null; then
  echo "${alert}MacTeX already installed!${reset}"
else
  brew cask install mactex
  echo "${highlight}MacTeX installed!${reset}"
fi

# Git clone my dotfiles
echo -e "\n${highlight}Cloning my dotfiles...${reset}"
if [ -d "$HOME/.dotfiles" ]; then
  echo "${alert}Dotfiles already exist!${reset}"
else
  git clone https://github.com/Zeta611/dotfiles.git $HOME/.dotfiles
  echo "${highlight}Dotfiles cloned!${reset}"
fi

# Install rest of the Homebrew packages
echo -e "\n${highlight}Installing Hombrew packages...${reset}"
brew bundle --file="$HOME/.dotfiles/Brewfile"
echo -e "${highlight}Hombrew packages installed!${reset}"

# Setup dotfiles
echo -e "\n${highlight}Creating symlinks...${reset}"
[ -f "$HOME/.ansiweatherrc" ] || ln -s "$HOME/.dotfiles/ansiweatherrc" "$HOME/.ansiweatherrc"
[ -f "$HOME/.chktexrc" ] || ln -s "$HOME/.dotfiles/chktexrc" "$HOME/.chktexrc"
[ -f "$HOME/.gitconfig" ] || ln -s "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"
[ -f "$HOME/.gitignore_global" ] || ln -s "$HOME/.dotfiles/gitignore_global" "$HOME/.gitignore_global"
[ -f "$HOME/.tmux.conf" ] || ln -s "$HOME/.dotfiles/tmux.conf" "$HOME/.tmux.conf"
[ -f "$HOME/.wakatime.cfg" ] || ln -s "$HOME/.dotfiles/wakatime.cfg" "$HOME/.wakatime.cfg"
[ -f "$HOME/.zshrc" ] || ln -s "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"
[ -f "$HOME/.p10k.zsh" ] || ln -s "$HOME/.dotfiles/p10k.zsh" "$HOME/.p10k.zsh"
[ -d "$HOME/.config/nvim" ] || mkdir -p "$HOME/.config/nvim"
[ -f "$HOME/.config/nvim/init.vim" ] || ln -s "$HOME/.dotfiles/init.vim" "$HOME/.config/nvim/init.vim"
[ -f "$HOME/.config/nvim/plugins.vim" ] || ln -s "$HOME/.dotfiles/plugins.vim" "$HOME/.config/nvim/plugins.vim"
[ -f "$HOME/.config/nvim/coc-settings.json" ] || ln -s "$HOME/.dotfiles/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
[ -f "$HOME/.leptonrc" ] || ln -s "$HOME/.dotfiles/leptonrc" "$HOME/.leptonrc"
[ -f "$HOME/.gnupg/gpg-agent.conf" ] || ln -s "$HOME/.dotfiles/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# Change shell to zsh if it already isn't
[ "$SHELL" != /usr/local/bin/zsh ] && [ "$SHELL" != /bin/zsh ] && chsh -s $(which zsh)

# Setup input-source-switcher for (Neo)vim
echo -e "\n${highlight}Installing input-source-switcher...${reset}"
if [ -x "$(command -v issw)" ]; then
  echo "${alert}input-source-switcher already installed!${reset}"
else
  git clone https://github.com/vovkasm/input-source-switcher.git
  cd input-source-switcher
  mkdir build && cd build
  cmake -DCMAKE_INSTALL_PREFIX:PATH=$HOME ..
  make
  make install
  cd ../..
  # rm -rf input-source-switcher
  echo "${highlight}input-source-switcher installed!${reset}"
fi

# iTerm2 shell integration
[ -f "$HOME/.iterm2_shell_integration.zsh" ] || curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Install zsh plugins
echo -e "\n${highlight}Installing zsh plugins...${reset}"
zsh -c 'source "$HOME/.zshrc"; zplug install'
echo "${highlight}zsh plugins installed!${reset}"

# Setup vim-plug for Neovim
echo -e "\n${highlight}Setting vim-plug for Neovim...${reset}"
mkdir -p "$HOME/.local/share/nvim/site/autoload"
[ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] || curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
echo "${highlight}vim-plug for Neovim set!${reset}"

# Install Adobe Creative Cloud
echo -e "\n${highlight}Installing Adobe Creative Cloud...${reset}"
if [ -d "/Applications/Adobe Creative Cloud" ]; then
  echo "${alert}Adobe Creative Cloud already installed!${reset}"
else
  open "/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"
  echo "${highlight}Adobe Creative Cloud installed!${reset}"
fi

