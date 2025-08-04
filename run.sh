#!/bin/sh

# config
INSTALL_LOCATION="~/.local/installs"

# packages
PACKAGES_BASE="base-devel sudo make zsh xorg-server firefox git kitty linux-lts-headers linux-lts"
PACKAGES_DRIVERS="nvidia-open-dkms mesa vulkan-icd-loader xf86-video-vesa"
PACKAGES_WIRELESS="bluez bluez-libs blueberry iwd"
PACKAGES_AUDIO="pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio wireplumber libwireplumber pavucontrol"
PACKAGES_GAMES="steam lutris discord"
PACKAGES_AUR="zenergy-dkms-git"
PACKAGES="$PACKAGES_BASE $PACKAGES_DRIVERS $PACKAGES_WIRELESS $PACKAGES_AUDIO $PACKAGES_GAMES"

PACMAN="pacman -Sy --noconfirm --needed $PACKAGES"

echo "$PACMAN"
$PACMAN
# $PACMAN
exit 0
# user
useradd -G wheel -p t luke
passwd -d luke
su luke

# audio
system-ctl --user enable pipewire
system-ctl --user enable wireplumber

# installs
mkdir -p $INSTALL_LOCATION
cd $INSTALL_LOCATION

# paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# dwm
cd ..
git clone https://github.com/lukeo102/linux-config.git dwm
cd dwm
git checkout dwm-desktop
sudo make clean install

# slstatus
cd ..
git clone https://github.com/lukeo102/linux-config.git slstatus
cd slstatus
git checkout slstatus
sudo make clean install

# dmenu
cd ..
git clone https://github.com/lukeo102/linux-config.git dmenu
cd dmenu
git checkout dmenu
sudo make clean install

# zsh
cd ..
git clone https://github.com/lukeo102/linux-config.git zsh
cd zsh
git checkout zsh
cp -r .oh-my-zsh ~/
cp -f .zshrc ~/
sudo chshell -s $(which zsh) luke
