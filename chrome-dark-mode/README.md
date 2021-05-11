# Chrome dark mode
## Context
On linux Google Chrome's internal pages, such as the settings, can not easily be set to a dark theme.
It is possible to make it run with the `--force-dark-mode` flag though, by editing two lines in the `/usr/share/applications/google-chrome.desktop` file.
This however will be reset everytime Chrome updates. This is what this script is for.
It will add a cron job to the root user, which will try to edit this file every five minutes, in case Chrome had an update.

## Installation
To execute the script once and add the cron job run one of the following commands as root, e.g. with `sudo su -c "COMMAND_HERE"`:
```bash
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/chrome-dark-mode/install.sh | bash
```
```bash
curl -fsSL https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/chrome-dark-mode/install.sh | bash
```

