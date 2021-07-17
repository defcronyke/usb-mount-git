#!/bin/sh

cd /opt/git; for i in `ls -1d /media/*/*.git`; do ln -s "$i" 2>/dev/null || true; done

cd /opt/git
sudo su -s /bin/bash -c "GIT_DISCOVERY_ACROSS_FILESYSTEM=1 git instaweb --restart" -g pi pi

