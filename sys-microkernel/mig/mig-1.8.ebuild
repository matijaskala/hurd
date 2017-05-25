# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="GNU Mach Interface Generator"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/mig/gnu_mig.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="${CATEGORY}/gnumach-headers"
RDEPEND="${CATEGORY}/gnumach-headers"

if [[ ${CTARGET:-${CHOST}} == ${CHOST} && ${CATEGORY} == cross-* ]] ; then
	export CTARGET=${CATEGORY#cross-}
fi

src_install() {
	default
	rm -r "${ED}"/usr/share || die
}
