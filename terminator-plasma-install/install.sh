#!/bin/bash
if [ "$EUID" -eq 0 ]; then
  echo 'Please do not run this script as root'
  exit 2
fi

echo 'Installing terminator'
sudo apt install terminator -y || sudo pacman -S terminator || exit 1
echo '..done'

echo 'Installing terminator config file'
mkdir -p ~/.config/terminator || exit 3
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/terminator-plasma-install/terminator.conf > ~/.config/terminator/config || exit 3
echo '..done'

echo 'Installing forceblur KWin script'
wget -O- "https://github.com/esjeon/kwin-forceblur/releases/download/v0.4.1/forceblur-0.4.1.kwinscript" > ~/forceblur.kwinscript || exit 4
plasmapkg2 -i ~/forceblur.kwinscript || plasmapkg2 -u ~/forceblur.kwinscript || exit 4
mkdir -p ~/.local/share/kservices5/ || exit 4
cp ~/.local/share/kwin/scripts/forceblur/metadata.desktop ~/.local/share/kservices5/forceblur.desktop || exit 4
echo '\n[Script-forceblur]\npatterns=yakuake\\nurxvt\\nkeepassxc\\nterminator' >> ~/.config/kwinrc || exit 4
perl -i -p -e 's/forceblurEnabled=true/forceblurEnabled=false/' ~/.config/kwinrc || exit 4
qdbus org.kde.KWin /KWin reconfigure || exit 4
perl -i -p -e 's/forceblurEnabled=false/forceblurEnabled=true/' ~/.config/kwinrc || exit 4
echo '..done'

echo '\nInstallation of terminator with blur finished!'

