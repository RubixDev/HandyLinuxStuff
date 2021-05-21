#!/bin/bash

# Test if run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root"
  exit 2
fi

# Execute once now
echo 'Applying dark mode'
perl -i -p -e 's/(^Exec.+?stable[^-\n]*) --force-dark-mode$/\1/g' /usr/share/applications/google-chrome.desktop || exit 1
perl -i -p -e 's/(^Exec.+?stable[^-\n]*$)/\1 --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop || exit 1
echo '..done'

# Add to root crontab
echo 'Adding command to crontab'
perl -i -p -e 's/^\*\/5 \* \* \* \* perl.+?google-chrome.desktop$//g' /var/spool/cron/crontabs/root
echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/crontabs/root || exit 1
echo '..done'

