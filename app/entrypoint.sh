#!/bin/sh
set -x
chown -R root:root /root/.ssh
/usr/sbin/sshd -D
exec "$@"

