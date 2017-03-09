# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic

DESCRIPTION="Xbox xdvdfs ISO extraction utility"
HOMEPAGE="https://sourceforge.net/projects/xbiso/"
SRC_URI="mirror://sourceforge/xbiso/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_compile() {
	# for this package, interix behaves the same as BSD
	[[ ${CHOST} == *-interix* ]] && append-flags -D_BSD

	econf
	emake || die "emake failed"
}

src_install() {
	dobin xbiso || die "dobin failed."
	dodoc CHANGELOG README
}
