#!/bin/bash

perl -i -pe 's/^alias.*//g' ~/.zshrc
perl -0777 -i -pe 's/(^\n\n)+//gm' ~/.zshrc
