# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

case ${PV} in
*_pre*) UP_PV="${PV%_pre*}-WIP-${PV#*_pre}" ;;
*)      UP_PV=${PV} ;;
esac

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Standard EXT2/EXT3/EXT4 filesystem utilities"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/e2fsprogs/${PN}-${UP_PV}.tar.gz
	mirror://kernel/linux/kernel/people/tytso/e2fsprogs/v${UP_PV}/${PN}-${UP_PV}.tar.gz
	elibc_mintlib? ( mirror://gentoo/${PN}-1.42.9-mint-r1.patch.xz )"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 -x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~m68k-mint"
IUSE="fuse nls static-libs elibc_FreeBSD"

RDEPEND="~sys-libs/${PN}-libs-${PV}
	>=sys-apps/util-linux-2.16
	fuse? ( sys-fs/fuse:0 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
	sys-apps/texinfo"

S="${WORKDIR}/${P%_pre*}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.41.8-makefile.patch
	"${FILESDIR}"/${PN}-1.40-fbsd.patch
	"${FILESDIR}"/${PN}-1.42.13-fix-build-cflags.patch #516854

	# Upstream patches (can usually removed with next version bump)
)

src_prepare() {
	if [[ ${CHOST} == *-mint* ]] ; then
		PATCHES+=( "${WORKDIR}"/${PN}-1.42.9-mint-r1.patch )
	fi

	default

	# blargh ... trick e2fsprogs into using e2fsprogs-libs
	rm -rf doc
	sed -i -r \
		-e 's:@LIBINTL@:@LTLIBINTL@:' \
		-e '/^(STATIC_)?LIB(COM_ERR|SS)/s:[$][(]LIB[)]/lib([^@]*)@(STATIC_)?LIB_EXT@:-l\1:' \
		-e '/^DEP(STATIC_)?LIB(COM_ERR|SS)/s:=.*:=:' \
		MCONFIG.in || die "muck libs" #122368
	sed -i -r \
		-e '/^LIB_SUBDIRS/s:lib/(et|ss)::g' \
		Makefile.in || die "remove subdirs"
	ln -s $(which mk_cmds) lib/ss/ || die

	# Avoid rebuild
	echo '#include_next <ss/ss_err.h>' > lib/ss/ss_err.h
}

src_configure() {
	# Keep the package from doing silly things #261411
	export VARTEXFONTS="${T}/fonts"

	# needs open64() prototypes and friends
	append-cppflags -D_GNU_SOURCE

	local myeconfargs=(
		--with-root-prefix="${EPREFIX}/"
		--enable-symlink-install
		$(tc-is-static-only || echo --enable-elf-shlibs)
		$(tc-has-tls || echo --disable-tls)
		--without-included-gettext
		$(use_enable fuse fuse2fs)
		$(use_enable nls)
		--disable-libblkid
		--disable-libuuid
		--disable-fsck
		--disable-uuidd
	)
	ac_cv_path_LDCONFIG=: econf "${myeconfargs[@]}"
	if [[ ${CHOST} != *-uclibc ]] && grep -qs 'USE_INCLUDED_LIBINTL.*yes' config.{log,status} ; then
		eerror "INTL sanity check failed, aborting build."
		eerror "Please post your ${S}/config.log file as an"
		eerror "attachment to https://bugs.gentoo.org/show_bug.cgi?id=81096"
		die "Preventing included intl cruft from building"
	fi
}

src_compile() {
	emake V=1 COMPILE_ET=compile_et MK_CMDS=mk_cmds

	# Build the FreeBSD helper
	if use elibc_FreeBSD ; then
		cp "${FILESDIR}"/fsck_ext2fs.c .
		emake V=1 fsck_ext2fs
	fi
}

src_install() {
	# need to set root_libdir= manually as any --libdir options in the
	# econf above (i.e. multilib) will screw up the default #276465
	emake \
		STRIP=: \
		root_libdir="${EPREFIX}/usr/$(get_libdir)" \
		DESTDIR="${D}" \
		install install-libs
	dodoc README RELEASE-NOTES

	insinto /etc
	doins "${FILESDIR}"/e2fsck.conf

	# Move shared libraries to /lib/, install static libraries to
	# /usr/lib/, and install linker scripts to /usr/lib/.
	gen_usr_ldscript -a e2p ext2fs
	# configure doesn't have an option to disable static libs :/
	use static-libs || find "${D}" -name '*.a' -delete

	if use elibc_FreeBSD ; then
		# Install helpers for us
		into /
		dosbin "${S}"/fsck_ext2fs
		doman "${FILESDIR}"/fsck_ext2fs.8

		# filefrag is linux only
		rm \
			"${ED%/}"/usr/sbin/filefrag \
			"${ED%/}"/usr/share/man/man8/filefrag.8 || die
	fi
}
