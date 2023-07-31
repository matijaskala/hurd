# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU Mach microkernel"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV/_p/+git}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"
S=${WORKDIR}/${P/_p/+git}

BDEPEND="sys-microkernel/mig"

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
