#!/bin/bash

# config
LOCATION="$HOME/.local"
USER="luke"

# packages
PACKAGES_BASE="base-devel sudo make zsh xorg-server xorg-xinit firefox git kitty kitty-terminfo kitty-shell-integration linux-lts-headers linux-lts greetd rust"
PACKAGES_DRIVERS="nvidia-open-dkms mesa vulkan-icd-loader xf86-video-vesa"
PACKAGES_WIRELESS="bluez bluez-libs blueberry iwd"
PACKAGES_AUDIO="pipewire pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio wireplumber libwireplumber pavucontrol easyeffects"
PACKAGES_GAMES="steam lutris discord"
PACKAGES_MISC="feh picom"
PACKAGES_AUR="zenergy-dkms-git"
PACKAGES="$PACKAGES_BASE $PACKAGES_DRIVERS $PACKAGES_WIRELESS $PACKAGES_AUDIO $PACKAGES_GAMES $PACKAGES_MISC"

PACMAN="pacman -Sy --noconfirm --needed $PACKAGES"

# root commands
if [ "$1" != "root-done" ]; then
  if [ "$(whoami)" == "root" ]; then

    # enable multilib
    sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

    # set parallel downloads
    sed -E -i "/ParallelDownloads = [0-9]+/"'s/[0-9]+/10/' /etc/pacman.conf
    sed -E -i "/ParallelDownloads = [0-9]+/"'s/^#//' /etc/pacman.conf

    # disable mouse acceleration
    cp $LOCATION/env/dotfiles/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf

    # packages
    $PACMAN

    # sudo
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >/etc/sudoers.d/nopass

    # user
    if ! [ $(cat /etc/passwd | grep "$USER") ]; then
      useradd -G wheel -m -p t $USER
      passwd -d $USER
    fi

    if [ "$1" == "run-as-root" ]; then
      exit 0
    fi

  else

    su root -c "$0 run-as-root"

  fi
fi

if [ "$(whoami)" != "$USER" ]; then
  su $USER -c "$0 root-done"
  exit 0
fi

# cloning
mkdir -p $LOCATION
cd $LOCATION
rm -rf ./env
git clone --recurse-submodules -j4 --depth 1 -b main https://github.com/lukeo102/linux-config.git env
cd env
git submodule update --init

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
makepkg -si --no-confirm

cd ../dwm
sudo make clean install

cd ../slstatus
sudo make clean install

cd ../dmenu
sudo make clean install

# dotfiles
DOTFILES=$LOCATION/env/dotfiles

ln -s $DOTFILES/zsh/.oh-my-zsh ~/
ln -s $DOTFILES/zsh/.zshrc ~/
sudo chsh -s $(which zsh) $USER

AUTOSTART_LOCATION="$HOME/.local/share/dwm/"
mkdir -p $AUTOSTART_LOCATION
ln -s $DOTFILES/autostart.sh $AUTOSTART_LOCATION

mkdir -p ~/.config
ln -s $DOTFILES/nvim ~/.config/nvim

chmod +x $DOTFILES/xinitrc
ln -s $DOTFILES/xinitrc ~/.xinitrc

# AUR packages
paru -Sy $PACKAGES_AUR
