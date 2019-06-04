#!/bin/bash

# tput variables
highlight=$(tput setaf 3; tput bold)
alert=$(tput setaf 1)
reset=$(tput sgr0)

# Install Xcode Command Line Tools
echo "${highlight}Installing Xcode Command Line Tools...${reset}"
xcode-select -p > /dev/null
if [ $? -eq 0 ]; then
  echo "${alert}Xcode Command Line Tools already installed!${reset}"
else
  xcode-select --install
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
grep -qxF "homebrew/cask-fonts" <(brew tap) || brew tap homebrew/cask-fonts
grep -qxF "homebrew/bundle" <(brew tap) || brew tap homebrew/bundle

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
fi

# Install XQuartz via Hombrew Cask if not already installed
echo -e "\n${highlight}Installing XQuartz...${reset}"
if [ -d /Applications/Utilities/XQuartz.app ]; then
  echo "${alert}XQuartz already installed!${reset}"
else
  brew cask install xquartz
  echo "${highlight}XQuartz installed!${reset}"
fi

# Git clone my dotfiles
echo -e "\n${highlight}Cloning my dotfiles...${reset}"
if [ -d "$HOME/.dotfiles" ]; then
  echo "${alert}Dotfiles already exist!${reset}"
else
  git clone https://github.com/Zeta611/Dotfiles.git $HOME/.dotfiles
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
mkdir -p "$HOME/.config/nvim"
[ -f "$HOME/.config/nvim/init.vim" ] || ln -s "$HOME/.dotfiles/init.vim" "$HOME/.config/nvim/init.vim"
[ -f "$HOME/.leptonrc" ] || ln -s "$HOME/.dotfiles/leptonrc" "$HOME/.leptonrc"
[ -f "$HOME/.gnupg/gpg-agent.conf" ] || ln -s "$HOME/.dotfiles/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
[ -f "/Applications/openWithVim.app" ] || osacompile -o "/Applications/openWithVim.app" "$HOME/.dotfiles/openWithVim.applescript"

# Adds path to brew-installed zsh to /etc/shells if it doesn't exist
echo -e "\n${highlight}Setting /etc/shells...${reset}"
grep -qxF $(which zsh) /etc/shells || echo $(which zsh) | sudo tee -a /etc/shells
# Change shell to zsh if it already isn't
[ "$SHELL" != /usr/local/bin/zsh ] && chsh -s $(which zsh)

# Setup git
echo -e "\n${highlight}Setting git...${reset}"
grep -qF "gitmoji-cli" <(npm list -g --depth=0) || npm i -g gitmoji-cli
echo "${highlight}Git setup!${reset}"

# Setup colorls
echo -e "\n${highlight}Setting colorls...${reset}"
grep -qF "colorls" <(gem query --local) || gem install colorls
echo "${highlight}colorls setup!${reset}"

# iTerm2 shell integration
[ -f "$HOME/.iterm2_shell_integration.zsh" ] || curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Install zsh plugins
echo -e "\n${highlight}Installing zsh plugins...${reset}"
zsh -c 'source "$HOME/.zshrc"; zplug install'
echo "${highlight}zsh plugins installed!${reset}"

# Setup input-source-switcher for Neovim
echo -e "\n${highlight}Installing input-source-switcher...${reset}"
if [ -x "$(command -v issw)" ]; then
  echo "${alert}input-source-switcher already installed!${reset}"
else
  git clone https://github.com/vovkasm/input-source-switcher.git
  cd input-source-switcher
  mkdir build && cd build
  cmake ..
  make
  make install
  cd ../..
  rm -rf input-source-switcher
  echo "${highlight}input-source-switcher installed!${reset}"
fi

# Setup Python for Neovim
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo -e "\n${highlight}Installing xxenv-latest...${reset}"
if [ -d "$(pyenv root)"/plugins/xxenv-latest ]; then
  echo "${alert}xxenv-latest already installed!${reset}"
else
  git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest
  echo "${highlight}xxenv-latest installed!${reset}"
fi

echo -e "\n${highlight}Setting Python2 environment for neovim...${reset}"
if grep -qF "neovim-python2" <(pyenv versions); then
  echo "${alert}Python2 environment for neovim already exists!${reset}"
else
  LATEST_PYTHON2=$(pyenv latest --print 2.7)
  grep -qF $LATEST_PYTHON2 <(pyenv versions) || pyenv install $LATEST_PYTHON2
  pyenv virtualenv $LATEST_PYTHON2 neovim-python2
  pyenv activate neovim-python2
  pip install --upgrade pip
  pip install pynvim flake8
  pyenv deactivate
  echo "${highlight}Python2 environment for neovim set!${reset}"
fi

echo -e "\n${highlight}Setting Python3 environment for neovim...${reset}"
if grep -qF "neovim-python3" <(pyenv versions); then
  echo "${alert}Python3 environment for neovim already exists!${reset}"
else
  LATEST_PYTHON3=$(pyenv latest --print)
  grep -qF $LATEST_PYTHON3 <(pyenv versions) || pyenv install $LATEST_PYTHON3
  pyenv virtualenv $LATEST_PYTHON3 neovim-python3
  pyenv activate neovim-python3
  pip install --upgrade pip
  pip install pynvim flake8
  pyenv deactivate
  echo "${highlight}Python3 environment for neovim set!${reset}"
fi

# Setup vim-plug for Neovim
echo -e "\n${highlight}Setting vim-plug for Neovim...${reset}"
mkdir -p "$HOME/.local/share/nvim/site/autoload"
[ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] || curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
echo "${highlight}vim-plug for Neovim set!${reset}"

# Install Cocoapods
echo -e "\n${highlight}Installing Cocoapods...${reset}"
sudo gem install cocoapods
echo "${highlight}Cocoapods installed!${reset}"

# Install Adobe Creative Cloud
echo -e "\n${highlight}Installing Adobe Creative Cloud...${reset}"
open "/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"
echo "${highlight}Adobe Creative Cloud installed!${reset}"

