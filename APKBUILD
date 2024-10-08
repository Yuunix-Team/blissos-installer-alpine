# Maintainer: Shadichy <shadichy.dev@gmail.com>

pkgname=blissos-installer-data
pkgver=0.0.1
# shellcheck disable=SC2034 # used for git versions, keep around for next time
pkgrel=2
pkgdesc="BlissOS calamares installer data"
url="https://github.com/Yuunix-Team/blissos-installer-alpine.git"
arch="noarch"
license="GPL-2.0-only"

# currently we do not ship any testsuite
options="!check !tracedeps"

provides="blissos-installer"

makedepends_host="git"
[ "${DEBUG#0}" ] || makedepends_host="$makedepends_host shfmt"
makedepends="$makedepends_host"
checkdepends="$makedepends"

depends="
	busybox-binsh
	busybox>=1.28.2-r1
	bash
	"

build() {
	git submodule update --init
	./build.sh
}

package() {
	mkdir -p "$pkgdir"
	mv -t "$pkgdir" build/*
}
