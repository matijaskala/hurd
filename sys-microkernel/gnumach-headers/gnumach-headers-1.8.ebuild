# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU Mach microkernel headers"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
SRC_URI="mirror://gnu/gnumach/gnumach-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}/gnumach-${PV}

: ${CTARGET:=${CHOST/x86_64/i686}}

src_configure() {
	[[ ${CATEGORY} == cross-* ]] && CTARGET=${CATEGORY#cross-}
	./configure \
		--prefix=/usr \
		--exec-prefix= \
		--host=${CTARGET} || die
}

src_compile() { :; }

src_install() {
	if [[ ${CATEGORY} == cross-* ]] ; then
		ddir=/usr/${CATEGORY#cross-}
	else
		ddir=
	fi
	emake install-data DESTDIR="${ED}"${ddir}
	rm "${ED}"${ddir}/share/info/dir || die
}
