#!/bin/sh

# Add symlinks for all "*.git/" folders on usb disks to /opt/git/
cd /opt/git; for i in `ls -1d /media/*/*.git`; do ln -s "$i" 2>/dev/null || true; done

# Update symlink for /opt/git/new/ to point to usb disk with most free space available.
unlink /opt/git/new; ln -s `df | grep /media/ | sort -nrk4 | head -n1 | awk '{print $NF}'` /opt/git/new 2>/dev/null; ls /opt/git/new || unlink /opt/git/new; ln -s /media/local /opt/git/new 2>/dev/null || true

sudo chown -R pi: /home/pi/git/.git/gitweb
sudo chown pi: /home/pi/git/.git/pid

sudo su -s /bin/bash -c "git instaweb --restart" -g pi pi
#sudo su -s /bin/bash -c "GIT_DISCOVERY_ACROSS_FILESYSTEM=1 git instaweb --restart" -g pi pi

