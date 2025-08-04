#!/bin/bash

# config
LOCATION="$HOME/.local"
USER="luke"

# packages
PACKAGES_BASE="base-devel sudo make zsh xorg-server firefox git kitty linux-lts-headers linux-lts greetd"
PACKAGES_DRIVERS="nvidia-open-dkms mesa vulkan-icd-loader xf86-video-vesa"
PACKAGES_WIRELESS="bluez bluez-libs blueberry iwd"
PACKAGES_AUDIO="pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio wireplumber libwireplumber pavucontrol easyeffects"
PACKAGES_GAMES="steam lutris discord"
PACKAGES_MISC="feh picom"
PACKAGES_AUR="zenergy-dkms-git"
PACKAGES="$PACKAGES_BASE $PACKAGES_DRIVERS $PACKAGES_WIRELESS $PACKAGES_AUDIO $PACKAGES_GAMES $PACKAGES_MISC"

PACMAN="pacman -Sy --noconfirm --needed $PACKAGES"

if [ $(whoami) -ne root ]; then
  su root
fi

echo "$PACMAN"
$PACMAN
exit 0

# user
if [ $(cat /etc/passwd | grep "$USER") ]; then
  useradd -G wheel -p t $USER
  passwd -d $USER
fi
su $USER

# cloning
mkdir -p $LOCATION
cd $LOCATION
rm -rf ./env
git clone --recursive-submodules -j4 --depth 1 https://github.com/lukeo102/linux-config.git env
cd env

# autologin
sudo systemctl enable greetd
sudo rm /etc/greetd/config.toml
sudo ln -s $LOCATION/env/dotfiles/greetd/config.toml /etc/greetd/config.toml

# audio
systemctl --user enable pipewire
systemctl --user enable wireplumber

# installs
cd programs

cd paru
makepkg -si

cd ../dwm
sudo make clean install

cd ../slstatus
sudo make clean install

cd ../dmenu
sudo make clean install

# dotfiles
cd ../../dotfiles

ln -s zsh/.oh-my-zsh ~/
ln -s zsh/.zshrc ~/
sudo chshell -s $(which zsh) luke

AUTOSTART_LOCATION="$HOME/.local/share/dwm/"
mkdir -p $AUTOSTART_LOCATION
ln -s autostart.sh $AUTOSTART_LOCATION

ln -s nvim ~/.config/nvim

chmod +x xinitrc
ln -s xinitrc ~/.xinitrc
