# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit base

DESCRIPTION="Library for handling root privilege"
#HOMEPAGE="http://www.j10n.org/libspt/index.html"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${PN}-gentoo.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc CHANGES
}
