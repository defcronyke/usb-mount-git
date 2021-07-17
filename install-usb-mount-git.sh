#!/bin/sh

sudo mkdir -p /opt/git
sudo chown $USER: /opt/git
if [ ! -f "$HOME/git" ]; then
	ln -s /opt/git $HOME/git 2>/dev/null
fi
sudo cp -f usb-mount-git@.service /etc/systemd/system/
sudo cp -f 99-usb-mount-git.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo systemctl daemon-reload

