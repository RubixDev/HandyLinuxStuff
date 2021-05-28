#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Please do not run this script as root${NOCOLOR}"
  exit 2
fi

echo -e "${CYAN}Installing terminator${NOCOLOR}"
sudo apt install terminator -y || sudo pacman -Syu terminator --noconfirm || exit 1
echo -e "${GREEN}..done${NOCOLOR}"


echo -e "${CYAN}Installing terminator config file${NOCOLOR}"
mkdir -p ~/.config/terminator || exit 3
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/terminator-plasma-install/terminator.conf > ~/.config/terminator/config || exit 3
echo -e "${GREEN}..done${NOCOLOR}"


echo -e "${CYAN}Downloading forceblur KWin script${NOCOLOR}"
wget -O- "https://github.com/esjeon/kwin-forceblur/releases/download/v0.4.1/forceblur-0.4.1.kwinscript" > ~/forceblur.kwinscript || exit 4
echo -e "${CYAN}Installing script${NOCOLOR}"
plasmapkg2 -i ~/forceblur.kwinscript || plasmapkg2 -u ~/forceblur.kwinscript || exit 4
mkdir -p ~/.local/share/kservices5/
cp ~/.local/share/kwin/scripts/forceblur/metadata.desktop ~/.local/share/kservices5/forceblur.desktop || exit 4
echo -e "${CYAN}Configuring script${NOCOLOR}"
echo -e "\n[Script-forceblur]\npatterns=yakuake\\nurxvt\\nkeepassxc\\nterminator" >> ~/.config/kwinrc || exit 4
echo -e "${CYAN}Disabling script${NOCOLOR}"
perl -i -p -e 's/forceblurEnabled=true/forceblurEnabled=false/' ~/.config/kwinrc || exit 4
echo -e "${CYAN}Reloading KWin${NOCOLOR}"
qdbus org.kde.KWin /KWin reconfigure || exit 4
echo -e "${CYAN}Enabling script${NOCOLOR}"
perl -i -p -e 's/forceblurEnabled=false/forceblurEnabled=true/' ~/.config/kwinrc || exit 4
echo -e "${GREEN}..done${NOCOLOR}"

echo -e "\n${GREEN}Installation of terminator with blur finished!${NOCOLOR}"
