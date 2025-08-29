#!/bin/sh

CHOICE=$(printf "Shutdown\nReboot\nSuspend" | wofi --dmenu --width=200 --lines=5  --hide-search)

case "$CHOICE" in
  Shutdown)
    systemctl poweroff
    ;;
  Reboot)
    systemctl reboot
    ;;
  Suspend)
    powerctl suspend
    ;;
  *)
    ;;
esac
