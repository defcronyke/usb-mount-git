#!/usr/bin/env bash

install_usb_mount_git() {
  sudo groupadd $USER 2>/dev/null

  sudo mkdir -p /opt/git
  sudo chown $USER: /opt/git
  if [ ! -d "$HOME/git" ]; then
    ln -s /opt/git $HOME/git 2>/dev/null
  fi

  cat usb-mount-git@.service.tmpl | \
  sed "s/{USER}/$USER/g" | \
  tee /etc/systemd/system/usb-mount-git@.service

  sudo cp -f 99-usb-mount-git.rules /etc/udev/rules.d/
  sudo udevadm control --reload-rules && sudo udevadm trigger
  sudo systemctl daemon-reload

  sudo cp -f usb-mount-git-symlinks.sh /etc/cron.d/
  
  cat usb-mount-git-cron.tmpl | \
  sed "s/{USER}/$USER/g" | \
  sudo tee /etc/cron.d/usb-mount-git-cron
}

install_usb_mount_git
