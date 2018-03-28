# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
SRC_URI="https://fribidi.org/download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.34.3:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README ChangeLog THANKS TODO )

src_prepare() {
	default
	# Fix compability with dev-libs/glib >= 2.31
	sed -i \
		-e '/include/s:<glib/gstrfuncs.h>:<glib.h>:' \
		-e '/include/s:<glib/gmem.h>:<glib.h>:' \
		charset/fribidi-char-sets.c lib/mem.h || die

	eautoreconf
}

multilib_src_configure() {
	# --with-glib=yes is required for #345621 to ensure "Requires: glib-2.0" is
	# present in /usr/lib/pkgconfig/fribidi.pc
	local myeconfargs=( --with-glib=yes )
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
