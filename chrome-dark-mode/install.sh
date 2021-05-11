#!/bin/bash

# Test if run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root"
  exit 2
fi

# Execute once now
perl -i -p -e 's/(^Exec.+?stable[^-\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop || exit 1

# Add to root crontab
echo "*/5 * * * * perl -i -p -e 's/(^Exec.+?stable[^-\\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop" >> /var/spool/cron/crontabs/root || exit 1

