# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="GNU Hurd system headers"
HOMEPAGE="https://www.gnu.org/software/hurd/"
SRC_URI="mirror://gnu/hurd/hurd-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/hurd-${PV}

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
