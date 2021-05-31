#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

# Check dependencies
zsh --version > /dev/null || {
  echo -e "$(BOLD 1)zsh is not installed.$(NORMAL) Please make sure it is correctly installed on your system. A list on how to install it on many distributions can be found here: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms$(RESET)"
  exit 127
}

wget --version > /dev/null || {
  curl --version > /dev/null || {
    echo -e "$(BOLD 1)You have neither wget nor curl installed.$(NORMAL) Please install at least one of them.$(RESET)"
    exit 127
  }
}

git --version > /dev/null || {
  echo -e "$(BOLD 1)git is not installed.$(NORMAL) Please make sure it is correctly installed on your system.$(RESET)"
  exit 127
}

# Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 1
}

# Install necessary plugins
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions || exit 1
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search || exit 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || exit 1

# Install theme
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/zish.zsh-theme > ~/.oh-my-zsh/custom/themes/zish.zsh-theme || {
  curl -fsSL https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/zish.zsh-theme > ~/.oh-my-zsh/custom/themes/zish.zsh-theme || exit 1
}

# Apply plugins
perl -i -p -e 's/^(plugins=\(.*?)\)/\1 zsh-autosuggestions history-substring-search zsh-syntax-highlighting)/g' ~/.zshrc || exit 1

# Set theme
perl -i -p -e 's/^ZSH_THEME.*$/ZSH_THEME="zish"/g' ~/.zshrc || exit 1
echo "ZSH_AUTOSUGGEST_STRATEGY=(history completion)" >> ~/.zshrc || exit 1

echo "ZSH_HIGHLIGHT_STYLES[arg0]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[command]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[alias]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[builtin]=fg=6,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[default]=fg=12" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[path]=fg=12" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=5" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[assign]=fg=14" >> ~/.zshrc || exit 1


echo -e "$(NORMAL 2)Installation finished.$(NORMAL) You can set zsh as your default shell using 'chsh -s $(which zsh)'$(RESET)"
