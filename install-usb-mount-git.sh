#!/bin/sh

ln -s /opt/git $HOME/git 2>/dev/null
sudo cp -f usb-mount-git@.service /etc/systemd/system/
sudo cp -f 99-usb-mount-git.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo systemctl daemon-reload

