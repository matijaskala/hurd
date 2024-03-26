# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MACH=gnumach-1.8+git${PV}17
HURD=hurd-0.9.git${PV}17

DESCRIPTION="GNU system headers"
HOMEPAGE="https://www.gnu.org/software/hurd/"
SRC_URI="mirror://debian/pool/main/${MACH:0:1}/${MACH%%-*}/${MACH/-/_}.orig.tar.xz
	mirror://debian/pool/main/${HURD:0:1}/${HURD%%-*}/${HURD/-/_}.orig.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] && [[ ${CATEGORY} == cross-* ]] ; then
	export CTARGET=${CATEGORY#cross-}
fi

src_configure() {
	config() {
		echo ./configure "$@"
		./configure "$@"
	}
	cd "${MACH}" && config \
		--prefix=/usr \
		--host=${CTARGET} || die
}

src_compile() { :; }

src_install() {
	local ddir
	if [[ ${CATEGORY} == cross-* ]] ; then
		ddir=/usr/${CATEGORY#cross-}
	else
		ddir=
	fi

	emake -C "${MACH}" install-data DESTDIR="${ED}"${ddir}
	rm -f "${ED}"${ddir}/usr/share/info/dir

	emake -C "${HURD}" install-headers \
		INSTALL_DATA="/bin/sh \"${WORKDIR}/${HURD}/install-sh\" -c -C -m 644" \
		includedir="${ED}"${ddir}/usr/include infodir=/some/path
}
