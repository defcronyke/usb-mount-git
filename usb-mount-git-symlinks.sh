#!/bin/sh

cd /opt/git; for i in `ls -1d /media/*/*.git`; do ln -s "$i" 2>/dev/null || true; done

cd `ls -1d /opt/git/new/*.git | head -n 1`
GIT_DISCOVERY_ACROSS_FILESYSTEM=1 git instaweb --restart

