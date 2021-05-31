#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

# Test if run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "$(BOLD 1)Please run this script as root$(RESET)"
  exit 2
fi

# Execute once now
echo -e "$(NORMAL 6)Applying dark mode$(RESET)"
perl -i -p -e 's/(^Exec.+?stable[^-\n]*) --force-dark-mode$/\1/g' /usr/share/applications/google-chrome.desktop || exit 1
perl -i -p -e 's/(^Exec.+?stable[^-\n]*$)/\1 --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop || exit 1
echo -e "$(NORMAL 2)..done$(RESET)"

# Add to root crontab
echo -e "$(NORMAL 6)Adding command to crontab$(RESET)"
perl -i -p -e 's/^\*\/5 \* \* \* \* perl.+?google-chrome.desktop$//g' /var/spool/cron/crontabs/root || {
  perl -i -p -e 's/^\*\/5 \* \* \* \* perl.+?google-chrome.desktop$//g' /var/spool/cron/root || exit 1
}
echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/crontabs/root || {
  echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/root || exit 1
}
echo -e "$(NORMAL 2)..done$(RESET)"
