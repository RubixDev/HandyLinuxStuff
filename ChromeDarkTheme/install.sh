#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

# Test if run as root
if [ "$EUID" -eq 0 ]; then
  echo -e "$(BOLD 1)Please do not run this script as root$(RESET)"
  exit 1
fi

# Make backup of flag file
echo -e "$(NORMAL 6)Backing up chrome flag config file$(RESET)"
if [ -f ~/.config/chrome-flags.conf ]; then
  mv ~/.config/chrome-flags.conf ~/.config/chrome-flags.conf.bak || exit 2
fi
echo -e "$(NORMAL 2)..done$(RESET)"

# Setting flags
echo -e "$(NORMAL 6)Creating chrome flag config file$(RESET)"
echo "--enable-features=WebUIDarkMode --force-dark-mode" > ~/.config/chrome-flags.conf
echo -e "$(NORMAL 2)..done$(RESET)"
