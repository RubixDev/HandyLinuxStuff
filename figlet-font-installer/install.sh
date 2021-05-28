#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root${NOCOLOR}"
  exit 2
fi

wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/figlet-font-installer/fontnames.txt | while read -r fontname; do
  if [ -f "/usr/share/figlet/$fontname.flf" ]; then
    echo -e "${YELLOW}Font $fontname is already installed, skipping.${NOCOLOR}"
  else
    echo -e "${CYAN}Installing $fontname font${NOCOLOR}"
    wget -O- "http://www.figlet.org/fonts/$fontname.flf" > "/usr/share/figlet/$fontname.flf"
  fi
done