# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="EmACT, a fork of Conroy's MicroEmacs"
HOMEPAGE="http://www.eligis.com/emacs/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="sys-libs/ncurses:0=
	X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with X x)
}

src_install() {
	emake INSTALL="${D}"/usr install
	#dodoc README
}
