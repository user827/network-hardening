#!/bin/sh
set -eu

# WARNING: insecure path

/usr/bin/ip link set lo up
# NOTE assume sudo has not cleared the env
# recomended: Defaults!/usr/bin/mynetjail !env_reset, !secure_path, !requiretty, closefrom_override, !use_pty
# ensure same quoting used as above
unset SUDO_COMMAND SUDO_GID SUDO_UID USERNAME
exec /usr/bin/setcuruser /usr/bin/env -u SUDO_USER -- "$@"
