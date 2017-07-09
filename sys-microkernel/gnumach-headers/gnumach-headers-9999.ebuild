# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3

DESCRIPTION="GNU Mach microkernel headers"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
EGIT_REPO_URI="git://git.savannah.gnu.org/hurd/gnumach.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/gnumach-${PV}

: ${CTARGET:=${CHOST/x86_64/i686}}

src_configure() {
	[[ ${CATEGORY} == cross-* ]] && CTARGET=${CATEGORY#cross-}
	./configure \
		--prefix= \
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
