# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3

DESCRIPTION="GNU Mach microkernel"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
EGIT_REPO_URI="git://git.savannah.gnu.org/hurd/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

DEPEND="sys-microkernel/mig"
RDEPEND=""

: ${CTARGET:=${CHOST/x86_64/i686}}

src_configure() {
	[[ ${CATEGORY} == cross-* ]] && CTARGET=${CATEGORY#cross-}
	unset LDFLAGS
	./configure \
		--prefix= \
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
