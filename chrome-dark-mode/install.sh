#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

# Test if run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root${NOCOLOR}"
  exit 2
fi

# Execute once now
echo -e "${CYAN}Applying dark mode${NOCOLOR}"
perl -i -p -e 's/(^Exec.+?stable[^-\n]*) --force-dark-mode$/\1/g' /usr/share/applications/google-chrome.desktop || exit 1
perl -i -p -e 's/(^Exec.+?stable[^-\n]*$)/\1 --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop || exit 1
echo -e "${GREEN}..done${NOCOLOR}"

# Add to root crontab
echo -e "${CYAN}Adding command to crontab${NOCOLOR}"
perl -i -p -e 's/^\*\/5 \* \* \* \* perl.+?google-chrome.desktop$//g' /var/spool/cron/crontabs/root || {
  perl -i -p -e 's/^\*\/5 \* \* \* \* perl.+?google-chrome.desktop$//g' /var/spool/cron/root || exit 1
}
echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/crontabs/root || {
  echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/root || exit 1
}
echo -e "${GREEN}..done${NOCOLOR}"
