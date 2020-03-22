# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU Mach microkernel"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"

BDEPEND="sys-microkernel/mig"

: ${CTARGET:=${CHOST/x86_64/i686}}

src_configure() {
	[[ ${CATEGORY} == cross-* ]] && CTARGET=${CATEGORY#cross-}
	unset LDFLAGS
	./configure \
		--prefix=/usr \
		--exec-prefix= \
		--host=${CTARGET} || die
}

src_compile() {
	emake gnumach.gz
}

src_install() {
	if [[ ${CATEGORY} == cross-* ]] ; then
		ddir=/usr/${CATEGORY#cross-}
	else
		ddir=
	fi
	dodir ${ddir}/boot
	insinto ${ddir}/boot
	doins gnumach.gz
}
