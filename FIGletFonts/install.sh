#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

if [ "$EUID" -ne 0 ]; then
  echo -e "$(BOLD 1)Please run this script as root$(RESET)"
  exit 2
fi

if [ -d /usr/share/figlet/fonts ]; then
  fontfolder="/usr/share/figlet/fonts/"
else
  fontfolder="/usr/share/figlet/"
fi

wget -O- https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/FIGletFonts/fontnames.txt | while read -r fontname; do
  if [ -f "$fontfolder$fontname.flf" ]; then
    echo -e "$(NORMAL 3)Font $(BOLD)$fontname$(NORMAL) is already installed, skipping.$(RESET)"
  else
    echo -e "$(NORMAL 6)Installing $(BOLD)$fontname$(NORMAL) font$(RESET)"
    wget -O- "http://www.figlet.org/fonts/$fontname.flf" > "$fontfolder$fontname.flf"
  fi
done
