#!/bin/bash

sudo apt install kvantum-qt5 -y || sudo pacman -Syu kvantum-qt5 --noconfirm

mkdir -p ~/TemporaryOrchisPlasmaThemeInstallDirectory
cd ~/TemporaryOrchisPlasmaThemeInstallDirectory || exit 1

git clone https://github.com/vinceliuice/Orchis-theme.git && {
  Orchis-theme/install.sh -t purple
}

git clone https://github.com/vinceliuice/Orchis-kde.git && {
  Orchis-kde/install.sh
  sudo Orchis-kde/sddm/install.sh
}

git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git && {
  Tela-circle-icon-theme/install.sh -a
}

git clone https://github.com/wsdfhjxc/virtual-desktop-bar.git && {
  if ( pacman --version > /dev/null ); then
    virtual-desktop-bar/scripts/install-dependencies-arch.sh
  elif ( apt --version > /dev/null ); then
    virtual-desktop-bar/scripts/install-dependencies-ubuntu.sh
  else
    echo -e "\033[1;38;5;1mOnly Arch and Ubuntu are supported by this install script\033[0m"
    return 1
  fi && virtual-desktop-bar/scripts/install-applet.sh
}

rm -rf ~/TemporaryOrchisPlasmaThemeInstallDirectory
