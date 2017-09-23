# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit eutils

DESCRIPTION="A fake root environment by means of LD_PRELOAD and SysV IPC (or TCP) trickery"
HOMEPAGE="https://packages.qa.debian.org/f/fakeroot.html"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE="acl static-libs test"

DEPEND="acl? ( sys-apps/acl )
	test? ( app-arch/sharutils )
	sys-libs/libcap"

DOCS="AUTHORS BUGS DEBUG README doc/README.saving"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.19-no-acl_h.patch
}

src_configure() {
	export ac_cv_header_sys_acl_h=$(usex acl)

	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
