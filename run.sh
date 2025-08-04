#!/bin/sh

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
exit 0

# user
useradd -G wheel -p t luke
passwd -d luke
su luke

# audio
system-ctl --user enable pipewire
system-ctl --user enable wireplumber

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
cd zsh
ln -s .oh-my-zsh ~/
ln -s .zshrc ~/
sudo chshell -s $(which zsh) luke
