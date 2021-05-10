#!/bin/sh

# Check dependencies
zsh --version > /dev/null || {
  echo 'zsh is not installed. Please make sure it is correctly installed on your system.'
  exit 127
}

wget --version > /dev/null || {
  curl --version > /dev/null || {
    echo 'You have neither wget nor curl installed. Please install at least one of them.'
    exit 127
  }
}

git --version > /dev/null || {
  echo 'git is not installed. Please make sure it is correctly installed on your system.'
  exit 127
}

# Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit 1
}

# Install necessary plugins
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || exit 1
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search || exit 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || exit 1

# Install theme
wget https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/zish.zsh-theme
mv zish.zsh-theme ~/.oh-my-zsh/custom/

# Apply plugins
perl -i -pe 's/^(plugins=\(.*?)\)/\1 zsh-autosuggestions history-substring-search zsh-syntax-highlighting)/g' ~/.zshrc || exit 1

# Set theme
perl -i -pe 's/^ZSH_THEME="zish"' ~/.zshrc
echo 'ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >> ~/.zshrc

