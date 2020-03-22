# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="GNU Mach microkernel headers"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach.html"
EGIT_REPO_URI="git://git.savannah.gnu.org/hurd/gnumach.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

: ${CTARGET:=${CHOST/x86_64/i686}}

src_prepare() {
	eautoreconf
}

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
	rm "${D}"${ddir}${EPREFIX}/usr/share/info/dir || die
}
