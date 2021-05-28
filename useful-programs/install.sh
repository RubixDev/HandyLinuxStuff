#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root${NOCOLOR}"
  exit 2
fi

apt update
apt upgrade -y
apt install sudo vim neofetch mc ranger htop wget curl xclip git openjdk-11-jdk openjfx python3.9 python3-pip python3-tk lolcat cmatrix fortune cowsay tmux snapd zsh wine figlet tree -y || exit 1

# Install bashtop
pip3 install bpytop --upgrade

# Install bat
curl -L -o ~/bat_0.18.0_amd64.deb https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb
dpkg -i ~/bat_0.18.0_amd64.deb
rm ~/bat_0.18.0_amd64.deb

# Install keyboard layout
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/US-DE_Keyboard_Layout/install.sh | bash


# Execute per user
getent passwd | while IFS=: read -r name _ uid _ _ home shell; do # name password uid gid gecos home shell
  if [ -d "$home" ] && [ "$(stat -c %u "$home")" = "$uid" ]; then
    if [ -n "$shell" ] && [ "$shell" != "/bin/false" ] && [ "$shell" != "/usr/sbin/nologin" ]; then
      # If not root
      if [ "$uid" -ne 0 ]; then
        # Install terminator
        su -c "wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/terminator-plasma-install/install.sh | bash" "$name"
      fi

      # Install SpaceVim
      su -c "curl -sLf https://spacevim.org/install.sh | bash" "$name"

      # Install zsh zish theme
      su -c "wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/install.sh | bash" "$name"
      chsh -s /usr/bin/zsh "$name"

      # Set tmux to use 256 colors
      su -c "echo 'set -g default-terminal \"screen-256color\"' > ~/.tmux.conf" "$name"

      # Setup aliases
      su -c "echo \"alias tmux='tmux -2'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias zalias='vim ~/.zshrc'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias setclip='xclip -selection c'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias getclip='xclip -selection c -o'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias con='ssh contabo'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias poof='poweroff'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias btop='bpytop'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias cp='cp -iv'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias myip='curl ipinfo.io/ip'\" >> ~/.zshrc" "$name"
      su -c "echo -e \"alias lelcat='bash -c \\\"\\\$(wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/meow.sh)\\\"'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias sshconf='sudo vim /etc/ssh/sshd_config'\" >> ~/.zshrc" "$name"
      su -c "echo \"alias rr='rm -r'\" >> ~/.zshrc" "$name"
    fi
  fi
done
