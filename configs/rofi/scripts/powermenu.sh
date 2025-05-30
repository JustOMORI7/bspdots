#!/bin/bash

# Rofi power menu seçenekleri
chosen=$(printf "Power Off\nReboot\nSuspend\nLock\nExit" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    "Power Off") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Suspend") systemctl suspend && betterlockscreen -l blur 0.5 ;;
    "Lock") betterlockscreen -l blur 0.5;;
    "Exit") bspc quit ;;
    *) exit 0 ;;
esac
