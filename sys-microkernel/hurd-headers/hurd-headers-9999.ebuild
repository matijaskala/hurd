# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="GNU Hurd system headers"
HOMEPAGE="https://www.gnu.org/software/hurd/"
EGIT_REPO_URI="https://git.savannah.gnu.org/git/hurd/hurd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

src_configure() { :; }

src_compile() { :; }

src_install() {
	if [[ ${CATEGORY} == cross-* ]] ; then
		ddir=/usr/${CATEGORY#cross-}
	else
		ddir=
	fi
	dodir ${ddir}/include
	emake install-headers \
		INSTALL_DATA="/bin/sh \"${S}/install-sh\" -c -C -m 644" \
		includedir="${ED}"${ddir}/include infodir=/some/path
}
