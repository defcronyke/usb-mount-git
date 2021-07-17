#!/bin/sh

cd /opt/git; for i in `ls -1d /media/*/*.git`; do ln -s "$i" 2>/dev/null || true; done

sudo chown -R pi: /home/pi/git/.git/gitweb
sudo chown pi: /home/pi/git/.git/pid

sudo su -s /bin/bash -c "GIT_DISCOVERY_ACROSS_FILESYSTEM=1 git instaweb --restart" -g pi pi

