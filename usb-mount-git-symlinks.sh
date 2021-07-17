#!/bin/sh

cd /opt/git; for i in `ls -1d /media/*/*.git`; do ln -s "$i" 2>/dev/null || true; done

GIT_DISCOVERY_ACROSS_FILESYSTEM=1 git instaweb --restart

