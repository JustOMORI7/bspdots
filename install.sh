#!/bin/bash

clear

echo "Press any key to continue. Ctrl + C to cancel."
read -n 1 -s -r # wait key press

if command -v paru &>/dev/null; then
  echo "paru found! Installing packages..."
else
  echo "paru not found. Installing paru"
  cd ~
  git clone https://aur.archlinux.org/paru-bin.git
  cd paru-bin
  makepkg -si
  echo "paru installed! Installing packages..."
fi

paru -S sddm bspwm sxhkd polybar picom dunst nitrogen alacritty thunar thunar-volman gvfs gvfs-mtp brightnessctl-bin maim feh betterlockscreen xsetroot qt6ct nwg-look lxappearance bibata-cursor-theme-bin kvantum papirus-icon-theme materia-gtk-theme kvantum-theme-materia rofi playerctl ttf-cascadia-code xdg-user-dirs

xdg-user-dirs-update

echo "Copying configuration files..."

rm -rf ~/.config/alacritty ~/.config/bspwm ~/.config/gtk-2.0 ~/.config/gtk-3.0 ~/.config/Kvantum ~/.config/nitrogen ~/.config/nwg-look ~/.config/picom ~/.config/polybar ~/.config/qt6ct ~/.config/rofi ~/.config/sxhkd

cp -rf ~/bspdots/configs/* ~/.config
mv ~/.config/.Xresources ~

mkdir -p ~/.local/share/rofi/themes
mv ~/.config/rofi-nord.rasi ~/.local/share/rofi/themes

sudo echo "QT_QPA_PLATFORMTHEME=qt6ct" >>/etc/environment

sudo systemctl enable sddm

mkdir -p ~/Pictures/wallpapers
cp ~/bspdots/wallpapers/* ~/Pictures/wallpapers

echo "Installation finished. Please reboot your system."
