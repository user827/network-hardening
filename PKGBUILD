# Maintainer: me

pkgname=network-hardening
pkgver=1.0.0.r6.gc9756ab
pkgrel=1
pkgdesc='Network hardening'
arch=('any')
depends=(
    nftables
    iptables-nft
)
makedepends=(
    git
)
license=('Apache')
url="https://github.com/user827/network-hardening.git"
#source=("$pkgname::git+$url?signed")
source=("$pkgname::git+file://$PWD?signed")
validpgpkeys=(D47AF080A89B17BA083053B68DFE60B7327D52D6) # user827
sha256sums=(SKIP)

pkgver() {
  cd "$pkgname"
  git describe | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

package() {
  cd "$pkgname"

  # Warn about permissions if not correct
  mkdir -m700 "$pkgdir"/boot

  mkdir -p "$pkgdir"/usr/lib/sysctl.d
  install -m644 sysctls.conf "$pkgdir"/usr/lib/sysctl.d/80-network-hardening.conf

  mkdir -p "$pkgdir"/etc/systemd/resolved.conf.d
  install -m644 resolved-dnssec.conf "$pkgdir"/etc/systemd/resolved.conf.d/dnssec.conf

  mkdir -p "$pkgdir"/usr/lib/systemd/system/systemd-networkd.service.requires
  # Don't start the internet if the firewall fails
  ln -s /usr/lib/systemd/system/nftables.service "$pkgdir"/usr/lib/systemd/system/systemd-networkd.service.requires

  install -m644 network-hardening-check.service "$pkgdir"/usr/lib/systemd/system/
  ln -s /usr/lib/systemd/system/network-hardening-check.service "$pkgdir"/usr/lib/systemd/system/systemd-networkd.service.requires

  mkdir -p "$pkgdir/usr/lib/$pkgname"
  install -D -m755 lib/* "$pkgdir/usr/lib/$pkgname/"

  mkdir -p "$pkgdir"/usr/bin
  install -D -m755 bin/* "$pkgdir"/usr/bin/

  mkdir -p "$pkgdir"/usr/local/bin
  install -D -m755 localbin/* "$pkgdir"/usr/local/bin/

  mkdir -m 700 "$pkgdir"/etc/sudoers.d
  install -m600 sudoers.d/* "$pkgdir"/etc/sudoers.d/

  mkdir -p "$pkgdir"/etc/nftables
  install -m644 nftables.conf "$pkgdir"/etc/nftables/hardening.conf
}

# vim: filetype=PKGBUILD
