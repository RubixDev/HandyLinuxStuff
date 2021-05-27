#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root"
  exit 2
fi

wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/figlet-fonts-installer/fontnames.txt | while read fontname; do wget -O- http://www.figlet.org/fonts/$fontname.flf > /usr/share/figlet/$fontname.flf; done

