Network hardening configs

# Install

Copy aur/PKGBUILD to repo root dir.

```
makepkg --install --syncdeps
```

Afterwards you should configure /etc/nftables.conf and enable nftables.service.
Make sure the following is in your nftables conf:
```
define inet_iface = <name>
include "/etc/nftables/*"
```
