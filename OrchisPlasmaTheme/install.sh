#!/bin/bash

sudo apt install kvantum-qt5 -y || sudo pacman -Syu kvantum-qt5 --noconfirm

mkdir -p ~/TemporaryOrchisPlasmaThemeInstallDirectory
cd ~/TemporaryOrchisPlasmaThemeInstallDirectory || exit 2

git clone https://github.com/vinceliuice/Orchis-theme.git || exit 3
Orchis-theme/install.sh -t purple || exit 3

git clone https://github.com/vinceliuice/Orchis-kde.git || exit 4
Orchis-kde/install.sh || exit 4
sudo Orchis-kde/sddm/install.sh || exit 4

git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git || exit 5
Tela-circle-icon-theme/install.sh -a || exit 5

cd || exit 6
rm -rf ~/TemporaryOrchisPlasmaThemeInstallDirectory || exit 6
