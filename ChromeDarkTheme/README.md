# Chrome dark mode
## Context
On linux Google Chrome's internal pages, such as the settings, can not easily be set to a dark theme.
It is possible to make it run with the `--enable-features=WebUIDarkMode` and `--force-dark-mode` flag though, by adding them to the `~/.config/chrome-flags.conf` file.
This script just creates that file with the flags inside.

## Installation
To execute the script once and add the cron job run one of the following commands:
```bash
wget -O- https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/ChromeDarkTheme/install.sh | bash
```
```bash
curl -fsSL https://raw.githubusercontent.com/RubixDev/HandyLinuxStuff/main/ChromeDarkTheme/install.sh | bash
```

