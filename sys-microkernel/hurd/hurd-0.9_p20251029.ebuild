# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

HURD=${P/_p/.git}

DESCRIPTION="GNU Hurd"
HOMEPAGE="https://www.gnu.org/software/hurd/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${HURD/-/_}.orig.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 ncurses parted zlib"
RESTRICT="mirror"
S=${WORKDIR}/${HURD}

COMMON_DEPEND="
	dev-libs/libgcrypt:=[static-libs(-)]
	bzip2? ( app-arch/bzip2[static-libs(+)] )
	ncurses? ( sys-libs/ncurses:=[static-libs] )
	parted? ( sys-apps/util-linux[static-libs(+)] sys-block/parted[static-libs(+)] )
	zlib? ( sys-libs/zlib[static-libs(+)] )"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	app-shells/bash"

src_prepare() {
	eapply "${FILESDIR}"/lhurduser.diff
	eapply "${FILESDIR}"/MAKEDEV_null.diff
	default
	eautoreconf
}

src_configure() {
	./configure \
		--prefix="${ED}" \
		--host=${CHOST} \
		--enable-static-progs=iso9660fs,ext2fs,ufs \
		--disable-profile \
		$(use_with parted) \
		$(use_with bzip2 libbz2) \
		$(use_with zlib libz) \
		$(use_enable ncurses ncursesw) \
		|| die
}

src_install() {
	emake install

	rm -r "${ED}"/include || die

	dodir /usr/lib
	mv "${ED}"/lib/*.a "${ED}"/usr/lib || die

	local flags=( ${CFLAGS} ${LDFLAGS} -Wl,--verbose )
	if $(tc-getLD) --version | grep -q 'GNU gold' ; then
		local d="${T}/bfd-linker"
		mkdir -p "${d}"
		ln -sf $(which ${CHOST}-ld.bfd) "${d}"/ld
		flags+=( -B"${d}" )
	fi
	local output_format=$($(tc-getCC) "${flags[@]}" 2>&1 | sed -n 's/^OUTPUT_FORMAT("\([^"]*\)",.*/\1/p')
	[[ -n ${output_format} ]] && output_format="OUTPUT_FORMAT ( ${output_format} )"
	for i in "${ED}"/lib/*.so ; do
		local lib=${i#${ED}/lib}
		cat > "${ED}"/usr/lib/${lib} <<-END_LDSCRIPT
/* GNU ld script
   Since Gentoo has critical dynamic libraries in /lib, and the static versions
   in /usr/lib, we need to have a "fake" dynamic lib in /usr/lib, otherwise we
   run into linking problems.  This "fake" dynamic lib is a linker script that
   redirects the linker to the real lib.  And yes, this works in the cross-
   compiling scenario as the sysroot-ed linker will prepend the real path.

   See bug https://bugs.gentoo.org/4411 for more info.
 */
${output_format}
GROUP ( /lib/$(readlink "${i}") )
END_LDSCRIPT
		rm ${i} || die
		fperms a+x /usr/lib/${lib} || die "could not change perms on ${lib}"
	done

	for i in login ps uptime vmstat w ; do
		rm "${ED}"/bin/${i} || die
	done
	for i in fsck halt reboot ; do
		rm "${ED}"/sbin/${i} || die
	done
}
