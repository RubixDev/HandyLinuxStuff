#!/bin/bash

perl -i -p -e 's/(^Exec.+?stable[^-\n]*$)/\1 --force-dark-mode/g' /usr/share/applications/google-chrome.desktop

