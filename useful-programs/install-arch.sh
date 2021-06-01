#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
#NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

if [ "$EUID" -ne 0 ]; then
  echo -e "$(BOLD 1)Please run this script as root$(RESET)"
  exit 2
fi

pacman -Syu --needed base-devel
install () {
  for package in "$@"; do
    pacman -Qi "$package" > /dev/null || pacman -S "$package" --noconfirm || exit 1
  done
}
install terminator vim kcron zsh onefetch discord sl neofetch mc ranger htop wget curl xclip git jdk8-openjdk jdk11-openjdk java8-openjfx java11-openjfx python-pip lolcat cmatrix fortune-mod cowsay tmux wine figlet tree bpytop bat sddm sddm-kcm kvantum-qt5 ttf-liberation ttf-jetbrains-mono || exit 1

# Install keyboard layout
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/US-DE_Keyboard_Layout/install.sh | bash

# Install FIGlet fonts
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/figlet-font-installer/install.sh | bash

# AUR packages
aur_install () {
  useradd aurinstallfromroothelper -m
  passwd -d aurinstallfromroothelper
  printf 'aurinstallfromroothelper ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow aurinstallfromroothelper passwordless sudo

  for package in "$@"; do
    pacman -Qi "$package" > /dev/null || {
      if ( pacman -Qi yay > /dev/null ); then
        sudo -u aurinstallfromroothelper bash -c "yay -S $package --noconfirm"
      else
        sudo -u aurinstallfromroothelper bash -c "cd ~ && git clone https://aur.archlinux.org/$package.git && cd $package && makepkg -si --noconfirm"
      fi
    }
  done

  userdel -r aurinstallfromroothelper
}
aur_install yay google-chrome github-desktop jetbrains-toolbox

# Apply Chrome dark theme
perl -i -pe 's/(^Exec.+?stable[^-\n]*) --force-dark-mode$/\1/g' /usr/share/applications/google-chrome.desktop
perl -i -pe 's/(^Exec.+?stable[^-\n]*$)/\1 --enable-features=WebUIDarkMode --force-dark-mode/g' /usr/share/applications/google-chrome.desktop

# Execute per user
getent passwd | while IFS=: read -r name _ uid _ _ home shell; do # name password uid gid gecos home shell
  if [ -d "$home" ] && [ "$(stat -c %u "$home")" = "$uid" ]; then
    if [ -n "$shell" ] && [ "$shell" != "/bin/false" ] && [ "$shell" != "/usr/sbin/nologin" ] && [ "$shell" != "/usr/bin/nologin" ] && { [ "$uid" -eq 0 ] || [ "$uid" -ge 1000 ]; }; then
      # If not root
      if [ "$uid" -ne 0 ]; then
        # Install terminator
        su -c "wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/terminator-plasma-install/install.sh | bash" "$name"

        # Install Orchis theme
        mkdir -p ~/TemporaryOrchisPlasmaThemeInstallDirectory
        cd ~/TemporaryOrchisPlasmaThemeInstallDirectory && {

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
              pacman -S cmake extra-cmake-modules gcc make --noconfirm
            elif ( apt --version > /dev/null ); then
              apt install cmake extra-cmake-modules g++ qtbase5-dev qtdeclarative5-dev libqt5x11extras5-dev libkf5plasma-dev libkf5globalaccel-dev libkf5xmlgui-dev -y
            else
              echo -e "$(BOLD 1)Only Arch and Ubuntu are supported by this install script$(RESET)"
              return 1
            fi && virtual-desktop-bar/scripts/install-applet.sh
          }
        }
        rm -rf ~/TemporaryOrchisPlasmaThemeInstallDirectory
      fi

      # Install SpaceVim
      su -c "curl -sLf https://spacevim.org/install.sh | bash" "$name"

      # Install zsh zish theme
      su -c "wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/install.sh | bash" "$name"
      chsh -s /usr/bin/zsh "$name"

      # Set tmux to use 256 colors
      su -c "echo 'set -g default-terminal \"screen-256color\"' > ~/.tmux.conf" "$name"

      # Setup aliases
      perl -i -pe 's/^alias.*//g' "$home/.zshrc"
      su -c "wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/AliasSetup/install.sh | bash" "$name"
    fi
  fi
done
