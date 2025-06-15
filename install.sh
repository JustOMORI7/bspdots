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

paru -S --noconfirm polkit-kde-agent sddm bspwm sxhkd polybar dunst nitrogen alacritty thunar thunar-volman gvfs gvfs-mtp brightnessctl maim feh betterlockscreen xorg-xsetroot qt6ct nwg-look lxappearance bibata-cursor-theme-bin kvantum papirus-icon-theme materia-gtk-theme kvantum-theme-materia rofi playerctl ttf-cascadia-mono-nerd xdg-user-dirs
paru -S --noconfirm libev cmake uthash meson ninja libconfig dbus libglvnd libxcb xcb-util-renderutil xcb-util-image pixman

cd ~
git clone https://github.com/jonaburg/picom
cd picom
meson setup --buildtype=release . build
ninja -C build
sudo ninja -C build install

xdg-user-dirs-update

echo "Copying configuration files..."

rm -rf ~/.config/alacritty ~/.config/bspwm ~/.config/gtk-2.0 ~/.config/gtk-3.0 ~/.config/Kvantum ~/.config/nitrogen ~/.config/nwg-look ~/.config/picom ~/.config/polybar ~/.config/qt6ct ~/.config/rofi ~/.config/sxhkd

cp -rf ~/bspdots/configs/* ~/.config
mv ~/.config/Xresources ~/.Xresources

mkdir -p ~/.local/share/rofi/themes
mv ~/.config/rofi-nord.rasi ~/.local/share/rofi/themes/rofi-nord.rasi

echo "QT_QPA_PLATFORMTHEME=qt6ct" | sudo tee -a /etc/environment

sudo systemctl enable sddm

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc

mkdir -p ~/Pictures/wallpapers
cp ~/bspdots/wallpapers/* ~/Pictures/wallpapers

rm -rf ~/picom
rm -rf ~/paru-bin

echo "Installation finished. Please reboot your system."
