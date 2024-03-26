# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MIG=${P/_p/+git}

DESCRIPTION="GNU Mach Interface Generator"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/mig/gnu_mig.html"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${MIG/-/_}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
S=${WORKDIR}/${MIG}

DEPEND="${CATEGORY}/gnu-headers"
RDEPEND="${CATEGORY}/gnu-headers"

if [[ ${CTARGET:-${CHOST}} == ${CHOST} && ${CATEGORY} == cross-* ]] ; then
	export CTARGET=${CATEGORY#cross-}
fi

src_install() {
	default
	rm -r "${ED}"/usr/share || die
}
