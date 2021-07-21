#!/bin/sh

cd /opt/git

# Force-unmount dead mountpoints found in /media
echo "Checking if any mount points under /media are dead or inaccessible..."

for i in `lsblk | awk '{print $7}' | tail -n +2 | grep "/media/"`; do
  ls "$i" || \
  echo "Broken or inaccessible mount point detected in /media, so we're force-unmounting it in case it's stuck: $i" && \
  sudo umount -f "$i" && \
  echo "Attempting to re-mount it once, but if it fails we won't try again." && \
  sudo mount "`mount | grep "$i" | awk '{print $1}'`" "$i" || \
  echo "Re-mounting dead or inaccessible mount point failed: $i"
done

# Add symlinks for all "*.git/" folders on usb disks to /opt/git/
for i in `find /media -type d -name "*.git" 2>/dev/null | sed 's/\/.git$//g'`; do ln -s "$i" 2>/dev/null || true; done

# Add symlinks for all folders under /media/ to /opt/git/
sudo ln -s /media /opt/git/media 2>/dev/null || true

for i in `ls -1ad /media/*`; do
	sudo ln -s "$i" 2>/dev/null || true
done

# Update symlink for /opt/git/new/ to point to usb disk with most free space available.
unlink /opt/git/new; ln -s `df | grep /media/ | sort -nrk4 | head -n1 | awk '{print $NF}'` /opt/git/new 2>/dev/null; ls /opt/git/new || unlink /opt/git/new; ln -s /media/local /opt/git/new 2>/dev/null || true

sudo chown -R pi: /home/pi/git/.git/gitweb
sudo chown pi: /home/pi/git/.git/pid

sudo su -s /bin/bash -c "git instaweb --restart" -g pi pi
