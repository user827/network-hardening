#!/bin/sh
set -eu

err() {
  echo "$*" >&2
  exit 2
}

check_sym_link() {
  src="$1" dst="$2" dstdir='' linksrc=''
  # in case some of the directories are symbolic links
  dstdir=$(readlink -e "$(dirname "$dst")")
  linksrc=$(realpath -e -s --relative-to "$dstdir" "$src")

  [ -L "$dst" ] && [ "$(readlink "$dst")" = "$linksrc" ] && return 0
  err "'$src' is not symlinked to '$dst' as '$linksrc'"
}

read -r accept_redirects < /proc/sys/net/ipv4/conf/all/accept_redirects
if [ "$accept_redirects" != 0 ]; then
  err "sysctls not applied"
fi

# TODO check policy drop

if ! grep -q '^nameserver 127.0.0.' /etc/resolv.conf; then
  err '/etc/resolv.conf: missing nameserver 127.0.0.'
fi

check_sym_link /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
